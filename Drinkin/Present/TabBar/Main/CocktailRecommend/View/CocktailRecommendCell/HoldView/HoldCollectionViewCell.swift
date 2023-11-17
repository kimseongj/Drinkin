//
//  HoldedCollectionViewCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/20.
//

import UIKit
import SnapKit

final class HoldCollectionViewCell: UICollectionViewCell {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 14)
        label.sizeToFit()
        
        return label
    }()
    
    private let yellowRectangleView = YellowRectangleView()
    private let emptyRectangleView = EmptyRectangleView()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = MiscStrings.hyphen
        label.font = UIFont(name: FontStrings.pretendardBold, size: 14)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fill(with itemName: String) {
        titleLabel.text = itemName
    }
    
    func makeHoldedItemCell() {
        contentView.addSubview(yellowRectangleView)
        contentView.addSubview(titleLabel)
        
        yellowRectangleView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(titleLabel.snp.leading).offset(-4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-2)
        }
    }
    
    func makeUnholdedItemCell() {
        contentView.addSubview(emptyRectangleView)
        contentView.addSubview(titleLabel)
        
        emptyRectangleView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(titleLabel.snp.leading).offset(-4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-2)
        }
    }
    
    func makeEmptyCell() {
        contentView.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-2)
        }
    }
}
