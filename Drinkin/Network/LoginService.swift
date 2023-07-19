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
        
        print("1231231231231232131")
        
        URLSession.shared.dataTaskPublisher(for: request!)
            .tryMap {
                print("qweqweqweqweqwewqeqwe")
                print($0.response)
                return $0.data }
            .decode(type: LoginToken.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                // completion 처리
                print("ASDASDASDSADSADASDASDASD")
                print(completion)
            }, receiveValue: { value in
                print("ZXCZXCXCZXCZXZXZXXZCXZCZ")
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
