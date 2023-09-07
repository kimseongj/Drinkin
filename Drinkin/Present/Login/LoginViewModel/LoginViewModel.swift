//
//  LoginViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/07.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

class LoginViewModel: NSObject, ObservableObject {
    static var validAccessToken: String?
    var loginService = LoginService()
    lazy var authorizationController = ASAuthorizationController(authorizationRequests: [createRequest()])
    
    override init() {
        super.init()
        createAccount()
    }
}

//MARK: -KakaoLogin
extension LoginViewModel {
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

//MARK: - AppleLogin
extension LoginViewModel: ASAuthorizationControllerDelegate {
    func createRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        return request
    }
    
    func createAccount() {
        authorizationController.delegate = self
        
    }
    
    func performRequests() {
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
                
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")

        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
