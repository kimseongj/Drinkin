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
        self.layer.borderColor = UIColor(red: 0.909, green: 0.906, blue: 0.903, alpha: 1).cgColor
        self.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.layer.cornerRadius = 2
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