//
//  FilterViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/15.
//

import UIKit
import SnapKit
import Combine

class FilterViewController: UIViewController, CocktailFilterDelegate {
    
    private enum Section: CaseIterable {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, PreviewDescription>!
    
    private var cancelBag: Set<AnyCancellable> = []
    
    private let filterViewModel = FilterViewModel()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일 리스트"
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 20)
        
        return label
    }()
    
    private let initializationButton: UIButton = {
        let button = UIButton()
        button.setTitle("필터 초기화", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(tapInitializationButton), for: .touchUpInside)
        
        return button
    }()
    
    private let selectionFilterCollectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(SelectionFilterCell.self, forCellWithReuseIdentifier: SelectionFilterCell.identifier)
  
        return view
    }()
    
    private lazy var filteredCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FilteredCocktailCell.self, forCellWithReuseIdentifier: FilteredCocktailCell.identifier)
        
        return collectionView
    }()
    
    private let data = ["전체 칵테일", "보유 재료", "난이도", "도수", "당도", "재료 수"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        bindFilteredItem()
        configureUI()
        configureSelectionFilterCollectionView()
        filterViewModel.filteredItems = [PreviewDescription(title: "갓파파더", levelGrade: 2, sugarContentGrade: 1, abvGrade: 3, ingredientQuantity: 2), PreviewDescription(title: "갓파더", levelGrade: 2, sugarContentGrade: 1, abvGrade: 3, ingredientQuantity: 2)]
    }
    
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(initializationButton)
        view.addSubview(selectionFilterCollectionView)
        view.addSubview(filteredCollectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        initializationButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        selectionFilterCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(60)
        }
        
        filteredCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectionFilterCollectionView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
    }
    
    func configureSelectionFilterCollectionView() {
        selectionFilterCollectionView.register(SelectionFilterCell.self, forCellWithReuseIdentifier: SelectionFilterCell.identifier)
        selectionFilterCollectionView.delegate = self
        selectionFilterCollectionView.dataSource = self
        
        if let flowLayout = selectionFilterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func bindFilteredItem() {
        filterViewModel.$filteredItems.sink {
            self.applySnapshot(filteredItems: $0)
        }.store(in: &cancelBag)
    }
    
    @objc private func tapInitializationButton() {
    }
    
    func checkSelectedFilter() {
   
    }
}

//MARK: - SelectionFilterCollectionView DataSource
extension FilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectionFilterCollectionView.dequeueReusableCell(withReuseIdentifier: SelectionFilterCell.identifier, for: indexPath) as! SelectionFilterCell
        cell.baseNameLabel.text = data[indexPath.row] + " ▼"

        return cell
    }
    
    
}

//MARK: - FilteredCollectionView, SelectionFilterCollectionView Delegate
extension FilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == selectionFilterCollectionView {
            let cocktailFilterModalViewController = CocktailFilterModalViewController()
            cocktailFilterModalViewController.modalPresentationStyle = .formSheet
            present(cocktailFilterModalViewController, animated: false)
        } else {
            
        }
    }
}

//MARK: - FilteredCollectionView Diffable Data Source
extension FilterViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, PreviewDescription> (collectionView: filteredCollectionView) { collectionView, indexPath, filteredItem in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredCocktailCell.identifier, for: indexPath) as? FilteredCocktailCell else { return nil }
            
            cell.fill(with: filteredItem)
            
            return cell
        }
    }
    
    private func applySnapshot(filteredItems: [PreviewDescription]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PreviewDescription>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
//MARK: - FilteredCocktailCollectionView Compositional Layout
extension FilterViewController {
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
