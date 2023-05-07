//
//  BaseCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

final class BaseCell: UICollectionViewCell {
    
    static let id = "BaseCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = .black
                baseNameLabel.textColor = .white
            } else {
                self.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
                baseNameLabel.textColor = .black
            }
        }
    }
    
    let baseNameLabel: UILabel = {
        let baseNameLabel = UILabel()
        baseNameLabel.sizeToFit()
        baseNameLabel.font = UIFont(name: "Pretendard-Bold", size: 14)
        return baseNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellSetting() {
        self.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
        self.layer.cornerRadius = 4
        self.addSubview(baseNameLabel)
        
        baseNameLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
