//
//  InformationCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit
import SnapKit

class InformationCell: UICollectionViewCell {

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 14)
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
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-2)
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
