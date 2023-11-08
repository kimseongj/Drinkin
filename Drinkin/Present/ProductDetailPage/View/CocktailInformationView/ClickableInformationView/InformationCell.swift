//
//  InformationCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit
import SnapKit

final class InformationCell: UICollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 14)
        label.sizeToFit()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.layer.borderColor = ColorPalette.cellGrayBorderColor
        self.backgroundColor = ColorPalette.grayCellColor
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1.4
        self.addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func fill(with cocktailTool: CocktailTool) {
        label.text = cocktailTool.toolNameKo
    }
    
    func fill(with cocktailSkill: CocktailSkill) {
        label.text = cocktailSkill.skillNameKo
    }
    
    func fill(with cocktailGlass: CocktailGlass) {
        label.text = cocktailGlass.glassNameKo
    }
}
