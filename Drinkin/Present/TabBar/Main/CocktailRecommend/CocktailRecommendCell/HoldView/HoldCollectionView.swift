//
//  HoldedCollectionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/20.
//

import UIKit

class HoldCollectionView: UICollectionView {
    override var contentSize: CGSize{
        didSet {
            if oldValue.height != self.contentSize.height {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
}
