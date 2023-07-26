//
//  LoggedInCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit
import SnapKit

class LoggedInCell: UICollectionViewCell {
    
    let briefDescriptionView = BriefDescriptionView()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    func setCellBorder() {
        self.layer.borderWidth = 3
    }
    
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
    
    func configureUI() {
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
        cocktailImage.backgroundColor = .lightGray
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
    }
    
    func configureCell(briefDescription: BriefDescription, indexPath: IndexPath) {
        let result = briefDescription.results[indexPath.row]
        
        guard let validImageURL = URL(string: result.imageURI) else { return }
        
        summaryOfCocktailView.fetchTitle(result.cocktailNameKo)
        summaryOfCocktailView.fetchLevel(levelGrade: result.levelScore, abvGrade: result.abvScore, sugarContentGrade: result.sugarContentScore)
        
        cocktailImage.load(url: validImageURL)
        descriptionLabel.text = briefDescription.results[indexPath.row].description
        
        configureHoldViews(result: result)

    }
    
    func configureHoldViews(result: Result) {
        
        let baseView = HoldView(result: result, title: "베이스")
        let ingredientView = HoldView(result: result, title: "재    료")
        let garnishView = HoldView(result: result, title: "가니쉬")
        
        self.addSubview(baseView)
        self.addSubview(ingredientView)
        self.addSubview(garnishView)
        
        baseView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        ingredientView.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        garnishView.snp.makeConstraints { make in
            make.top.equalTo(ingredientView.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
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
    
    private let levelGradePresentationView = GradePresentationView(title: "난이도", grade: 2)
    private let abvGradePresentationView = GradePresentationView(title: "도    수", grade: 2)
    private let sugarContentGradePresentationView = GradePresentationView(title: "당    도", grade: 2)
    
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
        self.addSubview(levelGradePresentationView)
        self.addSubview(abvGradePresentationView)
        self.addSubview(sugarContentGradePresentationView)
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalToSuperview().offset(2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(2)
        }
        
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
    
    func fetchTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func fetchSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }
    
    // Binding 작업을 통해 뷰 업그래이드시키기
    func fetchLevel(levelGrade: Int,
                    abvGrade: Int,
                    sugarContentGrade: Int) {
        levelGradePresentationView.grade = levelGrade
        abvGradePresentationView.grade = abvGrade
        sugarContentGradePresentationView.grade = sugarContentGrade
    }
}

// BriefDescriptionView 남기고
