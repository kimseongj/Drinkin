//
//  LoginService.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation
import Combine

class LoginService {
    let provider = Provider()
    let repository = Repository()
    
    static var accessToken: String?
    static var refreshToken: String?
    
    func fetch(accessToken: String, completion: @escaping () -> Void) {
        var accessTokenConversionEndpoint = AccessTokenConversionEndpoint()
        accessTokenConversionEndpoint.insertTokenQueryValue(accessToken: accessToken)
        let request = accessTokenConversionEndpoint.makeURLRequest()
        
        URLSession.shared.dataTaskPublisher(for: request!)
            .tryMap {
                print($0.response)
                return $0.data }
            .decode(type: LoginToken.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                // completion 처리
                print(completion)
            }, receiveValue: { value in
                print("ASDASDSADASDASDSADzxczxcxzczxcxz")
                print(value)
            })

        
        
//        print(accessTokenConversionEndpoint)
//
//        repository.fetchPublisher(endpoint: accessTokenConversionEndpoint)
        
    
//        provider.fetchData(endpoint: accessTokenConversionEndpoint,
//                           parser: Parser<LoginToken>()) { parsedData in
//            LoginService.accessToken = parsedData.accessToken
//            LoginService.refreshToken = parsedData.refreshToken
//            print(LoginService.accessToken)
//            print("Refresh : " + LoginService.refreshToken!)
//            completion()
//        }
    }
  
    func refreshAccessToken() {
        var refreshEndPoint = RefreshEndpoint()
        //refreshEndPoint.
    }
}
