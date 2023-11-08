//
//  FilterSelectionCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/02.
//

import UIKit

class FilterSelectionCell: UICollectionViewCell {
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 14)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellSetting() {
        contentView.backgroundColor = ColorPalette.filterCellColor
        contentView.layer.cornerRadius = 4
        contentView.addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func fill(with categoryName: String) {
        categoryNameLabel.text = categoryName + MiscStrings.InvertedTriangle
    }
    
    func makeBlackCell() {
        contentView.backgroundColor = .black
        categoryNameLabel.textColor = .white
    }
    
    func makeFixedCell() {
        contentView.layer.borderWidth = 3
        contentView.backgroundColor = ColorPalette.themeColor
        categoryNameLabel.textColor = .black
    }
    
    func makeDefaultCell() {
        contentView.layer.borderWidth = 0
        contentView.backgroundColor = ColorPalette.filterCellColor
        categoryNameLabel.textColor = .black
    }
}
