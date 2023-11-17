//
//  IngredientQuantityView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/10.
//

import UIKit
import SnapKit

final class IngredientQuantityView: UIView {
    var ingredientQuantity: Int = 0
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.text = InformationStrings.ingredient
        
        return label
    }()
    
    private lazy var ingredientQuantityLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.text = "\(String(ingredientQuantity))가지"
        
        return label
    }()
    
    init(ingredientQuantity: Int) {
        super.init(frame: .zero)
        self.ingredientQuantity = ingredientQuantity
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(titleLabel)
        self.addSubview(ingredientQuantityLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        ingredientQuantityLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(14)
        }
    }
}
