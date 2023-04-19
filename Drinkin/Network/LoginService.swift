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
    
    func fetch(accessToken: String, completion: @escaping () -> Void) {
        var accessTokenConversionEndpoint = AccessTokenConversionEndpoint()
        accessTokenConversionEndpoint.insertTokenQueryValue(token: accessToken)
        
        provider.fetchData(endpoint: accessTokenConversionEndpoint,
                           parser: Parser<LoginToken>()) { parsedData in
            LoginService.accessToken = parsedData.accessToken

            completion()
        }
    }
}



