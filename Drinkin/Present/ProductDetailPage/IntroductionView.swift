//
//  IntroductionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit
import SnapKit

class IntroductionView: UIView {
    
    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray3
        
        return imageView
    }()
    
    private let cocktailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 24)
        
        return label
    }()
    
    private let cocktailTDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        
        return label
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalIconLayout())
        collectionView.backgroundColor = .gray
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        
        return collectionView
    }()
    
    private let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피"
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 20)
        
        return label
    }()
    
    private let recipeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 15)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let recipeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
        configureItemCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(cocktailImageView)
        self.addSubview(cocktailTitleLabel)
        self.addSubview(cocktailTDescriptionLabel)
        self.addSubview(itemCollectionView)
        self.addSubview(recipeTitleLabel)
        self.addSubview(recipeStackView)
        
        cocktailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        cocktailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(cocktailImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        cocktailTDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cocktailTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        itemCollectionView.snp.makeConstraints { make in
            make.top.equalTo(cocktailTDescriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(400)
        }
        
        recipeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemCollectionView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }
        
        recipeStackView.snp.makeConstraints { make in
            make.top.equalTo(recipeTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureItemCollectionView() {
        itemCollectionView.dataSource = self
    }
    
    private func updateItemCollectionViewHeight() {
        itemCollectionView.snp.makeConstraints {
            $0.height.equalTo(itemCollectionView.contentSize.height)
        }
    }
    
    func fill(with cocktailDesription: CocktailDescription) {
        guard let validImageURL = URL(string: cocktailDesription.imageURI) else { return }
        
        cocktailImageView.load(url: validImageURL)
        cocktailTitleLabel.text = cocktailDesription.cocktailNameKo
        cocktailTDescriptionLabel.text = cocktailDesription.description
        fillRecipeStackView(with: cocktailDesription.recipeList)
    }
    
    func fillRecipeStackView(with recipeList: [String]) {
        recipeList.forEach {
            let label = UILabel()
            label.font = UIFont(name: "Pretendard-Bold", size: 15)
            label.numberOfLines = 0
            label.text = $0
            recipeStackView.addArrangedSubview(label)
        }
    }
}

extension IntroductionView {
    private func configureCompositionalIconLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension IntroductionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        
        updateItemCollectionViewHeight()

        return cell
    }
}
