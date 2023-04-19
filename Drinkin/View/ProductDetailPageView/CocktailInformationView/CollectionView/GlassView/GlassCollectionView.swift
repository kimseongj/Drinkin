//
//  GlassCollectionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit

class GlassCollectionView: UICollectionView {
    
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
