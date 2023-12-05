//
//  Provider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/19.
//

import Foundation
import Combine

protocol Provider {
    func fetchData<T: Decodable>(endpoint: EndpointMakeable) -> AnyPublisher<T, APIError>
    func postData<B: Encodable, T: Decodable>(endpoint: EndpointMakeable, bodyItem: B) -> AnyPublisher<T, APIError>
}

struct DefaultProvider: Provider {
    private let tokenManager: TokenManager
    
    init(tokenManager: TokenManager) {
        self.tokenManager = tokenManager
    }
    
    //MARK: - FetchData
    
    func fetchData<T: Decodable>(endpoint: EndpointMakeable) -> AnyPublisher<T, APIError> {
        var request = endpoint.makeURLRequest()
        
        do {
            if let accessToken = try tokenManager.readToken(tokenType: TokenType.accessToken) {
                request!.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }

        } catch {
            print("keychain Error")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request!)
            .tryMap { data, response in
                let httpResponse = response as! HTTPURLResponse
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 401:
                    throw APIError.unauthorized
                case 404:
                    throw APIError.notFound
                default:
                    throw APIError.networkError(NSError(domain: "Network", code: httpResponse.statusCode, userInfo: nil))
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is URLError:
                    return APIError.networkError(error)
                case is DecodingError:
                    return APIError.decodingError
                default:
                    return error as? APIError ?? APIError.networkError(error)
                }
            }
            .catch { error in
                if case APIError.unauthorized = error {
                    return renewAccessTokenPublisher().flatMap { accessToken in
                        var newRequest = request
                        print("\(accessToken)")
                        do {
                            try tokenManager.updateToken(tokenType: TokenType.accessToken, token: accessToken.accessToken)
                            
                            if let accessToken = try tokenManager.readToken(tokenType: TokenType.accessToken) {
                                newRequest!.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                            }
                        } catch {
                            print("keychain Error")
                        }
                        
                        return URLSession.shared.dataTaskPublisher(for: newRequest!)
                            .tryMap { data, response in
                                let httpResponse = response as! HTTPURLResponse
                                switch httpResponse.statusCode {
                                case 200..<300:
                                    return data
                                case 401:
                                    throw APIError.unauthorized
                                case 404:
                                    throw APIError.notFound
                                default:
                                    throw APIError.networkError(NSError(domain: "Network", code: httpResponse.statusCode, userInfo: nil))
                                }
                            }
                            .decode(type: T.self, decoder: JSONDecoder())
                            .mapError { error in
                                switch error {
                                case is URLError:
                                    return APIError.networkError(error)
                                case is DecodingError:
                                    return APIError.decodingError
                                default:
                                    return error as? APIError ?? APIError.networkError(error)
                                }
                            }.eraseToAnyPublisher()
                    }.eraseToAnyPublisher()
                }
                
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    //MARK: - PostData
    
    func postData<B: Encodable, T: Decodable>(endpoint: EndpointMakeable, bodyItem: B) -> AnyPublisher<T, APIError> {
        var request = endpoint.makeJsonPostRequest(bodyItem: bodyItem)
        
        do {
            if let accessToken = try tokenManager.readToken(tokenType: TokenType.accessToken) {
                request!.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }

        } catch {
            print("keychain Error")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request!)
            .tryMap { data, response in
                let httpResponse = response as! HTTPURLResponse
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 401:
                    throw APIError.unauthorized
                case 404:
                    throw APIError.notFound
                default: break
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is URLError:
                    return APIError.networkError(error)
                case is DecodingError:
                    return APIError.decodingError
                default:
                    return error as? APIError ?? APIError.networkError(error)
                }
            }
            .catch { error in
                if case APIError.unauthorized = error {
                    return renewAccessTokenPublisher().flatMap { accessToken in
                        var newRequest = request
                        
                        do {
                            try tokenManager.updateToken(tokenType: TokenType.accessToken, token: accessToken.accessToken)
                            try newRequest!.setValue("Bearer \(String(describing: tokenManager.readToken(tokenType: TokenType.accessToken)))", forHTTPHeaderField: "Authorization")
                        } catch {
                            print("keychain Error")
                        }
                        
                        return URLSession.shared.dataTaskPublisher(for: newRequest!)
                            .tryMap { data, response in
                                let httpResponse = response as! HTTPURLResponse
                                switch httpResponse.statusCode {
                                case 200..<300:
                                    return data
                                case 401:
                                    throw APIError.unauthorized
                                case 404:
                                    throw APIError.notFound
                                default:
                                    throw APIError.networkError(NSError(domain: "Network", code: httpResponse.statusCode, userInfo: nil))
                                }
                            }
                            .decode(type: T.self, decoder: JSONDecoder())
                            .mapError { error in
                                switch error {
                                case is URLError:
                                    return APIError.networkError(error)
                                case is DecodingError:
                                    return APIError.decodingError
                                default:
                                    return error as? APIError ?? APIError.networkError(error)
                                }
                            }.eraseToAnyPublisher()
                    }.eraseToAnyPublisher()
                }
                
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - RenewAccessToken
    
    func renewAccessTokenPublisher() -> AnyPublisher<AccessToken, APIError> {
        var renewAccessTokenEndpoint = RenewAccessTokenEndpoint()
        do {
            if let refreshToken = try tokenManager.readToken(tokenType: TokenType.refreshToken) {
                renewAccessTokenEndpoint.insertQuery(queryParameter: "refresh_token",
                                                     queryValue: refreshToken)
            }
        } catch {
            
        }
        
        let request = renewAccessTokenEndpoint.makeURLRequest()
        
        return URLSession.shared.dataTaskPublisher(for: request!)
            .tryMap { data, response in
                let httpResponse = response as! HTTPURLResponse
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 401:
                    throw APIError.refreshTokenExpired
                case 404:
                    throw APIError.notFound
                default:
                    throw APIError.networkError(NSError(domain: "Network", code: httpResponse.statusCode, userInfo: nil))
                }
            }
            .decode(type: AccessToken.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is URLError:
                    return APIError.networkError(error)
                case is DecodingError:
                    return APIError.decodingError
                default:
                    switch error as? APIError {
                    case .refreshTokenExpired:
                        do {
                            try tokenManager.deleteToken(tokenType: TokenType.refreshToken)
                            try tokenManager.deleteToken(tokenType: TokenType.accessToken)
                        } catch {
                            
                        }
                    default:
                        break
                    }
                    
                    return error as? APIError ?? APIError.networkError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
