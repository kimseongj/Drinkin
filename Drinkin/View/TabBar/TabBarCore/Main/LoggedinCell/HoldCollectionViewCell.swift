//
//  HoldedCollectionViewCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/20.
//

import UIKit
import SnapKit

class HoldCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        
        return label
    }()
    
    private let yellowRectangleView = YellowRectangleView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetting() {
        contentView.addSubview(yellowRectangleView)
        contentView.addSubview(label)
        
        yellowRectangleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(label.snp.leading).offset(-4)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
        }
    }
}
