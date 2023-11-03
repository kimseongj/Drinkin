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
    weak var delegate: MainViewDelegate?
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
 
    init(viewModel: CocktailRecommendViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureBackgroundColor()
        configureUI()
        setupRecommendCocktailCollectionView()
        configureDataSource()
        binding()
        viewModel.fetchBriefDescription()
    }
    
    func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(logoImage)
        view.addSubview(recommendCocktailCollectionView)
        
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeArea)
            make.height.equalTo(15)
            make.width.equalTo(80)
        }
        
        recommendCocktailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func sendDelegate(_ delegate: MainViewDelegate?) {
        self.delegate = delegate
    }
    
    func setupRecommendCocktailCollectionView() {
        recommendCocktailCollectionView.register(CocktailRecommendCell.self, forCellWithReuseIdentifier: CocktailRecommendCell.identifier)
        recommendCocktailCollectionView.delegate = self
    }
    
    private func calculateItemSize() -> CGSize {
        let itemSize = CGSize(width: view.bounds.width * 0.85, height: view.bounds.height * 0.75)
        
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

extension CocktailRecommendViewController: CellButtonDelegate {
    func pushProductDetailVC(withID cocktailID: Int) {
        delegate?.pushProductDetailVC(cocktailID: cocktailID)
        print(cocktailID)
    }
}
