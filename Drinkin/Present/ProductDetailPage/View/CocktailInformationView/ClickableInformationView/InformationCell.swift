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
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
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
    
    //MARK: - Fill Cell
    
    func fill(with cocktailTool: CocktailTool) {
        if cocktailTool.toolNameKo == "-" {
            presentEmpty()
        }
        label.text = cocktailTool.toolNameKo
    }
    
    func fill(with cocktailSkill: CocktailSkill) {
        if cocktailSkill.skillNameKo == "-" {
            presentEmpty()
        }
        label.text = cocktailSkill.skillNameKo
    }
    
    func fill(with cocktailGlass: CocktailGlass) {
        if cocktailGlass.glassNameKo == "-" {
            presentEmpty()
        }
        label.text = cocktailGlass.glassNameKo
    }
    
    private func presentEmpty() {
        self.layer.borderWidth = 0
        self.backgroundColor = .white
        self.isUserInteractionEnabled = false
    }
}
