//
//  UIViewController + Extension.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/23.
//

import UIKit

extension UIViewController {
    func makeBlackBackBarButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = .black
            self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}
