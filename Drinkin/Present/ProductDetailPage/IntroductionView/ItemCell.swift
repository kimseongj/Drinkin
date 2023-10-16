//
//  ItemCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/03.
//

import UIKit
import SnapKit

final class ItemCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 20)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 12)
        
        return label
    }()
    
    private let checkImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 4
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(checkImageView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        checkImageView.snp.makeConstraints {
            $0.height.width.equalTo(14)
            $0.leading.equalTo(descriptionLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func check(hold: Bool) {
        switch hold {
        case true:
            contentView.backgroundColor = ColorPalette.themeColor
            checkImageView.image = ImageStorage.checkIcon
            
        case false:
            contentView.backgroundColor = .white
            checkImageView.image = nil
        }
    }
    
    func fill(detailCategory: DetailCategory) {
        titleLabel.text = detailCategory.categoryNameKo
    }
    
    func fill(detailIgredient: DetailIngredient) {
        titleLabel.text = detailIgredient.ingredientNameKo
    }
}