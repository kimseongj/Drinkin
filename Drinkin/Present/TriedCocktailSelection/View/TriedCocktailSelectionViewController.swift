//
//  TriedCocktailSelectionViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit
import Combine

final class TriedCocktailSelectionViewController: UIViewController {
    var delegate: TriedCocktailSelectionVCDelegate?
    private var cancelBag: Set<AnyCancellable> = []
    private var viewModel: TriedCocktailSelectionViewModel
    private var cocktailDataSource: UICollectionViewDiffableDataSource<Section, SelectablePreviewDescription>?
   
    
    //MARK:- mainLabel
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "마셔봤던 칵테일 선택"
        
        return label
    }()
    
    //MARK:- subLabel
    private let subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1)
        label.text = "선택을 기반으로 다양한 칵테일을 추천해 드립니다."
        
        return label
    }()
    
    //MARK:- exitButton
    private let exitButton: UIButton = {
        let exitButton = UIButton()
        exitButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        exitButton.addTarget(self, action: #selector(presentPopupViewController), for: .touchUpInside)
        
        return exitButton
    }()
    
    //MARK:- baseCollectionView
    private let categoryCollectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        
        return view
    }()
    
    //MARK:- cocktailCollectionView
    private lazy var cocktailCollectionView: UICollectionView = {
        let flowLayout = configureCompositionalLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.clipsToBounds = true
        collectionView.register(CocktailSelectionCell.self, forCellWithReuseIdentifier: CocktailSelectionCell.identifier)
        
        return collectionView
    }()
    
    
    private let completeSelectionButton: UIButton = {
        let completeSelectionButton = UIButton()
        completeSelectionButton.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        completeSelectionButton.layer.borderWidth = 3
        completeSelectionButton.backgroundColor = .black
        completeSelectionButton.titleLabel?.textColor = UIColor(red: 0.909, green: 0.906, blue: 0.903, alpha: 1)
        completeSelectionButton.titleLabel?.font = UIFont(name: "Pretendard-Black", size: 15)
        
        return completeSelectionButton
    }()
    
    init(viewModel: TriedCocktailSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        MainViewController.login = true
        configureCocktailCollectionView()
        configureBaseTypeCollectionView()
        renewCompleteSelectionButton()
        configureCocktailDataSource()
        binding()
        viewModel.fetchCocktailPreviewDescription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(exitButton)
        view.addSubview(categoryCollectionView)
        view.addSubview(cocktailCollectionView)
        view.addSubview(completeSelectionButton)
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(22)
            $0.trailing.equalToSuperview().offset(-22)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(exitButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
        }
        
        cocktailCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(7)
            $0.trailing.equalToSuperview().offset(-7)
            $0.bottom.equalTo(completeSelectionButton.snp.top)
        }
        
        completeSelectionButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeArea.snp.bottom)
            $0.height.equalTo(54)
        }
    }
    
    private func configureCocktailCollectionView() {
        cocktailCollectionView.delegate = self
    }
    
    private func configureBaseTypeCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        if let flowLayout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func renewCompleteSelectionButton(isCellsSelected: Bool = false) {
        switch isCellsSelected {
        case false:
            completeSelectionButton.setTitle("다음", for: .normal)
            completeSelectionButton.removeTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
            completeSelectionButton.addTarget(self, action: #selector(presentPopupViewController), for: .touchUpInside)
        case true:
            completeSelectionButton.setTitle("선택 완료", for: .normal)
            completeSelectionButton.removeTarget(self, action: #selector(presentPopupViewController), for: .touchUpInside)
            completeSelectionButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        }
    }
    
    @objc
    private func presentPopupViewController() {
        let recommendPopupViewController = RecommendPopupViewController()
        recommendPopupViewController.delegate = self
        recommendPopupViewController.modalPresentationStyle = .formSheet
        present(recommendPopupViewController, animated: true)
    }
    
    @objc
    private func dismissViewController() {
        self.dismiss(animated: true)
    }
}

//MARK: - CategoryDataSource
extension TriedCocktailSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categoryListCount = viewModel.categoryList.count
        
        return categoryListCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        let categoryListName = viewModel.categoryList[indexPath.row]
        
        if categoryListName == CategoryListStrings.whole {
            cell.isSelected = true
        }
        
        cell.fill(with: categoryListName)
        
        return cell
    }
}

//MARK: - cocktailCollectionView, categoryCollectionView Delegate
extension TriedCocktailSelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let currentCategoryName = viewModel.categoryList[indexPath.row]
            viewModel.currentCategoryName = currentCategoryName
            viewModel.filterCocktailList()
        } else {
            
            if let cell = cocktailCollectionView.cellForItem(at: indexPath) as? CocktailSelectionCell {
                cell.presentSelected()
            }
            viewModel.selectCocktail(index: indexPath.row)
            renewCompleteSelectionButton(isCellsSelected: viewModel.checkCocktailSelected())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == cocktailCollectionView {
            guard let cell = cocktailCollectionView.cellForItem(at: indexPath) as? CocktailSelectionCell else { return }
            
            viewModel.deselectCocktail(index: indexPath.row)
            renewCompleteSelectionButton(isCellsSelected: viewModel.checkCocktailSelected())
            cell.presentDeselected()
        }
    }
}

//MARK: - CocktailDiffableDataSource
extension TriedCocktailSelectionViewController {
    private func configureCocktailDataSource() {
        cocktailDataSource = UICollectionViewDiffableDataSource<Section, SelectablePreviewDescription> (collectionView: cocktailCollectionView) { [weak self] (collectionView, indexPath, previewDescription) -> UICollectionViewCell? in
            guard let self = self, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailSelectionCell.identifier, for: indexPath) as? CocktailSelectionCell else { return nil
            }
            
            cell.fill(with: previewDescription)
            
            self.cocktailCollectionView.deselectItem(at: indexPath, animated: true)
            
            if previewDescription.isSelected == true {
                cell.presentSelected()
                self.cocktailCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            } else {
                cell.presentDeselected()
                self.cocktailCollectionView.deselectItem(at: indexPath, animated: true)
            }
            
            return cell
        }
    }
    
    private func applySnapshot(previewDescriptionList: [SelectablePreviewDescription]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SelectablePreviewDescription>()
        snapshot.appendSections([.main])
        snapshot.appendItems(previewDescriptionList)
        self.cocktailDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension TriedCocktailSelectionViewController {
    private func binding() {
        viewModel.filteredSelectableCocktailListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            self.applySnapshot(previewDescriptionList: $0)
        }.store(in: &cancelBag)
    }
}

//MARK: - CompositionalLayout
extension TriedCocktailSelectionViewController {
    private func configureCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
}

//MARK: - Dismiss ViewController
extension TriedCocktailSelectionViewController: DismissTriedCocktailSelectionVCDelegate {
    func dismissTriedCocktailSelectionViewController() {
        self.dismiss(animated: true)
    }
}
