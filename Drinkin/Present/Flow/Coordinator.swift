//
//  Coordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/07.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }

    func start()
}
