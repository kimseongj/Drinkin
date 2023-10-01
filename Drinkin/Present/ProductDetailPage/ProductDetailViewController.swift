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
    
    init(viewModel: ProductDetailViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        introductionView.configureDelegate(delegate: delegate)
        binding()
        viewModel?.fetchDescription()
        configureScrollView()
        configureStackView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.didFinishProductDetailVC()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureStackView(){
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        stackView.addArrangedSubview(introductionView)
        stackView.addArrangedSubview(cocktailInformationView)
    }
    
    private func fill(with cocktailDescription: CocktailDescription?) {
        guard let validCocktailDescription = cocktailDescription else { return }
        
        introductionView.fill(with: validCocktailDescription)
        cocktailInformationView.fill(with: validCocktailDescription)
        introductionView.applybaseSnapshot(detailCategoryList: validCocktailDescription.categoryList)
        introductionView.applyIngredientSnapshot(detailIngredientList: validCocktailDescription.ingredientList)
    }
}

//MARK: - Binding
extension ProductDetailViewController {
    private func binding() {
        viewModel?.cocktailDescriptionPublisher.receive(on: RunLoop.main).sink {
            self.fill(with: $0)
        }.store(in: &cancelBag)
    }
}
