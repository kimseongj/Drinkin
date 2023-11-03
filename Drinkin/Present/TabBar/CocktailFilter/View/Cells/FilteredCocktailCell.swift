//
//  FilteredCocktailCollectionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/27.
//

import UIKit
import SnapKit

final class FilteredCocktailCell: UICollectionViewCell {
    private enum Constant {
        
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 20)
        
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 9
        
        return stackView
    }()
    
    private let firstSubStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let secondSubStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        return stackView
    }()
    
    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
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
        firstSubStackView.subviews.forEach { $0.removeFromSuperview() }
        secondSubStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainStackView)
        contentView.addSubview(cocktailImageView)
        mainStackView.addArrangedSubview(firstSubStackView)
        mainStackView.addArrangedSubview(secondSubStackView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        mainStackView.snp.makeConstraints {
            $0.width.equalTo(205)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        cocktailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.width.equalTo(70)
        }
    }
    
    func fill(with previewDescription: CocktailPreview) {
        guard let imageURI = URL(string: previewDescription.imageURI) else { return }
        
        titleLabel.text = previewDescription.cocktailNameKo
        cocktailImageView.load(url: imageURI)
        configureScoreView(levelScore: previewDescription.levelGrade,
                           sugarContentScore: previewDescription.sugarContentGrade,
                           abvScore: previewDescription.abvGrade,
                           ingredientQuantity: previewDescription.ingredientQuantity)
    }
    
    private func configureScoreView(levelScore: Int, sugarContentScore: Int, abvScore: Int, ingredientQuantity: Int) {
        let levelGradePresentationView = GradePresentationView(title: "난이도", grade: levelScore)
        let sugarContentPresentationView = GradePresentationView(title: "당    도", grade: sugarContentScore)
        let abvGradePresentationView = GradePresentationView(title: "도    수", grade: abvScore)
        let ingredientPresentationView = IngredientQuantityView(ingredientQuantity: ingredientQuantity)
        
        firstSubStackView.addArrangedSubview(levelGradePresentationView)
        firstSubStackView.addArrangedSubview(sugarContentPresentationView)
        secondSubStackView.addArrangedSubview(abvGradePresentationView)
        secondSubStackView.addArrangedSubview(ingredientPresentationView)
    }
}
