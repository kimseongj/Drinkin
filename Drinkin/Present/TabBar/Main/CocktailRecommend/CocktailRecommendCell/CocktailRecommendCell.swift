//
//  CocktailRecommendCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit
import SnapKit

class CocktailRecommendCell: UICollectionViewCell {
    
    let briefDescriptionView = BriefDescriptionView()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    let seeMoreButton: UIButton = {
        let seeMoreButton = UIButton()
        seeMoreButton.setTitle("자세히 보기", for: .normal)
        seeMoreButton.setTitleColor(.white, for: .normal)
        seeMoreButton.backgroundColor = .black
        seeMoreButton.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        seeMoreButton.layer.borderWidth = 3
        return seeMoreButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        setCellBorder()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setCellBorder() {
        self.layer.borderWidth = 3
    }
    
    private func configureUI() {
        self.addSubview(briefDescriptionView)
        self.addSubview(seeMoreButton)
        
        briefDescriptionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(seeMoreButton.snp.top)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(42)
        }
    }
    
    func configureCell(briefDescription: BriefDescription) {
        briefDescriptionView.configureBriefDescriptionView(briefDescription: briefDescription)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.briefDescriptionView.holdStackView.subviews.map { $0.removeFromSuperview() }
    }
}

//MARK: - 버튼 제외 모든 기능
final class BriefDescriptionView: UIView {
    private let mainStackView: UIStackView = {//MainStackView()
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    let cocktailImage: UIImageView = {
        let cocktailImage = UIImageView()
        cocktailImage.contentMode = .scaleAspectFit

        return cocktailImage
    }()
    
    let summaryOfCocktailView = SummaryOfCocktailView()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        
        return label
    }()
    
    let holdStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(cocktailImage)
        mainStackView.addArrangedSubview(summaryOfCocktailView)
        self.addSubview(descriptionLabel)
        self.addSubview(holdStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        cocktailImage.snp.makeConstraints{ make in
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        holdStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    func configureBriefDescriptionView(briefDescription: BriefDescription) {
        
        guard let validImageURL = URL(string: briefDescription.imageURI) else { return }
        
        summaryOfCocktailView.fetchTitle(briefDescription.cocktailNameKo)
        summaryOfCocktailView.fetchLevel(levelGrade: briefDescription.levelScore, abvGrade: briefDescription.abvScore, sugarContentGrade: briefDescription.sugarContentScore)
        
        cocktailImage.load(url: validImageURL)
        descriptionLabel.text = briefDescription.description
        
        configureHoldViews(briefDescription: briefDescription)

    }
    
    func configureHoldViews(briefDescription: BriefDescription) {
        
        let baseView = HoldView(briefDescription: briefDescription, title: "베이스")
        let ingredientView = HoldView(briefDescription: briefDescription, title: "재    료")
        let garnishView = HoldView(briefDescription: briefDescription, title: "가니쉬")
        
        holdStackView.addArrangedSubview(baseView)
        holdStackView.addArrangedSubview(ingredientView)
        holdStackView.addArrangedSubview(garnishView)
        
//        baseView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(20)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }
//
//        ingredientView.snp.makeConstraints { make in
//            make.top.equalTo(baseView.snp.bottom).offset(10)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }
//
//        garnishView.snp.makeConstraints { make in
//            make.top.equalTo(ingredientView.snp.bottom).offset(10)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }
    }
}

//MARK: - 칵테일 제목, 카테고리, 난이도, 도수, 당도를 나타내는 뷰
class SummaryOfCocktailView: UIView {
    var subtitleLabel: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(subtitleLabel)
        self.addSubview(titleLabel)
        
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
    
    func fetchLevel(levelGrade: Int,
                    abvGrade: Int,
                    sugarContentGrade: Int) {
        
        let levelGradePresentationView = GradePresentationView(title: "난이도", grade: levelGrade)
        let abvGradePresentationView = GradePresentationView(title: "도    수", grade: abvGrade)
        let sugarContentGradePresentationView = GradePresentationView(title: "당    도", grade: sugarContentGrade)
        
        self.addSubview(levelGradePresentationView)
        self.addSubview(abvGradePresentationView)
        self.addSubview(sugarContentGradePresentationView)
        
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
