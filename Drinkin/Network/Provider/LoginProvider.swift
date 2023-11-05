//
//  LoginProvider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import Foundation
import Combine

class LoginProvider {
    private let keychainManager = TokenManager()
    private var cancelBag: Set<AnyCancellable> = []

    func makePostRequest(endpoint: EndpointMakeable, accessToken: String, holdedCocktailList: [Int]) -> URLRequest? {
        guard var request = endpoint.makeURLRequest() else { return nil }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = FirstLogin(accessToken: accessToken, holdedItemList: holdedCocktailList)
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            print("PostError")
        }
        
        return request
    }
    
    func postAccessTokenAndHoldedItem(request: URLRequest?, completion: @escaping () -> Void) {
        guard let request else { return }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data).decode(type: FirstLoginResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }, receiveValue: { [weak self] in
                guard let self = self else { return }
                
                do {
                    try self.keychainManager.saveToken(tokenType: TokenType.accessToken, token: $0.accessToken)
                    completion()
                } catch {
                    print("saveError")
                }
            }).store(in: &cancelBag)
    }
}
