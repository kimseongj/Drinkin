//
//  IntroductionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit
import SnapKit

final class IntroductionView: UIView {
    private weak var delegate: ProductDetailVCDelegate?
    private var baseDataSource: UICollectionViewDiffableDataSource<Section, DetailBase>?
    private var ingredientDataSource: UICollectionViewDiffableDataSource<Section, DetailIngredient>?
    private var ingredientIDList: [Int] = []
    private var baseIDList: [Int] = []
    
    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let cocktailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 24)
        
        return label
    }()
    
    private let cocktailTDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 14)
        
        return label
    }()
    
    lazy var baseCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureBaseCompositionalLayout())
        collectionView.register(RecipeBaseCell.self, forCellWithReuseIdentifier: RecipeBaseCell.identifier)
        
        return collectionView
    }()
    
    lazy var ingredientCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureItemCompositionalLayout())
        collectionView.register(RecipeItemCell.self, forCellWithReuseIdentifier: RecipeItemCell.identifier)
        
        return collectionView
    }()
    
    private let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피"
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 20)
        
        return label
    }()
    
    private let recipeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
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
        configureUI()
        configureBaseCollectionView()
        configureBaseDataSource()
        configureIngredientDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        
        self.addSubview(cocktailImageView)
        self.addSubview(cocktailTitleLabel)
        self.addSubview(cocktailTDescriptionLabel)
        self.addSubview(baseCollectionView)
        self.addSubview(ingredientCollectionView)
        self.addSubview(recipeTitleLabel)
        self.addSubview(recipeStackView)
        
        cocktailImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(120)
        }
        
        cocktailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cocktailImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        cocktailTDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(cocktailTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        baseCollectionView.snp.makeConstraints {
            $0.top.equalTo(cocktailTDescriptionLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        ingredientCollectionView.snp.makeConstraints {
            $0.top.equalTo(baseCollectionView.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        recipeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientCollectionView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        recipeStackView.snp.makeConstraints {
            $0.top.equalTo(recipeTitleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureBaseCollectionView() {
        baseCollectionView.delegate = self
    }
       
    func updateBaseCollectionViewHeight(collectionView: UICollectionView, cellCount: Int) {
        collectionView.snp.makeConstraints {
            $0.height.equalTo(cellCount * 70)
        }
    }
    
    func updateItemCollectionViewHeight(collectionView: UICollectionView, cellCount: Int) {
        collectionView.snp.makeConstraints {
            $0.height.equalTo(cellCount * 50)
        }
    }
    
    func configureDelegate(delegate: ProductDetailVCDelegate?) {
        self.delegate = delegate
    }
    
    func fill(with cocktailDesription: CocktailDescription) {
        guard let validImageURL = URL(string: cocktailDesription.imageURI) else { return }
        
        cocktailImageView.load(url: validImageURL)
        cocktailTitleLabel.text = cocktailDesription.cocktailNameKo
        cocktailTDescriptionLabel.text = cocktailDesription.description
        fillRecipeStackView(with: cocktailDesription.recipeList)
        
        baseIDList = cocktailDesription.baseList.map { $0.id }
        ingredientIDList = cocktailDesription.ingredientList.map { $0.id }
    }
    
    func fillRecipeStackView(with recipeList: [String]) {
        recipeList.forEach {
            let label = UILabel()
            label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
            label.numberOfLines = 0
            label.text = $0
            recipeStackView.addArrangedSubview(label)
        }
    }
}

extension IntroductionView {
    private func configureBaseCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureItemCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

//MARK: - BaseDiffableDataSource
extension IntroductionView {
    private func configureBaseDataSource() {
        self.baseDataSource = UICollectionViewDiffableDataSource<Section, DetailBase> (collectionView: baseCollectionView) { (collectionView, indexPath, detailCategory) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeBaseCell.identifier, for: indexPath) as? RecipeBaseCell else { return nil }
            
            cell.check(hold: detailCategory.hold)
            cell.fill(detailCategory: detailCategory)
            
            return cell
        }
    }
    
    func applybaseSnapshot(detailCategoryList: [DetailBase]?) {
        guard let validDetailCategoryList = detailCategoryList else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DetailBase>()
        snapshot.appendSections([.main])
        snapshot.appendItems(validDetailCategoryList)
        self.baseDataSource?.apply(snapshot, animatingDifferences: true)
        updateBaseCollectionViewHeight(collectionView: baseCollectionView, cellCount: validDetailCategoryList.count)
    }
}

//MARK: - IngredientDiffableDataSource
extension IntroductionView {
    private func configureIngredientDataSource() {
        self.ingredientDataSource = UICollectionViewDiffableDataSource<Section, DetailIngredient> (collectionView: ingredientCollectionView) { (collectionView, indexPath, detailIngredient) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeItemCell.identifier, for: indexPath) as? RecipeItemCell else { return nil
            }
            
            cell.check(hold: detailIngredient.hold)
            cell.fill(detailIgredient: detailIngredient)
            
            return cell
        }
    }
    
    func applyIngredientSnapshot(detailIngredientList: [DetailIngredient]?) {
        guard let validDetailIngredientList = detailIngredientList else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DetailIngredient>()
        snapshot.appendSections([.main])
        snapshot.appendItems(validDetailIngredientList)
        self.ingredientDataSource?.apply(snapshot, animatingDifferences: true)
        updateItemCollectionViewHeight(collectionView: ingredientCollectionView, cellCount: validDetailIngredientList.count)
    }
}

extension IntroductionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == baseCollectionView {
            delegate?.pushBaseInformationVC(baseID: baseIDList[indexPath.row])
        } else {
            
        }
    }
}
