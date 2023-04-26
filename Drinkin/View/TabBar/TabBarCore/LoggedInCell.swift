//
//  LoggedInCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit
import SnapKit

class LoggedInCell: UICollectionViewCell {
    
    static let cellId = "LoggedInCell"
    
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
    
    let cocktailImage: UIImageView = {
        let cocktailImage = UIImageView()
        cocktailImage.contentMode = .scaleAspectFit
        cocktailImage.backgroundColor = .lightGray
        return cocktailImage
    }()
    
    var baseLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.font = UIFont.systemFont(ofSize: 14)
        baseLabel.textColor = .black
        baseLabel.text = "당  도"
        
        return baseLabel
    }()
    
    var ingredientLabel: UILabel = {
        let ingredientLabel = UILabel()
        ingredientLabel.font = UIFont.systemFont(ofSize: 14)
        ingredientLabel.textColor = .black
        ingredientLabel.text = "당  도"
        
        return ingredientLabel
    }()
    
    var garnishLabel: UILabel = {
        let garnishLabel = UILabel()
        garnishLabel.font = UIFont.systemFont(ofSize: 14)
        garnishLabel.textColor = .black
        garnishLabel.text = "당  도"
        
        return garnishLabel
    }()
    
    var seeMoreButton: UIButton = {
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
            make.bottom.equalToSuperview().offset(-300)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(42)
        }
    }
}

//MARK: - WholeStackView
class WholeStackView: UIStackView {
    let mainStackView = MainStackView()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        label.text = "스카치 위스키의 향 위에 아마레또의 달달한 아몬드향을 더했다. 아마레또는 생각보다 더 달다. 단 맛..."
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setWholeStackView()
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addArrangedSubview(mainStackView)
        self.addArrangedSubview(descriptionLabel)
    }
    
    private func setWholeStackView() {
        self.distribution = .fillProportionally
        self.spacing = 20
        self.axis = .vertical
        self.alignment = .top
    }
    
}

//MARK: - MainStackView
class MainStackView: UIStackView {
    let cocktailImage: UIImageView = {
        let cocktailImage = UIImageView()
        cocktailImage.contentMode = .scaleAspectFit
        cocktailImage.backgroundColor = .lightGray
        return cocktailImage
    }()
    
    let labelView = SummaryOfCocktailView()
    
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
        self.addArrangedSubview(labelView)
        
        cocktailImage.snp.makeConstraints{ make in
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
    }
}

//MARK: - SummaryOfCocktailView
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
        title.font = UIFont.systemFont(ofSize: 20)
        title.textColor = .black
        title.text = "갓파더"
        return title
    }()
    
    var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.font = UIFont.systemFont(ofSize: 14)
        levelLabel.textColor = .black
        levelLabel.text = "난이도"
        
        return levelLabel
    }()
    
    var levelImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    var abvLabel: UILabel = {
        let abvLabel = UILabel()
        abvLabel.font = UIFont.systemFont(ofSize: 14)
        abvLabel.textColor = .black
        abvLabel.text = "도   수"
        
        return abvLabel
    }()
    
    var abvImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    var sugarContentLabel: UILabel = {
        let sugarContentLabel = UILabel()
        sugarContentLabel.font = UIFont.systemFont(ofSize: 14)
        sugarContentLabel.textColor = .black
        sugarContentLabel.text = "당   도"
        
        return sugarContentLabel
    }()
    
    var sugarContentImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        self.backgroundColor = .white
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(subtitleLabel)
        self.addSubview(titleLabel)
        self.addSubview(levelLabel)
        self.addSubview(abvLabel)
        self.addSubview(sugarContentLabel)
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalToSuperview().offset(2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(2)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(2)
        }
        
        abvLabel.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(2)
        }
        
        sugarContentLabel.snp.makeConstraints { make in
            make.top.equalTo(abvLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
}









//MARK: - HoldedIngredientView
class HoldedIngredientView: UIStackView {
    private func setWholStackView() {
        self.distribution = .fillProportionally
        self.spacing = 10
        self.axis = .vertical
    }
    
    private lazy var baseLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private lazy var ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private lazy var garnishLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
}

