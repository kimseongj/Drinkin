//
//  LoginRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Combine

protocol LoginRepository {
    func kakaoLoginPublisher(accessToken: String) -> AnyPublisher<LoginToken, Error>
    func appleLoginPublisher(accessToken: String) -> AnyPublisher<LoginToken, Error>
}
