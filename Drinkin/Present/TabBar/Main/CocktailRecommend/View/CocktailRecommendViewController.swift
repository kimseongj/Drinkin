//
//  LoggedinMainView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/16.
//

import UIKit
import SnapKit
import Combine

final class CocktailRecommendViewController: UIViewController {
    private var viewModel: CocktailRecommendViewModel
    private weak var flowDelegate: MainVCFlow?
    private var cancelBag: Set<AnyCancellable> = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, CocktailBrief>?
    
    private lazy var carouselFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = calculateItemSize()
        layout.minimumLineSpacing = 18
        
        return layout
    }()
    
    private let logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = ImageStorage.drinkinLogo
        
        return logoImage
    }()
    
    private lazy var recommendCocktailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: carouselFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.clipsToBounds = true
        collectionView.contentInset = calculateContentInset()
        collectionView.isScrollEnabled = true
        
        return collectionView
    }()
    
    //MARK: - Init
    
    init(viewModel: CocktailRecommendViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        fetchData()
        binding()
        errorBinding()
        configureDataSource()
        configureUI()
        showActivityIndicator()
        configureRecommendCocktailCollectionView()
    }
    
    //MARK: - Fetch Data
    
    func fetchData() {
        viewModel.fetchBriefDescription { 
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.hideActivityIndicator()
            }
        }
    }
    
    //MARK: - ConfigureUI
    
    func configureUI() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(logoImage)
        view.addSubview(recommendCocktailCollectionView)
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeArea)
            $0.height.equalTo(15)
            $0.width.equalTo(80)
        }
        
        recommendCocktailCollectionView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    //MARK: - SendDelegate
    
    func sendDelegate(_ delegate: MainVCFlow?) {
        self.flowDelegate = delegate
    }
}

//MARK: - CellButtonDelegate

extension CocktailRecommendViewController: CellButtonDelegate {
    func pushProductDetailVC(withID cocktailID: Int) {
        flowDelegate?.pushProductDetailVC(cocktailID: cocktailID)
    }
}

//MARK: - ConfigureCollectionView

extension CocktailRecommendViewController {
    func configureRecommendCocktailCollectionView() {
        recommendCocktailCollectionView.register(CocktailRecommendCell.self, forCellWithReuseIdentifier: CocktailRecommendCell.identifier)
        recommendCocktailCollectionView.delegate = self
    }
    
    private func calculateItemSize() -> CGSize {
        let itemSize = CGSize(width: view.bounds.width * 0.85, height: view.bounds.height * 0.72)
        
        return itemSize
    }
    
    private func calculateContentInset() -> UIEdgeInsets {
        let insetX = (view.bounds.width - calculateItemSize().width) / 2.0
        let collectionViewContentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        
        return collectionViewContentInset
    }
}

//MARK: - DiffableDataSource

extension CocktailRecommendViewController {
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, CocktailBrief> (collectionView: recommendCocktailCollectionView) { (collectionView, indexPath, cocktailBrief) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailRecommendCell.identifier, for: indexPath) as? CocktailRecommendCell else { return nil }
            
            cell.delegate = self
            cell.cocktailID = cocktailBrief.id
            cell.configureCell(cocktailBrief: cocktailBrief)
            
            return cell
        }
    }
    
    private func applySnapshot(briefDescriptionList: [CocktailBrief]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailBrief>()
        snapshot.appendSections([.main])
        snapshot.appendItems(briefDescriptionList)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding

extension CocktailRecommendViewController {
    private func binding() {
        viewModel.briefDescriptionListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            self.applySnapshot(briefDescriptionList: $0)
        }.store(in: &cancelBag)
    }
} 

//MARK: - CollectionViewFlowLayout

extension CocktailRecommendViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = calculateItemSize().width + 18
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}

//MARK: - Handling Error

extension CocktailRecommendViewController {
    func errorBinding() {
        viewModel.errorHandlingPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.handlingError(errorType: $0)
            }).store(in: &cancelBag)
    }
}
