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
    private var viewModel: BaseInformationViewModel
    var flowDelegate: BaseInformationVCFlow?
    private var cancelBag: Set<AnyCancellable> = []
    private var brandImageDescriptionDataSource: UICollectionViewDiffableDataSource<Section, BrandImageDescription>!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 40
        
        return stackView
    }()
    
    private let informationView = UIView()
    
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.register(BrandCell.self, forCellWithReuseIdentifier: BrandCell.identifier)
        
        return collectionView
    }()
    
    //MARK: - Init
    
    init(viewModel: BaseInformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        binding()
        errorBinding()
        configureDataSource()
        configureUI()
        showActivityIndicator()
        configureBaseBrandCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppCoordinator.tabBarController.tabBar.isHidden = true
    }
    
    //MARK: - Fetch Data
    private func fetchData() {
        viewModel.fetchBaseDetail() { 
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.hideActivityIndicator()
            }
        }
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(informationView)
        informationView.addSubview(titleLabel)
        informationView.addSubview(descriptionLabel)
        stackView.addArrangedSubview(baseBrandCollectionView)
        
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        baseBrandCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Fill View
    
    private func fill(with baseDescription: BaseDetail?) {
        guard let validBaseDescription = baseDescription else { return }
        
        titleLabel.text = validBaseDescription.baseName
        descriptionLabel.text = validBaseDescription.baseDescription
        applySnapshot(brandImageDescriptionList: validBaseDescription.brandList)
    }
}

//MARK: - ConfigureCollectionVIew

extension BaseInformationViewController {
    private func configureBaseBrandCollectionView() {
        baseBrandCollectionView.delegate = self
    }
}


//MARK: - DiffableDataSource

extension BaseInformationViewController {
    private func configureDataSource() {
        brandImageDescriptionDataSource = UICollectionViewDiffableDataSource<Section,BrandImageDescription> (collectionView: baseBrandCollectionView) { (collectionView, indexPath, brandImageDescription) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCell.identifier, for: indexPath) as? BrandCell else { return nil }
            
            cell.fill(with: brandImageDescription)
            
            return cell
        }
    }
    
    private func applySnapshot(brandImageDescriptionList: [BrandImageDescription]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BrandImageDescription>()
        snapshot.appendSections([.main])
        snapshot.appendItems(brandImageDescriptionList)
        brandImageDescriptionDataSource?.apply(snapshot, animatingDifferences: true)
        updateCollectionViewHeight(cellCount: brandImageDescriptionList.count)
    }
    
    private func updateCollectionViewHeight(cellCount: Int) {
        var cellLineCount: Float = ceil(Float(cellCount) / 2)
        let cellLineHeigt: CGFloat = view.bounds.width / 2 + 10
        
        if cellLineCount == 0 {
            cellLineCount = 1
        }
        
        baseBrandCollectionView.snp.makeConstraints {
            $0.height.equalTo(cellLineHeigt * CGFloat(cellLineCount))
        }
    }
}

//MARK: - Binding

extension BaseInformationViewController {
    private func binding() {
        viewModel.baseDetailPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            
            self.fill(with: $0)
        }.store(in: &cancelBag)
    }
}

//MARK: - CompositionalLayout

extension BaseInformationViewController {
    private func configureCompositionalLayout() -> UICollectionViewLayout {
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

//MARK: - BaseBrandCollectionView Delegate

extension BaseInformationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let brandID = viewModel.returnBrandID(index: indexPath.row)
        flowDelegate?.pushBaseBrandInformationVC(brandID: brandID)
    }
}

//MARK: - Handling Error

extension BaseInformationViewController {
    func errorBinding() {
        viewModel.errorHandlingPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.handlingError(errorType: $0)
            }).store(in: &cancelBag)
    }
}
