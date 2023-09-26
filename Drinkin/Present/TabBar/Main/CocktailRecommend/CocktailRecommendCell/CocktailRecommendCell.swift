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
    
    private let briefDescriptionView = UIView()
    
    //MARK: - VisualDescriptionView
    private let visualDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let cocktailImageView: UIImageView = {
        let cocktailImage = UIImageView()
        cocktailImage.contentMode = .scaleAspectFit
        
        return cocktailImage
    }()
    
    //MARK: - SummaryOfCocktailView
    private let summaryOfCocktailView = UIView()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = UIColor(red: 0.472, green: 0.465, blue: 0.453, alpha: 1)
        subtitleLabel.text = "위스키베이스"
        return subtitleLabel
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 17)
        title.textColor = .black
        
        return title
    }()
    
    //MARK: - TextDescriptionView
    private let textDescriptionView = UIView()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        let seeMoreButton = UIButton()
        seeMoreButton.setTitle("자세히 보기", for: .normal)
        seeMoreButton.setTitleColor(.white, for: .normal)
        seeMoreButton.backgroundColor = .black
        seeMoreButton.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        seeMoreButton.layer.borderWidth = 3
        seeMoreButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return seeMoreButton
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
    }
    
    private func configureBackgroundColor() {
        self.backgroundColor = .white
    }
    
    private func setCellBorder() {
        self.layer.borderWidth = 3
    }
    
    private func configureUI() {
        self.addSubview(visualDescriptionStackView)
        self.addSubview(textDescriptionView)
        self.addSubview(seeMoreButton)
        
        cocktailImageView.snp.makeConstraints{ make in
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        visualDescriptionStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        textDescriptionView.snp.makeConstraints {
            $0.top.equalTo(visualDescriptionStackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(42)
        }
        
        configureVisualDescriptionStackView()
        configureSummaryOfCocktailView()
        configureTextDescriptionView()
    }
    
    func configureCell(briefDescription: BriefDescription) {
        guard let validImageURL = URL(string: briefDescription.imageURI) else { return }
        
        cocktailImageView.load(url: validImageURL)
        fetchTitle(briefDescription.cocktailNameKo)
        fetchLevel(levelGrade: briefDescription.levelScore, abvGrade: briefDescription.abvScore, sugarContentGrade: briefDescription.sugarContentScore)
        descriptionLabel.text = briefDescription.description
        configureHoldViews(briefDescription: briefDescription)
    }
    
    @objc private func buttonTapped() {
        if let id = cocktailID {
            delegate?.pushProductDetailVC(withID: id)
        }
    }
}

//MARK: - VisualDescriptionView
extension CocktailRecommendCell {
    private func configureVisualDescriptionStackView() {
        visualDescriptionStackView.addArrangedSubview(cocktailImageView)
        visualDescriptionStackView.addArrangedSubview(summaryOfCocktailView)
    }
}

//MARK: - SummaryOfCocktailView
extension CocktailRecommendCell {
    private func configureSummaryOfCocktailView() {
        summaryOfCocktailView.addSubview(subtitleLabel)
        summaryOfCocktailView.addSubview(titleLabel)
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalToSuperview().offset(2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(2)
        }
    }
    
    func fetchTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func fetchSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }
    
    private func fetchLevel(levelGrade: Int,
                            abvGrade: Int,
                            sugarContentGrade: Int) {
        
        let levelGradePresentationView = GradePresentationView(title: InformationStrings.level,
                                                               grade: levelGrade)
        let abvGradePresentationView = GradePresentationView(title: InformationStrings.abv,
                                                             grade: abvGrade)
        let sugarContentGradePresentationView = GradePresentationView(title: InformationStrings.sugarContent,
                                                                      grade: sugarContentGrade)
        
        summaryOfCocktailView.addSubview(levelGradePresentationView)
        summaryOfCocktailView.addSubview(abvGradePresentationView)
        summaryOfCocktailView.addSubview(sugarContentGradePresentationView)
        
        levelGradePresentationView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(2)
        }
        
        abvGradePresentationView.snp.makeConstraints {
            $0.top.equalTo(levelGradePresentationView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(2)
        }
        
        sugarContentGradePresentationView.snp.makeConstraints {
            $0.top.equalTo(abvGradePresentationView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(2)
            $0.bottom.equalToSuperview().offset(-2)
        }
    }
}

//MARK: - TextDescription
extension CocktailRecommendCell {
    private func configureTextDescriptionView() {
        textDescriptionView.addSubview(descriptionLabel)
        textDescriptionView.addSubview(holdStackView)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        holdStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    private func configureHoldViews(briefDescription: BriefDescription) {
        
        let baseView = HoldView(briefDescription: briefDescription,
                                title: InformationStrings.base)
        let ingredientView = HoldView(briefDescription: briefDescription,
                                      title: InformationStrings.ingredient)
        let garnishView = HoldView(briefDescription: briefDescription,
                                   title: InformationStrings.garnish)
        
        holdStackView.addArrangedSubview(baseView)
        holdStackView.addArrangedSubview(ingredientView)
        holdStackView.addArrangedSubview(garnishView)
    }
}
