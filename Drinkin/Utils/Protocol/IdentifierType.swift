//
//  IdetifierType.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/20.
//

import UIKit

public protocol IdentifierType {
    static var identifier: String { get }
}

extension IdentifierType {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierType {}
