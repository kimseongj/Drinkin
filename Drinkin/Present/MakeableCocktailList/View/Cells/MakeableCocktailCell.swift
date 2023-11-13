//
//  MakeableCocktailCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/12.
//

import UIKit
import SnapKit

final class MakeableCocktailCell: UICollectionViewCell {
    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let descriptionView = UIView()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 12)
        label.textColor = ColorPalette.subTitleGrayColor
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 20)
        
        return label
    }()
    
    private let scoreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scoreStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(cocktailImageView)
        contentView.addSubview(descriptionView)
        descriptionView.addSubview(categoryLabel)
        descriptionView.addSubview(titleLabel)
        descriptionView.addSubview(scoreStackView)
 
        cocktailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.size.width.equalTo(100)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview()
        }
            
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
        }
        
        scoreStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func fill(with makeableCocktail: MakeableCocktail) {
        categoryLabel.text = makeableCocktail.category
        titleLabel.text = makeableCocktail.cocktailName
        cocktailImageView.load(urlString: makeableCocktail.imageURI)
        configureScoreView(levelScore: makeableCocktail.levelScore,
                           sugarContentScore: makeableCocktail.sugarContentScore,
                           abvScore: makeableCocktail.abvScore)
    }
    
    private func configureScoreView(levelScore: Int, sugarContentScore: Int, abvScore: Int) {
        let levelScorePresentationView = ScorePresentationView(title: InformationStrings.level,
                                                               score: levelScore)
        
        let sugarContentScorePresentationView = ScorePresentationView(title: InformationStrings.sugarContent,
                                                                      score: sugarContentScore)
        
        let abvGradeScorePresentationView = ScorePresentationView(title: InformationStrings.abv,
                                                                  score: abvScore)
   
        scoreStackView.addArrangedSubview(levelScorePresentationView)
        scoreStackView.addArrangedSubview(sugarContentScorePresentationView)
        scoreStackView.addArrangedSubview(abvGradeScorePresentationView)
    }
}
