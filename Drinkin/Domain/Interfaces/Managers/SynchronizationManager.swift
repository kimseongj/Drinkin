//
//  SynchronizationManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/20.
//

import Combine

protocol SynchronizationManager {
    func isDataChanged()
    func initialize()
    func dataChangeStatusPublisher() -> AnyPublisher<Bool, Never>
}
