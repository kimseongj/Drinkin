//
//  FilteredCocktailCollectionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/27.
//

import UIKit
import SnapKit

class FilteredCocktailCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let firstSubStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let secondSubStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let levelView = UIView()
    private lazy var levelLabel: UILabel = makeSubtitleLabel()
    private let levelGradeView = LevelOneView()
    
    private let sugarContentView = UIView()
    private lazy var sugarContentLabel: UILabel = makeSubtitleLabel()
    private let sugarContentLevelContentView = LevelOneView()
    
    private let abvView = UIView()
    private lazy var abvLabel: UILabel = makeSubtitleLabel()
    private let abvGradeView = LevelOneView()
    
    private let ingredienView = UIView()
    private lazy var ingredientLabel: UILabel = makeSubtitleLabel()
    private let ingredientGradeView = LevelOneView()
    
    //    override init(frame: CGRect) {
    //
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }
    
    private func configureSubtitleText() {
        levelLabel.text = "난이도"
        sugarContentLabel.text = "당  도"
        abvLabel.text = "도  수"
        ingredientLabel.text = "재  료"
    }
    
    private func makeLevelView(title: String, gradeView: LevelOneView) -> UIView {
        let view = UIView()
        let label: UILabel = makeSubtitleLabel()
        let gradeView = LevelOneView()
        
        return view
    }
    
    func configureLevel() {
        
    }
    
    private func configureUI() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(firstSubStackView)
        mainStackView.addArrangedSubview(secondSubStackView)
        firstSubStackView.addArrangedSubview(levelView)
        firstSubStackView.addArrangedSubview(sugarContentView)
        secondSubStackView.addArrangedSubview(abvView)
        secondSubStackView.addArrangedSubview(ingredienView)
    }
}

