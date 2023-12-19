//
//  MyHomeBarViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit
import SnapKit
import Combine

protocol CellDeleteButtonDelegate: AnyObject {
    func delete(holdedItem: String)
}

final class MyHomeBarViewController: UIViewController {
    private var viewModel: MyHomeBarViewModel
    var flowDelegate: MyHomeBarVCFlow?
    private var cancelBag: Set<AnyCancellable> = []
    
    private var holdedItemDataSource: UICollectionViewDiffableDataSource<Section, HoldedItem>?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let introduceView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 홈바"
        label.font = UIFont(name: FontStrings.themeFont, size: 20)
        
        return label
    }()
    
    private let holdIngredientLabel: UILabel = {
        let label = UILabel()
        label.text = "가지고 있는 재료"
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 17)
        
        return label
    }()
    
    private lazy var loginSettingButton: UIButton = {
        let button = UIButton()
        if let originalImage = ImageStorage.personCircleIcon {
            let scaledImage = originalImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 36.0))
            button.setImage(scaledImage, for: .normal)
        }
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapLoginSettingButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapLoginSettingButton() {
        flowDelegate?.pushLoginSettingVC()
    }
    
    private lazy var addItemView = UIView()
    
    private lazy var addLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 15)
        label.text = "첫번 째 재료를 추가하고"
        
        return label
    }()
    
    private lazy var addLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 15)
        label.text = "만들 수 있는 칵테일을 찾아보세요."
        
        return label
    }()
    
    private lazy var largeAddButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: FontStrings.pretendardBlack, size: 15)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.layer.borderColor = ColorPalette.buttonBorderColor
        button.layer.borderWidth = 3
        
        return button
    }()
    
    private lazy var smallAddButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: FontStrings.pretendardBlack, size: 15)
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapAddButton() {
        flowDelegate?.pushItemSelectionVC(syncDataDelegate: viewModel)
    }
    
    private let changeableView = UIView()
    
    private lazy var holdedItemCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = MutableSizeCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collectionView.register(HoldedItemCell.self, forCellWithReuseIdentifier: HoldedItemCell.identifier)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private lazy var savedCocktailListButton: UIButton = {
        let button = UIButton()
        let titleLabel = UILabel()
        titleLabel.text = "저장한 칵테일 목록"
        titleLabel.font = UIFont(name: FontStrings.pretendardBold, size: 17)
        
        let arrowImageView = UIImageView(image: ImageStorage.arrowIcon)
        
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
    
    private lazy var userMadeCocktailListButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapUserMadeCocktailListButton), for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = "내가 만든 칵테일 목록"
        titleLabel.font = UIFont(name: FontStrings.pretendardBold, size: 17)
        
        let arrowImageView = UIImageView(image: ImageStorage.arrowIcon)
        
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
    
    //MARK: - Init
    
    init(viewModel: MyHomeBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorBinding()
        configureDataSource()
        configureUI()
        configureHoldedItemCollectionView()
        authenticationBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppCoordinator.tabBarController.tabBar.isHidden = false
    }
    
    //MARK: - Fetch Data
    
    private func fetchData() {
        viewModel.fetchHoldedItem() {
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
        stackView.addArrangedSubview(introduceView)
        introduceView.addSubview(titleLabel)
        introduceView.addSubview(loginSettingButton)
        introduceView.addSubview(holdIngredientLabel)

        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }

        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }

        loginSettingButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.width.equalTo(28)
        }

        holdIngredientLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureListButton(title: String) -> UIButton {
        let button = UIButton()
        let titleLabel = UILabel()
        titleLabel.text = "title"
        titleLabel.font = UIFont(name: FontStrings.pretendardBold, size: 17)
        
        let arrowImageView = UIImageView(image: ImageStorage.arrowIcon)
        
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
    }
    
    private func configureLoggedinMyHomeBar() {
        fetchData()
        binding()
        largeAddButton.removeTarget(self, action: #selector(tapUnloggedinButton), for: .touchUpInside)
        largeAddButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        savedCocktailListButton.removeTarget(self, action: #selector(tapUnloggedinButton), for: .touchUpInside)
        savedCocktailListButton.addTarget(self, action: #selector(tapSavedCocktailListButton), for: .touchUpInside)
        userMadeCocktailListButton.removeTarget(self, action: #selector(tapUnloggedinButton), for: .touchUpInside)
        userMadeCocktailListButton.addTarget(self, action: #selector(tapUserMadeCocktailListButton), for: .touchUpInside)
    }
    
    private func configureUnloggedinMyHomeBar() {
        showAddItemView()
        largeAddButton.removeTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        largeAddButton.addTarget(self, action: #selector(tapUnloggedinButton), for: .touchUpInside)
        savedCocktailListButton.removeTarget(self, action: #selector(tapSavedCocktailListButton), for: .touchUpInside)
        savedCocktailListButton.addTarget(self, action: #selector(tapUnloggedinButton), for: .touchUpInside)
        userMadeCocktailListButton.removeTarget(self, action: #selector(tapUserMadeCocktailListButton), for: .touchUpInside)
        userMadeCocktailListButton.addTarget(self, action: #selector(tapUnloggedinButton), for: .touchUpInside)
    }
    
    @objc
    private func tapSavedCocktailListButton() {
        flowDelegate?.pushSavedCocktailListVC()
    }
    
    @objc
    private func tapUserMadeCocktailListButton() {
        flowDelegate?.pushUserMadeCocktailListVC()
    }
    
    @objc
    private func tapUnloggedinButton() {
        self.showLoginRecommendAlert()
    }
}

//MARK: - ConfigureCollectionView

extension MyHomeBarViewController {
    private func configureHoldedItemCollectionView() {
        if let flowLayout = holdedItemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

//MARK: - DiffableDataSource

extension MyHomeBarViewController {
    private func configureDataSource() {
        self.holdedItemDataSource = UICollectionViewDiffableDataSource<Section, HoldedItem> (collectionView: holdedItemCollectionView) { (collectionView, indexPath, holdedItem) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HoldedItemCell.identifier, for: indexPath) as? HoldedItemCell else { return nil }
            cell.fill(with: holdedItem.itemName)
            cell.delegate = self
            
            return cell
        }
    }
    
    private func applySnapshot(holdedItemList: [HoldedItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HoldedItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(holdedItemList)
        self.holdedItemDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding

extension MyHomeBarViewController {
    private func binding() {
        viewModel.holdedItemListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
                if $0.count == 0 {
                    self.showAddItemView()
                } else {
            self.showHoldedItemCollectionView(holdedItemList: $0)
                }
        }.store(in: &cancelBag)
    }
    
    private func showHoldedItemCollectionView(holdedItemList: [HoldedItem]) {
        applySnapshot(holdedItemList: holdedItemList)
        
        introduceView.addSubview(smallAddButton)
        scrollView.addSubview(holdedItemCollectionView)
        scrollView.addSubview(savedCocktailListButton)
        scrollView.addSubview(userMadeCocktailListButton)
        
        smallAddButton.snp.makeConstraints {
            $0.centerY.equalTo(holdIngredientLabel)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        holdedItemCollectionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
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
            $0.bottom.equalToSuperview()
        }
        
        if holdedItemCollectionView.isHidden {
            holdedItemCollectionView.isHidden = false
        }
        
        if smallAddButton.isHidden {
            smallAddButton.isHidden = false
        }
        
        if addItemView.isHidden == false {
            addItemView.isHidden = true
        }
    }
    
    private func showAddItemView() {
        stackView.addArrangedSubview(addItemView)
        stackView.addArrangedSubview(savedCocktailListButton)
        stackView.addArrangedSubview(userMadeCocktailListButton)
        addItemView.addSubview(addLabel1)
        addItemView.addSubview(addLabel2)
        addItemView.addSubview(largeAddButton)
        
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
        
        largeAddButton.snp.makeConstraints {
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
        
        if addItemView.isHidden  {
            addItemView.isHidden = false
        }
        
        if smallAddButton.isHidden == false {
            smallAddButton.isHidden = true
        }
        
        if holdedItemCollectionView.isHidden == false {
            holdedItemCollectionView.isHidden = true
        }
    }
}

//MARK: - CellDelteButtonDelegate

extension MyHomeBarViewController: CellDeleteButtonDelegate {
    func delete(holdedItem: String) {
        viewModel.deleteHoldedItem(holdedItemName: holdedItem)
    }
}

//MARK: - Handling Error

extension MyHomeBarViewController {
    func errorBinding() {
        viewModel.errorHandlingPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.handlingError(errorType: $0)
            }).store(in: &cancelBag)
    }
}

//MARK: - Authentication Binding

extension MyHomeBarViewController {
    func authenticationBinding() {
        viewModel.accessTokenStatusPublisher()
            .receive(on: RunLoop.main)
            .sink { [weak self] in
            guard let self = self else { return }
            if $0 == true {
                self.configureLoggedinMyHomeBar()
            } else {
                self.configureUnloggedinMyHomeBar()
            }
            }.store(in: &cancelBag)
    }
}
