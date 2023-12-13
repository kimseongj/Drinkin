//
//  LoginUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/12.
//

import Foundation
import Combine

protocol LoginUsecase {
    func loginWithKakao(accessToken: String)
    func loginWithApple(accessToken: String)
}

final class DefaultLoginUsecase: LoginUsecase {
    private let loginRepository: LoginRepository
    private let authenticationManager: AuthenticationManager
    
    private var cancelBag: Set<AnyCancellable> = []
    init(loginRepository: LoginRepository, authenticationManager: AuthenticationManager) {
        self.loginRepository = loginRepository
        self.authenticationManager = authenticationManager
    }
    
    func loginWithKakao(accessToken: String) {
        loginRepository.kakaoLoginPublisher(accessToken: accessToken).sink(receiveCompletion: { print("\($0)")}, receiveValue: { [weak self] in
            guard let self = self else { return }
            self.authenticationManager.login(accessToken: $0.accessToken, refreshToken: $0.refreshToken)
        }).store(in: &self.cancelBag)
    }
    
    func loginWithApple(accessToken: String) {
        loginRepository.appleLoginPublisher(accessToken: accessToken).sink(receiveCompletion: { print("\($0)")}, receiveValue: { [weak self] in
            guard let self = self else { return }
            self.authenticationManager.login(accessToken: $0.accessToken, refreshToken: $0.refreshToken)
        }).store(in: &self.cancelBag)
    }
}
