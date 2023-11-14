//
//  RecipeItemCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/08.
//

import UIKit
import SnapKit

final class RecipeItemCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 14)
        
        return label
    }()
    
    private let checkImageView = UIImageView()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 4
        contentView.backgroundColor = ColorPalette.grayCellColor
        contentView.layer.borderColor = ColorPalette.cellGrayBorderColor
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkImageView)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        checkImageView.snp.makeConstraints {
            $0.height.width.equalTo(14)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func check(hold: Bool) {
        switch hold {
        case true:
            contentView.backgroundColor = ColorPalette.themeColor
            contentView.layer.borderColor = UIColor.black.cgColor
            checkImageView.image = ImageStorage.checkIcon
            
        case false:
            contentView.backgroundColor = ColorPalette.grayCellColor
            contentView.layer.borderColor = ColorPalette.cellGrayBorderColor
            checkImageView.image = nil
        }
    }
    
    //MARK: - Fill Cell
    
    func fill(detailIgredient: DetailIngredient) {
        titleLabel.text = detailIgredient.ingredientNameKo
    }
}
