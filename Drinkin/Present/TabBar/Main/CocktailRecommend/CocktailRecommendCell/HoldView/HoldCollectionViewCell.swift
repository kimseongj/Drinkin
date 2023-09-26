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
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        
        return label
    }()
    
    private let yellowRectangleView = YellowRectangleView()
    private let emptyRectangleView = EmptyRectangleView()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = MiscStrings.hyphen
        label.font = UIFont.systemFont(ofSize: 14)
        
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
        
        yellowRectangleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).offset(-4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    func makeUnholdedItemCell() {
        contentView.addSubview(emptyRectangleView)
        contentView.addSubview(titleLabel)
        
        emptyRectangleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).offset(-4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
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
