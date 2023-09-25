//
//  LoginService.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation
import Combine

class LoginService {
    var provider = LoginProvider()
    var cancellableBeg: Set<AnyCancellable> = []
    
    static var accessToken: String?
    static var refreshToken: String?
    
    func fetch(accessToken: String) {
       let request = provider.makePostRequest(endpoint: AccessTokenConversionEndpoint(), accessToken: accessToken, holdedCocktailList: [1, 2, 3, 4, 5])
        
        provider.postAccessTokenAndHoldedItem(request: request)
    }
}
