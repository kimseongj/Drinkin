//
//  KakaoAuthViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/07.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthViewModel: ObservableObject {
    static var validAccessToken: String?
    var loginService = LoginService()
    
    init() {
        print("KakaoAuthVM - init() called")
    }
    
    func handleKakaoLogin() {
        print("KakoAuthVM - handleKakao")
        
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    guard let accessToken = oauthToken?.accessToken else { return }
                    
                    self.loginService.fetch(accessToken: accessToken) 
                }
            }
        } else { // 카카오톡 실행이 안될 경우
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    guard let accessToken = oauthToken?.accessToken else { return }
            
                    self.loginService.fetch(accessToken: accessToken)
                }
            }
        }
    }
}
