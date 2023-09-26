//
//  IngredientFilterCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit

final class IngredientFilterCell: UICollectionViewCell {
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 14)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundColor() {
        contentView.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 4
        contentView.addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func fill(with ingredientFilter: String) {
        categoryNameLabel.text = ingredientFilter
    }
}
