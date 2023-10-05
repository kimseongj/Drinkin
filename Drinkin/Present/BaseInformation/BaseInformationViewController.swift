//
//  BaseInformationViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit
import Combine

final class BaseInformationViewController: UIViewController {
    private var viewModel: BaseInformationViewModel?
    private var cancelBag: Set<AnyCancellable> = []
    private var brandDataSource: UICollectionViewDiffableDataSource<Section, BrandDescription>!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 24)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 15)
        
        return label
    }()
    
    private lazy var baseBrandCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    
    init(viewModel: BaseInformationViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor()
        configureUI()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(baseBrandCollectionView)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        baseBrandCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - CompositionalLayout
extension BaseInformationViewController {
    private func configureCompositionalIconLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
}

//MARK: - DiffableDataSource
extension BaseInformationViewController {
    private func configureDataSource() {
        brandDataSource = UICollectionViewDiffableDataSource<Section,BrandDescription> (collectionView: baseBrandCollectionView) { (collectionView, indexPath, brandDescription) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.identifier, for: indexPath) as? BrandCell else { return nil }
            
            return cell
        }
    }
    
    private func applySnapshot(brandDescriptionList: [BrandDescription]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BrandDescription>()
        snapshot.appendSections([.main])
        snapshot.appendItems(brandDescriptionList)
        brandDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension BaseInformationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - Binding
extension BaseInformationViewController {
    private func binding() {
        guard let viewModel else { return }
        
        viewModel.baseBrandListPublisher.sink {
            self.applySnapshot(brandDescriptionList: $0)
        }.store(in: &cancelBag)
    }
}
