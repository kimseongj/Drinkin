//
//  MutableSizeTableView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/20.
//

import UIKit

class MutableSizeTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            if oldValue.height != self.contentSize.height {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
