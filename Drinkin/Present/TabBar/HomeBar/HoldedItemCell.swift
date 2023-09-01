//
//  HoldedItemCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import UIKit
import SnapKit

final class HoldedItemCell: UICollectionViewCell {
    private enum Constraint {
        static let padding: Int = 12
    }
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constraint.padding)
            $0.leading.equalToSuperview().offset(Constraint.padding)
            $0.bottom.equalToSuperview().offset(-Constraint.padding)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constraint.padding)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(Constraint.padding)
            $0.trailing.equalToSuperview().offset(-Constraint.padding)
            $0.bottom.equalToSuperview().offset(-Constraint.padding)
        }
    }
    
    func fill(with itemName: String) {
        titleLabel.text = itemName
    }
}
