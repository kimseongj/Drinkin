//
//  CocktailRecommendCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit
import SnapKit

protocol CellButtonDelegate: AnyObject {
    func pushProductDetailVC(withID id: Int)
}

final class CocktailRecommendCell: UICollectionViewCell {
    weak var delegate: CellButtonDelegate?
    var cocktailID: Int?

    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    //MARK: - SummaryOfCocktailView
    private let summaryOfCocktailView = UIView()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 12)
        label.textColor = ColorPalette.subTitleGrayColor

        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 17)
        label.textColor = .black
        
        return label
    }()
    
    private let scoreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    //MARK: - TextDescriptionView
    private let textDescriptionView = UIView()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 14)
        label.numberOfLines = 2
        label.textColor = .black
        
        return label
    }()
    
    private let holdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        
        return stackView
    }()
    
    //MARK: - Button
    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("자세히 보기", for: .normal)
        button.titleLabel?.font = UIFont(name: FontStrings.pretendardBlack, size: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.borderColor = ColorPalette.buttonBorderColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureBackgroundColor()
        configureUI()
        setCellBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        holdStackView.subviews.forEach { $0.removeFromSuperview() }
        scoreStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func configureBackgroundColor() {
        self.backgroundColor = .white
    }
    
    private func setCellBorder() {
        self.layer.borderWidth = 3
    }
    
    private func configureUI() {
        self.addSubview(cocktailImageView)
        self.addSubview(summaryOfCocktailView)
        self.addSubview(textDescriptionView)
        self.addSubview(seeMoreButton)

        
        cocktailImageView.snp.makeConstraints{
            $0.height.equalTo(120)
            $0.width.equalTo(120)
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        summaryOfCocktailView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalTo(cocktailImageView.snp.trailing).offset(20)
        }
        
        textDescriptionView.snp.makeConstraints {
            $0.top.equalTo(summaryOfCocktailView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(seeMoreButton.snp.top).offset(-10)
        }
        
        seeMoreButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-24)
            $0.height.equalTo(42)
        }
        
        configureSummaryOfCocktailView()
        configureTextDescriptionView()
    }
    
    func configureCell(cocktailBrief: CocktailBrief) {
        guard let validImageURL = URL(string: cocktailBrief.imageURI) else { return }
        
        cocktailImageView.load(urlString: validImageURL)
        fetchTitle(cocktailBrief.cocktailNameKo)
        fetchSubtitle(cocktailBrief.category)
        fetchScore(levelScore: cocktailBrief.levelScore, abvScore: cocktailBrief.abvScore, sugarContentScore: cocktailBrief.sugarContentScore)
        descriptionLabel.text = cocktailBrief.description
        configureHoldViews(cocktailBrief: cocktailBrief)
    }
    
    @objc private func buttonTapped() {
        if let id = cocktailID {
            delegate?.pushProductDetailVC(withID: id)
        }
    }
}

//MARK: - SummaryOfCocktailView
extension CocktailRecommendCell {
    private func configureSummaryOfCocktailView() {
        summaryOfCocktailView.addSubview(categoryLabel)
        summaryOfCocktailView.addSubview(titleLabel)
        summaryOfCocktailView.addSubview(scoreStackView)
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalToSuperview().offset(2)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(2)
        }
        
        scoreStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(2)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func fetchTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func fetchSubtitle(_ subtitle: String) {
        categoryLabel.text = subtitle
    }
    
    private func fetchScore(levelScore: Int,
                            abvScore: Int,
                            sugarContentScore: Int) {
        
        let levelScorePresentationView = ScorePresentationView(title: InformationStrings.level,
                                                               score: levelScore)
        let abvScorePresentationView = ScorePresentationView(title: InformationStrings.abv,
                                                             score: abvScore)
        let sugarContentScorePresentationView = ScorePresentationView(title: InformationStrings.sugarContent,
                                                                      score: sugarContentScore)
        
        scoreStackView.addArrangedSubview(levelScorePresentationView)
        scoreStackView.addArrangedSubview(abvScorePresentationView)
        scoreStackView.addArrangedSubview(sugarContentScorePresentationView)
    }
}

//MARK: - TextDescription
extension CocktailRecommendCell {
    private func configureTextDescriptionView() {
        textDescriptionView.addSubview(descriptionLabel)
        textDescriptionView.addSubview(holdStackView)
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        holdStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    private func configureHoldViews(cocktailBrief: CocktailBrief) {
        let baseView = HoldView(cocktailBrief: cocktailBrief,
                                title: InformationStrings.base)
        let ingredientView = HoldView(cocktailBrief: cocktailBrief,
                                      title: InformationStrings.ingredient)
        let garnishView = HoldView(cocktailBrief: cocktailBrief,
                                   title: InformationStrings.garnish)
        
        holdStackView.addArrangedSubview(baseView)
        holdStackView.addArrangedSubview(ingredientView)
        holdStackView.addArrangedSubview(garnishView)
    }
}
