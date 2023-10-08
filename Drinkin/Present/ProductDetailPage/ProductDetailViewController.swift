//
//  ProductDetailViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit
import SnapKit
import Combine

class ProductDetailViewController: UIViewController {
    var delegate: ProductDetailVCDelegate?
    private var cancelBag: Set<AnyCancellable> = []
    private var viewModel: ProductDetailViewModel?
   
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        
        return stackView
    }()
    
    let introductionView = IntroductionView()
    let cocktailInformationView = CocktailInformationView()
    let tipAndContentView = TipAndContentView()
    
    private let markMadeCocktailButton: MarkMadeCocktailButton = {
        let button = MarkMadeCocktailButton()
        button.addTarget(self, action: #selector(tapMarkMadeCocktailButton), for: .touchUpInside)
        
        return button
    }()
   
    
    private let bookmarkCocktailButton: BookmarkCocktailButton = {
        let button = BookmarkCocktailButton()
        button.addTarget(self, action: #selector(tapBookmarkCocktailButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapMarkMadeCocktailButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @objc
    private func tapBookmarkCocktailButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    init(viewModel: ProductDetailViewModel?) {
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
        introductionView.configureDelegate(delegate: delegate)
        binding()
        viewModel?.fetchDescription()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.didFinishProductDetailVC()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(introductionView)
        stackView.addArrangedSubview(cocktailInformationView)
        stackView.addArrangedSubview(tipAndContentView)
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
            $0.top.equalTo(stackView.snp.bottom).offset(80)
            $0.centerX.equalTo(view.frame.width * 0.25)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        bookmarkCocktailButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(80)
            $0.centerX.equalTo(view.frame.width * 0.75)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    private func fill(with cocktailDescription: CocktailDescription?) {
        guard let validCocktailDescription = cocktailDescription else { return }
        
        introductionView.fill(with: validCocktailDescription)
        cocktailInformationView.fill(with: validCocktailDescription)
        introductionView.applybaseSnapshot(detailCategoryList: validCocktailDescription.categoryList)
        introductionView.applyIngredientSnapshot(detailIngredientList: validCocktailDescription.ingredientList)
    }
    
//    private func configureMarkButton() {
//        if viewModel?. == true {
//            bookmarkCocktailButton.isSelected
//        }
//
//        if viewModel?. == true {
//            markMadeCocktailButton.isSelected
//        }
//    }
}

//MARK: - Binding
extension ProductDetailViewController {
    private func binding() {
        viewModel?.cocktailDescriptionPublisher.receive(on: RunLoop.main).sink {
            self.fill(with: $0)
        }.store(in: &cancelBag)
    }
}
