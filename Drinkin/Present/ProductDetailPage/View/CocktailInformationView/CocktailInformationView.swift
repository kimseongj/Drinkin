//
//  CocktailInformationView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit
import SnapKit

final class CocktailInformationView: UIView {
    private var cocktailDescription: CocktailDescription?
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 20)
        label.text = "정보"
        
        return label
    }()
    
    let toolView = ClickableInformationView(title: InformationStrings.tool)
    let skillView = ClickableInformationView(title: InformationStrings.skill)
    let glassView = ClickableInformationView(title: InformationStrings.glass)
    let abvView = TextInformationView(title: InformationStrings.abv)
    let levelView = TextInformationView(title: InformationStrings.level)
    let sugarContentView = TextInformationView(title: InformationStrings.sugarContent)
        
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .white
        configureUI()
        fillCocktailDescription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(informationLabel)
        self.addSubview(toolView)
        self.addSubview(skillView)
        self.addSubview(glassView)
        self.addSubview(skillView)
        self.addSubview(abvView)
        self.addSubview(levelView)
        self.addSubview(sugarContentView)
        
        informationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(17)
        }
        
        toolView.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom)
            $0.trailing.leading.equalToSuperview()
        }
        
        skillView.snp.makeConstraints {
            $0.top.equalTo(toolView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
        }
        
        glassView.snp.makeConstraints {
            $0.top.equalTo(skillView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
        }
        
        abvView.snp.makeConstraints {
            $0.top.equalTo(glassView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
        }
        
        levelView.snp.makeConstraints {
            $0.top.equalTo(abvView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
        }
        
        sugarContentView.snp.makeConstraints {
            $0.top.equalTo(levelView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func fillCocktailDescription() {
        toolView.fillCocktailDescrion(cocktailDescription: cocktailDescription)
        skillView.fillCocktailDescrion(cocktailDescription: cocktailDescription)
        glassView.fillCocktailDescrion(cocktailDescription: cocktailDescription)
    }
    
    func fill(with cocktailDescription: CocktailDescription) {  
        abvView.fill(with: cocktailDescription.abv)
        levelView.fill(with: cocktailDescription.level)
        sugarContentView.fill(with: cocktailDescription.sugarContent)
        
        toolView.fill(with: cocktailDescription)
        skillView.fill(with: cocktailDescription)
        glassView.fill(with: cocktailDescription)
    }
    
    func fillCocktailDescription(cocktailDescription: CocktailDescription?) {
        self.cocktailDescription = cocktailDescription
        fillCocktailDescription()
    }
}
