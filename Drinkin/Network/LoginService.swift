//
//  LoginService.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

class LoginService {
    let provider = Provider()
    static var accessToken: String?
    
    func fetch1(accessToken: String, completion: @escaping () -> Void) {
        var loginEndpoint = LoginEndpoint()
        loginEndpoint.insertTokenQueryValue(token: accessToken)
        
        provider.fetchData(endpoint: loginEndpoint,
                           parser: Parser<LoginToken>()) { parsedData in
            LoginService.accessToken = parsedData.accessToken

            completion()
        }
    }
    
    func fetch2(accessToken: String, completion: @escaping () -> Void) {
        var refreshEndpoint = RefreshEndpoint()
        refreshEndpoint.insertAuthorization(key: accessToken)
        
        provider.fetchData(endpoint: refreshEndpoint,
                           parser: Parser<LoginToken>()) { parsedData in
            
            print(parsedData)
            completion()
        }
    }
}
