//
//  BaseCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

final class BaseCell: UICollectionViewCell {
    
    static let id = "BaseCell"
    
    let baseNameLabel: UILabel = {
        let baseNameLabel = UILabel()
        baseNameLabel.sizeToFit()
        return baseNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 1.4
        self.addSubview(baseNameLabel)
        
        baseNameLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
