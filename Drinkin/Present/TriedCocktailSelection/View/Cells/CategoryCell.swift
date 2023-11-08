//
//  CategoryCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = .black
                categoryNameLabel.textColor = .white
            } else {
                self.backgroundColor = ColorPalette.filterCellColor
                categoryNameLabel.textColor = .black
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
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellSetting() {
        self.backgroundColor = ColorPalette.filterCellColor
        self.layer.cornerRadius = 4
        self.addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func fill(with categoryName: String) {
        categoryNameLabel.text = categoryName
    }
}
