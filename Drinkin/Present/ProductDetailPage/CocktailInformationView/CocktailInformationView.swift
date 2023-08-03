//
//  CocktailInformationView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit
import SnapKit

class CocktailInformationView: UIView {
    
    let cocktailNameTitle: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.text = "정보"
        return title
    }()
    
    let toolView = SkillView()
    let glassView = SkillView()
    let skillView = SkillView()
    let abvView = TextDescriptionView(title: "당 도")
    let levelView = TextDescriptionView(title: "난이도")
    let sugarContentView = TextDescriptionView(title: "당 도")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(cocktailNameTitle)
        self.addSubview(toolView)
        self.addSubview(glassView)
        self.addSubview(skillView)
        self.addSubview(abvView)
        self.addSubview(levelView)
        self.addSubview(sugarContentView)
        
        cocktailNameTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(17)
        }
        
        toolView.snp.makeConstraints { make in
            make.top.equalTo(cocktailNameTitle.snp.bottom)
            make.trailing.leading.equalToSuperview()
        }
        
        skillView.snp.makeConstraints { make in
            make.top.equalTo(toolView.snp.bottom)
            make.trailing.leading.equalToSuperview()
        }
        
        glassView.snp.makeConstraints {make in
            make.top.equalTo(skillView.snp.bottom)
            make.trailing.leading.equalToSuperview()
            
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
}
