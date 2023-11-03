//
//  YellowRectangleView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/26.
//

import UIKit
import SnapKit

class YellowRectangleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor(red: 1, green: 0.706, blue: 0.259, alpha: 1)
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 2
        self.snp.makeConstraints {
            $0.height.width.equalTo(12)
        }
    }
}
