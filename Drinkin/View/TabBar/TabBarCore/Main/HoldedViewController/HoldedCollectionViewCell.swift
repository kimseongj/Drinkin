//
//  HoldedViewCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/07.
//

import UIKit

class HoldedCollectionViewCell: UICollectionViewCell {
    static let indentifier = "HoldedViewCell"
    
    private let yellowRectangleView = YellowRectangleView()
    
    let label: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        self.backgroundColor = .white
        self.addSubview(label)
        self.addSubview(yellowRectangleView)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        yellowRectangleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalTo(label.snp.leading).offset(-4)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    func setLabel() {
        
    }
}


