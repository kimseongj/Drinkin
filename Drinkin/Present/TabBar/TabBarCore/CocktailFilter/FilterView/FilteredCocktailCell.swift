//
//  FilteredCocktailCollectionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/27.
//

import UIKit
import SnapKit

class FilteredCocktailCell: UITableViewCell {
    private enum Constant {
//        static let
//        static let 
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 20)
        
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
    private lazy var levelLabel: UILabel = makeGradeLabel()
    private lazy var levelGradeView = GradeView(grade: nil)
    
    private let sugarContentView = UIView()
    private lazy var sugarContentLabel: UILabel = makeGradeLabel()
    private lazy var sugarContentGradeView = GradeView(grade: nil)
    
    private let abvView = UIView()
    private lazy var abvLabel: UILabel = makeGradeLabel()
    private lazy var abvGradeView = GradeView(grade: nil)
    
    private let ingredienView = UIView()
    private lazy var ingredientLabel: UILabel = makeGradeLabel()
    private lazy var ingredientGradeView = GradeView(grade: nil)
    
    private let cocktailImageView: UIImageView = {
       let imageView = UIImageView()
        
        return imageView
    }()
    
    private func makeGradeLabel() -> UILabel {
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
    
    func configureGradeView() {
         levelGradeView = GradeView(grade: 1)
        sugarContentGradeView = GradeView(grade: 2)
        abvGradeView = GradeView(grade: 3)
        ingredientGradeView = GradeView(grade: 2)
    }
    
    private func configureUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainStackView)
        contentView.addSubview(cocktailImageView)
        mainStackView.addArrangedSubview(firstSubStackView)
        mainStackView.addArrangedSubview(secondSubStackView)
        firstSubStackView.addArrangedSubview(levelView)
        firstSubStackView.addArrangedSubview(sugarContentView)
        secondSubStackView.addArrangedSubview(abvView)
        secondSubStackView.addArrangedSubview(ingredienView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        cocktailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.width.equalTo(100)
        }
    }
}
