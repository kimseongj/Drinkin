//
//  CocktailFilterViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/15.
//

import UIKit
import SnapKit
import Combine

final class CocktailFilterViewController: UIViewController, CocktailFilterDelegate {
    private var filterDataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var cocktailDataSource: UICollectionViewDiffableDataSource<Section, PreviewDescription>!
    
    private var cancelBag: Set<AnyCancellable> = []
    
    var viewModel: CocktailFilterViewModel?
    
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
    
    private let filterSelectionCollectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(FilterSelectionCell.self, forCellWithReuseIdentifier: FilterSelectionCell.identifier)
  
        return view
    }()
    
    private lazy var filteredCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FilteredCocktailCell.self, forCellWithReuseIdentifier: FilteredCocktailCell.identifier)
        
        return collectionView
    }()
    
    init(viewModel: CocktailFilterViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSelectionFilterCollectionView()
        makeSelectionFilterCollectionViewDisable()
        viewModel?.fetchCocktailFilter(completion: { [weak self] in
            self?.makeSelectionFilterCollectionViewEnable()
        })
        configureFilterDataSource()
        filterBinding()
    }
    
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(initializationButton)
        view.addSubview(filterSelectionCollectionView)
        view.addSubview(filteredCollectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        initializationButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        filterSelectionCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(60)
        }
        
        filteredCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterSelectionCollectionView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
    }
    
    private func configureSelectionFilterCollectionView() {
        filterSelectionCollectionView.delegate = self
    
        if let flowLayout = filterSelectionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func makeSelectionFilterCollectionViewDisable() {
        filterSelectionCollectionView.isUserInteractionEnabled = false
    }
    
    private func makeSelectionFilterCollectionViewEnable() {
        filterSelectionCollectionView.isUserInteractionEnabled = true
    }
    
    @objc private func tapInitializationButton() {
    }
    
    func checkSelectedFilter() {
   
    }
}

//MARK: - FilterSelectionCollectionView DiffableDataSource
extension CocktailFilterViewController {
    private func configureFilterDataSource() {
        filterDataSource = UICollectionViewDiffableDataSource<Section, String> (collectionView: filterSelectionCollectionView) { (collectionView, indexPath, categoryName) in
//            guard let viewModel = viewModel else { return }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterSelectionCell.identifier, for: indexPath) as? FilterSelectionCell else { return UICollectionViewCell() }
            
            cell.fill(with: categoryName)
            
            if self.viewModel?.textFilterTypeList[indexPath.row] != self.viewModel?.filterTypeList[indexPath.row].description {
                cell.makeFixedCell()
            }

            return cell
        }
    }
    
    private func applyFilterSnapshot(filterList: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filterList)
        self.filterDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - FilteredCollectionView DiffableDataSource
extension CocktailFilterViewController {
    private func configureCocktailDataSource() {
        cocktailDataSource = UICollectionViewDiffableDataSource<Section, PreviewDescription> (collectionView: filteredCollectionView) { collectionView, indexPath, filteredItem in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredCocktailCell.identifier, for: indexPath) as? FilteredCocktailCell else { return nil }
            
            cell.fill(with: filteredItem)
            
            return cell
        }
    }
    
    private func applyCocktailSnapshot(filteredItems: [PreviewDescription]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PreviewDescription>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        self.cocktailDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension CocktailFilterViewController {
    private func filterBinding() {
        viewModel?.textFilterTypeListPublisher.receive(on: RunLoop.main).sink {
            self.applyFilterSnapshot(filterList: $0)
        }.store(in: &cancelBag)
    }
}

extension CocktailFilterViewController {
    private func cocktailBinding() {
        viewModel?.filteredCocktailListPublisher.receive(on: RunLoop.main).sink {
            self.applyCocktailSnapshot(filteredItems: $0)
        }.store(in: &cancelBag)
    }
}

//MARK: - FilteredCocktailCollectionView Compositional Layout
extension CocktailFilterViewController {
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

//MARK: - FilteredCollectionView, FilterSelectionCollectionView Delegate
extension CocktailFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterSelectionCollectionView {
            guard let viewModel = viewModel else { return }
            
            let cocktailFilterModalViewController = CocktailFilterModalViewController(filterType: viewModel.filterTypeList[indexPath.row], viewModel: viewModel)
            cocktailFilterModalViewController.modalPresentationStyle = .overFullScreen
            present(cocktailFilterModalViewController, animated: false)
        } else {
            
        }
    }
}
