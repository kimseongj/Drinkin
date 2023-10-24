//
//  ItemFilterCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit

final class ItemFilterCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                presentSelected()
            } else {
                presentDeselected()
            }
        }
    }
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 14)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackgroundColor()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundColor() {
        contentView.backgroundColor = ColorPalette.categoryCellColor
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 4
        contentView.addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func fill(with itemFilter: String) {
        categoryNameLabel.text = itemFilter
    }
    
    func presentSelected() {
        contentView.backgroundColor = .black
        categoryNameLabel.textColor = .white
    }
    
    func presentDeselected() {
        contentView.backgroundColor = ColorPalette.categoryCellColor
        categoryNameLabel.textColor = .black
    }
}
