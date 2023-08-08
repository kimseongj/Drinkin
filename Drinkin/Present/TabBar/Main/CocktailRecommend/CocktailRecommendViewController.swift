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
    private enum Constant {
        static let heightRatio = 0.7
        static let widthRatio = 0.8
        static let itemSpacing = 18.0
    }
    
    weak var delegate: MainViewDelegate?
    private var dataSource: UICollectionViewDiffableDataSource<Section, BriefDescription>?
    private var cancelBag: Set<AnyCancellable> = []
    
    private var viewModel: CocktailRecommendViewModel?
    
    private lazy var carouselFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = calculateItemSize()
        layout.minimumLineSpacing = Constant.itemSpacing
        
        return layout
    }()
    
    private let logoImage2: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "drinkinLogo")
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
    
    private let view1: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
 
    override func viewDidLoad() {
        configureUI()
        setupRecommendCocktailCollectionView()
        configureDataSource()
        binding()
        viewModel?.fetchBriefDescription()
    }
    
    init(viewModel: CocktailRecommendViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        view.addSubview(logoImage2)
        view.addSubview(recommendCocktailCollectionView)
        
        logoImage2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeArea)
            make.height.equalTo(15)
            make.width.equalTo(80)
        }
        
        recommendCocktailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImage2.snp.bottom).offset(20)
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
    
    @objc func seeMoreButtonAction() {
        guard let cocktailID = viewModel?.cocktailID else { return }
        print(cocktailID)
        delegate?.pushProductDetailVC(cocktailID: cocktailID)
    }
    
    private func calculateItemSize() -> CGSize {
        let itemSize = CGSize(width: view.bounds.width * 0.85, height: view.bounds.height * 0.75)
        
        return itemSize
    }
    
    private func calculateContentInset() -> UIEdgeInsets {
        let insetX = (view.bounds.width - calculateItemSize().width) / 2.0
        let insetY = (view.bounds.height - calculateItemSize().height) / 2.0
        let collectionViewContentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        return collectionViewContentInset
    }
}

//MARK: - DiffableDataSource
extension CocktailRecommendViewController {
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, BriefDescription> (collectionView: recommendCocktailCollectionView) { (collectionView, indexPath, briefDescription) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailRecommendCell.identifier, for: indexPath) as? CocktailRecommendCell else { return nil
            }
            
            self.viewModel?.cocktailID = briefDescription.id
            
            cell.configureCell(briefDescription: briefDescription)
            cell.seeMoreButton.addTarget(self, action: #selector(self.seeMoreButtonAction), for: .touchUpInside)
            
            return cell
        }
    }
    
    private func applySnapshot(briefDescriptionList: [BriefDescription]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BriefDescription>()
        snapshot.appendSections([.main])
        snapshot.appendItems(briefDescriptionList)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension CocktailRecommendViewController {
    private func binding() {
        guard let viewModel else { return }
        
        viewModel.briefDescriptionListPublisher.sink {
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
    let cellWidth = calculateItemSize().width + Constant.itemSpacing
    let index = round(scrolledOffsetX / cellWidth)
    targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
  }
}
