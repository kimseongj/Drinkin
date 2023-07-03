//
//  LoggedInCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit
import SnapKit

class LoggedInCell: UICollectionViewCell {
    
    let wholeStackView = WholeStackView()
    
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
        self.addSubview(wholeStackView)
        self.addSubview(seeMoreButton)
        
        wholeStackView.snp.makeConstraints { make in
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

//MARK: - 제일 큰 스택뷰
final class WholeStackView: UIView {
    private let mainStackView = MainStackView()
    private let holdStackView = HoldStackView()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        label.text = "스카치 위스키의 향 위에 아마레또의 달달한 아몬드향을 더했다. 아마레또는 생각보다 더 달다. 단 맛..."
        
        return label
    }()
    
    private let baseView = HoldView()
    private let ingredientView = HoldView()
    private let garnishView = HoldView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(mainStackView)
        self.addSubview(descriptionLabel)
        self.addSubview(baseView)
        self.addSubview(ingredientView)
        self.addSubview(garnishView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
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

//MARK: - 이미지뷰랑 설명뷰 합쳐놓은 거
class MainStackView: UIStackView {
    let cocktailImage: UIImageView = {
        let cocktailImage = UIImageView()
        cocktailImage.contentMode = .scaleAspectFit
        cocktailImage.backgroundColor = .lightGray
        return cocktailImage
    }()
    
    let summaryOfCocktailView = SummaryOfCocktailView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setMainStackView()
        configureUI()
        
        self.backgroundColor = .white
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMainStackView() {
        self.distribution = .fill
        self.spacing = 20
        self.alignment = .center
        self.axis = .horizontal
    }
    
    func configureUI() {
        self.addArrangedSubview(cocktailImage)
        self.addArrangedSubview(summaryOfCocktailView)
        
        cocktailImage.snp.makeConstraints{ make in
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
    }
}

//MARK: - 갓파더 뷰 내용
class SummaryOfCocktailView: UIView {
    var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = UIColor(red: 0.472, green: 0.465, blue: 0.453, alpha: 1)
        subtitleLabel.text = "위스키베이스"
        return subtitleLabel
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 17)
        title.textColor = .black
        title.text = "갓파더"
        return title
    }()
    
    private let levelGradePresentationView = GradePresentationView(title: "난이도", grade: 3)
    private let abvGradePresentationView = GradePresentationView(title: "도   수", grade: 2)
    private let sugarContentGradePresentationView = GradePresentationView(title: "당   도", grade: 1)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        checkLevel()
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
    
    // Binding 작업을 통해 뷰 업그래이드시키기 
    private func checkLevel() {

    }
}

//MARK: - HoldedIngredientView
class HoldStackView: UIView {
    let baseView = HoldView()
    let ingredientView = HoldView()
    let garnishView = HoldView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(baseView)
        self.addSubview(ingredientView)
        self.addSubview(garnishView)
        
        baseView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            
        }
        
        ingredientView.snp.makeConstraints { make in
            make.top.equalTo(baseView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        garnishView.snp.makeConstraints { make in
            make.top.equalTo(ingredientView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
    }
}
