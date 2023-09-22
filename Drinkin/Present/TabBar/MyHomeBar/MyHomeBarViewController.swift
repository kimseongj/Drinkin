//
//  MyHomeBarViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit
import SnapKit
import Combine

class MyHomeBarViewController: UIViewController {
    var delegate: MyHomeBarVCDelegate?
    private var cancelBag: Set<AnyCancellable> = []
    private var viewModel: MyHomeBarViewModel?
    private var isTrue: Bool = true
    private var holdedItemDataSource: UICollectionViewDiffableDataSource<Section, String>?
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 홈바"
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 20)
        
        return label
    }()
    
    private let convertableItemView = UIView()
    
    private let holdIngredientLabel: UILabel = {
        let label = UILabel()
        label.text = "가지고 있는 재료"
        label.font = UIFont(name: "Pretendard-Bold", size: 17)
        
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vertical_elipsis"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private let addItemView = UIView()
    
    private let addLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "첫번 째 재료를 추가하고"
        
        return label
    }()
    
    private let addLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "만들 수 있는 칵테일을 찾아보세요."
        
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Black", size: 15)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        button.layer.borderWidth = 3
        
        return button
    }()
    
    private let holdedItemCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = MutableSizeCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collectionView.register(HoldedItemCell.self, forCellWithReuseIdentifier: HoldedItemCell.identifier)
        collectionView.backgroundColor = .white
 
        return collectionView
    }()
    
    private let savedCocktailListButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapSavedCocktailListButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "저장한 칵테일 목록"
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 17)
        
        let arrowImageView = UIImageView(image: UIImage(named: "arrow_icon"))
        
        button.addSubview(titleLabel)
        button.addSubview(arrowImageView)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
            $0.size.equalTo(30)
        }
        
        return button
    }()
    
    private let userMadeCocktailListButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapUserMadeCocktailListButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "내가 만든 칵테일 목록"
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 17)
        
        let arrowImageView = UIImageView(image: UIImage(named: "arrow_icon"))
        
        button.addSubview(arrowImageView)
        button.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
            $0.size.equalTo(30)
        }
        
        return button
    }()
        
    init(viewModel: MyHomeBarViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHoldedItemCollectionView()
        viewModel?.fetchHoldedItem()
        configureDataSource()
        binding()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(moreButton)
        view.addSubview(holdIngredientLabel)
        view.addSubview(convertableItemView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
            $0.height.width.equalTo(28)
        }
        
        holdIngredientLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        switch isTrue {
        case true:
            configureHoldedItem()
        case false:
            configureItem()
        }
    }
    
    private func configureItem() {
        view.addSubview(addItemView)
        view.addSubview(savedCocktailListButton)
        view.addSubview(userMadeCocktailListButton)
        addItemView.addSubview(addLabel1)
        addItemView.addSubview(addLabel2)
        addItemView.addSubview(addButton)
        
        addItemView.snp.makeConstraints {
            $0.top.equalTo(holdIngredientLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }
        
        addLabel1.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        addLabel2.snp.makeConstraints {
            $0.top.equalTo(addLabel1.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(addLabel2.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(39)
            $0.width.equalTo(108)
            $0.bottom.equalToSuperview().offset(-32)
        }
        
        savedCocktailListButton.snp.makeConstraints {
            $0.top.equalTo(addItemView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        userMadeCocktailListButton.snp.makeConstraints {
            $0.top.equalTo(savedCocktailListButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    private func configureHoldedItem() {
        view.addSubview(holdedItemCollectionView)
        view.addSubview(savedCocktailListButton)
        view.addSubview(userMadeCocktailListButton)
        
        holdedItemCollectionView.snp.makeConstraints {
            $0.top.equalTo(holdIngredientLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        savedCocktailListButton.snp.makeConstraints {
            $0.top.equalTo(holdedItemCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        userMadeCocktailListButton.snp.makeConstraints {
            $0.top.equalTo(savedCocktailListButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    private func configureHoldedItemCollectionView() {
        if let flowLayout = holdedItemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @objc
    private func tapSavedCocktailListButton() {
        delegate?.pushSavedCocktailListVC()
    }
    
    @objc
    private func tapUserMadeCocktailListButton() {
        delegate?.pushUserMadeCocktailListVC()
    }
}

//MARK: - DiffableDataSource
extension MyHomeBarViewController {
    private func configureDataSource() {
        self.holdedItemDataSource = UICollectionViewDiffableDataSource<Section, String> (collectionView: holdedItemCollectionView) { (collectionView, indexPath, itemName) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoldedItemCell.identifier, for: indexPath) as? HoldedItemCell else { return nil }
            cell.fill(with: itemName)
            cell.delegate = self
            
            return cell
        }
    }
    
    private func applySnapshot(holdedItemList: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(holdedItemList)
        self.holdedItemDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension MyHomeBarViewController {
    private func binding() {
        guard let viewModel else { return }
        
        viewModel.holdedItemListPublisher.receive(on: RunLoop.main).sink {
            self.applySnapshot(holdedItemList: $0)
        }.store(in: &cancelBag)
    }
}

extension MyHomeBarViewController: CellDeleteButtonDelegate {
    func deleteHoldedItem(holdedItem: String) {
        viewModel?.deleteHoldedItem(holdedItem: holdedItem)
    }
}

protocol CellDeleteButtonDelegate: AnyObject {
    func deleteHoldedItem(holdedItem: String)
}
