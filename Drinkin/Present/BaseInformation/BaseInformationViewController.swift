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
    private var brandDataSource: UICollectionViewDiffableDataSource<Section, BrandImageDescription>!
    
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
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var baseBrandCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalIconLayout())
        collectionView.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.identifier)
        
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
        configureDataSource()
        binding()
        viewModel?.fetchBaseDesription()
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
            $0.height.equalTo(400)
            $0.width.equalToSuperview()
        }
    }
    
    private func fill(with baseDescription: BaseDescription?) {
        guard let validBaseDescription = baseDescription else { return }
        
        titleLabel.text = validBaseDescription.baseName
        descriptionLabel.text = validBaseDescription.baseDescription
        applySnapshot(brandImageDescriptionList: validBaseDescription.brandList)
    }
}

//MARK: - BaseBrandCollectionView Delegate
extension BaseInformationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            
            return section
        }
        return layout
    }
}

//MARK: - DiffableDataSource
extension BaseInformationViewController {
    private func configureDataSource() {
        brandDataSource = UICollectionViewDiffableDataSource<Section,BrandImageDescription> (collectionView: baseBrandCollectionView) { (collectionView, indexPath, brandImageDescription) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.identifier, for: indexPath) as? BrandCell else { return nil }
            
            cell.fill(with: brandImageDescription)
            
            return cell
        }
    }
    
    private func applySnapshot(brandImageDescriptionList: [BrandImageDescription]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BrandImageDescription>()
        snapshot.appendSections([.main])
        snapshot.appendItems(brandImageDescriptionList)
        brandDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension BaseInformationViewController {
    private func binding() {
        viewModel?.baseDescriptionPublisher.receive(on: RunLoop.main).sink {
            self.fill(with: $0)
        }.store(in: &cancelBag)
    }
}
