//
//  ProductDetailViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit
import SnapKit
import Combine

final class ProductDetailViewController: UIViewController {
    private var viewModel: ProductDetailViewModel
    var flowDelegate: ProductDetailVCFlow?
    private var cancelBag: Set<AnyCancellable> = []
   
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        
        return stackView
    }()
    
    let introductionView = IntroductionView()
    let cocktailInformationView = CocktailInformationView()
    
    private let markMadeCocktailButton: MarkMadeCocktailButton = {
        let button = MarkMadeCocktailButton()
        button.addTarget(self, action: #selector(tapMarkMadeCocktailButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapMarkMadeCocktailButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
   
    private let bookmarkCocktailButton: BookmarkCocktailButton = {
        let button = BookmarkCocktailButton()
        button.addTarget(self, action: #selector(tapBookmarkCocktailButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapBookmarkCocktailButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    //MARK: - Init
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        introductionView.configureDelegate(delegate: flowDelegate)
        binding()
        errorBinding()
        viewModel.fetchDescription()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppCoordinator.tabBarController.tabBar.isHidden = true
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(introductionView)
        stackView.addArrangedSubview(cocktailInformationView)
        scrollView.addSubview(markMadeCocktailButton)
        scrollView.addSubview(bookmarkCocktailButton)
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        markMadeCocktailButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(40)
            $0.centerX.equalTo(view.frame.width * 0.25)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        bookmarkCocktailButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(40)
            $0.centerX.equalTo(view.frame.width * 0.75)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    //MARK: - Fill Views
    
    private func fill(with cocktailDescription: CocktailDescription?) {
        guard let validCocktailDescription = cocktailDescription else { return }
        
        let baseList = validCocktailDescription.baseList.sorted(by: { $0.hold && !$1.hold })
        let ingredientList = validCocktailDescription.ingredientList.sorted(by: { $0.hold && !$1.hold })
        introductionView.fill(with: validCocktailDescription)
        cocktailInformationView.fill(with: validCocktailDescription)
        introductionView.applybaseSnapshot(detailCategoryList: baseList)
        introductionView.applyIngredientSnapshot(detailIngredientList: ingredientList)
    }
}

//MARK: - Binding

extension ProductDetailViewController {
    private func binding() {
        viewModel.cocktailDescriptionPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            self.fill(with: $0)
            self.cocktailInformationView.receive(cocktailDescription: $0)
        }.store(in: &cancelBag)
    }
}

//MARK: - Handling Error

extension ProductDetailViewController {
    func errorBinding() {
        viewModel.errorHandlingPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
            guard let self = self else { return }
                self.handlingError(errorType: $0)
        }).store(in: &cancelBag)
    }
}
