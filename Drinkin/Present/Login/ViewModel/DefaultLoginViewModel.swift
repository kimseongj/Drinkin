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

protocol LoginViewModel {
    var tokenExistencePublisher: Published<Bool>.Publisher { get }
    
    func handleKakaoLogin()
    func performRequests()
}

final class DefaultLoginViewModel: NSObject, ObservableObject, LoginViewModel {
    private let loginRepository: LoginRepository
    private var canelBag: Set<AnyCancellable> = []
    var loginService = LoginService()
    lazy var authorizationController = ASAuthorizationController(authorizationRequests: [createRequest()])
    @Published var tokenExistence: Bool = false
    var tokenExistencePublisher: Published<Bool>.Publisher { $tokenExistence }
    
    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
        super.init()
        createAccount()
    }
    
    func checkTokenExistence() {
        tokenExistence = LoginManager.shared.checkTokenExistence()
    }
}

//MARK: -KakaoLogin
extension DefaultLoginViewModel {
    func handleKakaoLogin() {
        print("KakoAuthVM - handleKakao")
        
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    guard let accessToken = oauthToken?.accessToken else { return }
                    
                    self.loginService.fetch(accessToken: accessToken) {
                        self.tokenExistence = true
                    }
                }
            }
        } else { // 카카오톡 실행이 안될 경우
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    guard let accessToken = oauthToken?.accessToken else { return }
            
                    self.loginService.fetch(accessToken: accessToken) {
                        self.tokenExistence = true
                    }
                }
            }
        }
    }
}

//MARK: - AppleLogin
extension DefaultLoginViewModel: ASAuthorizationControllerDelegate {
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

            if let authorizationCode = appleIDCredential.authorizationCode {
                guard let accessToken = String(data: authorizationCode, encoding: .utf8) else {
                    print("aapleLogin eeeeeerorr")
                    return }
                
                self.loginService.fetch(accessToken: accessToken) {
                    self.tokenExistence = true
                    print("aappllee login success")
                }
            }
            
            tokenExistence = true
        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
