//
//  IngredientCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import UIKit
import SnapKit

final class IngredientCell: UICollectionViewCell {
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private let recipeItemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 15)
        
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 12)
        label.textColor = ColorPalette.subTitleGrayColor
        
        return label
    }()
    
    private let emptyCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageStorage.checkFillIcon
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageStorage.checkFillIcon
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private func configureUI() {
        contentView.addSubview(ingredientImageView)
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(recipeItemTitleLabel)
        labelStackView.addArrangedSubview(categoryLabel)
        contentView.addSubview(emptyCheckImageView)
        contentView.addSubview(checkImageView)
        
        ingredientImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.size.equalTo(68)
        }

        labelStackView.snp.makeConstraints {
            $0.leading.equalTo(ingredientImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(emptyCheckImageView.snp.leading).offset(-8)
        }
        
        emptyCheckImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(26)
        }
        
        checkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(26)
        }
        
        checkImageView.isHidden = true
    }
}
