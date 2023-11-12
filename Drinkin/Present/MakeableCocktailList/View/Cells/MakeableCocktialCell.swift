//
//  MakeableCocktialCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/12.
//

import UIKit
import SnapKit

final class MakeableCocktialCell: UICollectionViewCell {
    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let subTitleLabel: UILabel = {
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
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        
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
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(scoreStackView)
 
        cocktailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.size.width.equalTo(100)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(cocktailImageView.snp.trailing).offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom)
            $0.leading.equalTo(cocktailImageView.snp.trailing).offset(20)
        }
        
        scoreStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(cocktailImageView.snp.trailing).offset(20)
            $0.bottom.equalToSuperview().offset(-28)
        }
    }
    
    func fill(with cocktailPreview: CocktailPreview) {
        titleLabel.text = cocktailPreview.cocktailNameKo
        cocktailImageView.load(urlString: cocktailPreview.imageURI)
        configureScoreView(levelScore: cocktailPreview.levelScore,
                           sugarContentScore: cocktailPreview.sugarContentScore,
                           abvScore: cocktailPreview.abvScore)
    }
    
    private func configureScoreView(levelScore: Int, sugarContentScore: Int, abvScore: Int) {
        let levelScorePresentationView = ScorePresentationView(title: "난이도", score: levelScore)
        let sugarContentScorePresentationView = ScorePresentationView(title: "당    도", score: sugarContentScore)
        let abvGradeScorePresentationView = ScorePresentationView(title: "도    수", score: abvScore)
   
        scoreStackView.addArrangedSubview(levelScorePresentationView)
        scoreStackView.addArrangedSubview(sugarContentScorePresentationView)
        scoreStackView.addArrangedSubview(abvGradeScorePresentationView)
    }
}
