//
//  InformationCollectionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit

class MutableSizeCollectionView: UICollectionView {
    
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
