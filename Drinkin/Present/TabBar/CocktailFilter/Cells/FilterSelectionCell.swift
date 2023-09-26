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
        contentView.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
        contentView.layer.cornerRadius = 4
        contentView.addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func fill(with categoryName: String) {
        categoryNameLabel.text = categoryName + " ▼"
    }
    
    func makeBlackCell() {
        contentView.backgroundColor = .black
        categoryNameLabel.textColor = .white
    }
    
    func makeFixedCell() {
        contentView.layer.borderWidth = 3
        contentView.backgroundColor = UIColor(red: 1, green: 0.706, blue: 0.259, alpha: 1)
        categoryNameLabel.textColor = .black
    }
    
    func makeDefaultCell() {
        contentView.layer.borderWidth = 0
        contentView.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
        categoryNameLabel.textColor = .black 
    }
}
