//
//  DefaultSynchronizationManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/15.
//

import Foundation
import Combine

final class DefaultSynchronizationManager: SynchronizationManager {
    private let isDataChangedSubject = CurrentValueSubject<Bool, Never>(false)
    
    func isDataChanged() {
        isDataChangedSubject.send(true)
    }
    
    func initialize() {
        isDataChangedSubject.send(false)
    }
    
    func dataChangeStatusPublisher() -> AnyPublisher<Bool, Never> {
        return isDataChangedSubject.eraseToAnyPublisher()
    }
}
