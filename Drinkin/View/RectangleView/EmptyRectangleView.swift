//
//  EmptyRectangleView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/26.
//

import UIKit
import SnapKit

class EmptyRectangleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 2
        self.snp.makeConstraints {
            $0.height.width.equalTo(12)
        }
        
    }
}
