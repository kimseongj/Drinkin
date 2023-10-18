//
//  TipAndContentViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/06.
//

import UIKit
import SnapKit
import Combine

final class TipAndContentViewController: UIViewController {
    private let viewModel: TipAndContentViewModel = DefaultTipAndContentViewModel()
    private var cancelBag: Set<AnyCancellable> = []
    private var tipAndContentDataSource: UICollectionViewDiffableDataSource<Section, TipAndContent>?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "팁과 컨텐츠"
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 20)
        
        return label
    }()
    
    private lazy var tipAndContentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TipAndContentCell.self, forCellWithReuseIdentifier: TipAndContentCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        binding()
        viewModel.fetchTipAndContentList()
        configureItemCell()
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(tipAndContentCollectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        tipAndContentCollectionView.snp.makeConstraints {
            $0.height.equalTo(220)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(4)
            $0.trailing.equalToSuperview().offset(-4)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func configureItemCell() {
        if let flowLayout = tipAndContentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

//MARK: - DiffableDataSource
extension TipAndContentViewController {
    private func configureDataSource() {
        tipAndContentDataSource = UICollectionViewDiffableDataSource<Section,TipAndContent> (collectionView: tipAndContentCollectionView) { (collectionView, indexPath, tipAndContent) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipAndContentCell.identifier, for: indexPath) as? TipAndContentCell else { return nil }
            
            cell.fill(with: tipAndContent)
            
            return cell
        }
    }
    
    private func applySnapshot(tipAndContentList: [TipAndContent]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TipAndContent>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tipAndContentList)
        tipAndContentDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension TipAndContentViewController {
    private func binding() {
        viewModel.tipAndContentListPublisher.receive(on: RunLoop.main).sink {
            self.applySnapshot(tipAndContentList: $0)
        }.store(in: &cancelBag)
    }
}
