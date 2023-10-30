//
//  IngredientInformationViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/29.
//

import UIKit
import SnapKit
import Combine

final class IngredientInformationViewController: UIViewController {
    private var viewModel: IngredientInformationViewModel
    private var cancelBag: Set<AnyCancellable> = []
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 24)
        
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 20)
        label.text = "정보"
        
        return label
    }()
    
    private let purchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "구  매  처"
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        
        return label
    }()
    
    private let purchaseLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
        
        return label
    }()
    
    private let expirationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "유통기한"
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        
        return label
    }()
    
    private let expirationDateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
        
        return label
    }()
    
    private let recommendCocktailButton: UIButton = {
        let button = UIButton()
        button.setTitle("이 재료를 사용하는 칵테일 보기", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: FontStrings.pretendardBlack, size: 15)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(red: 0.472, green: 0.465, blue: 0.453, alpha: 1).cgColor
        
        return button
    }()
    
    init(viewModel: IngredientInformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroudColor()
        configureUI()
        viewModel.fetchIngredientDetail { [weak self] in
            guard let self = self else { return }
            self.fill(with: $0)
        }
    }
    
    private func configureBackgroudColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        let ingredientImageSize = view.bounds.width * 0.27
        view.addSubview(ingredientImageView)
        view.addSubview(titleLabel)
        view.addSubview(informationLabel)
        view.addSubview(purchaseLabel)
        view.addSubview(purchaseLinkLabel)
        view.addSubview(expirationDateLabel)
        view.addSubview(expirationDateDescriptionLabel)
        view.addSubview(recommendCocktailButton)
        
        ingredientImageView.snp.makeConstraints {
            $0.size.equalTo(ingredientImageSize)
            $0.top.equalTo(safeArea.snp.top).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        informationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        
        purchaseLabel.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        purchaseLinkLabel.snp.makeConstraints{
            $0.top.equalTo(purchaseLabel.snp.top)
            $0.leading.equalTo(purchaseLabel.snp.trailing).offset(16)
        }
        
        expirationDateLabel.snp.makeConstraints {
            $0.top.equalTo(purchaseLinkLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        expirationDateDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(expirationDateLabel.snp.top)
            $0.leading.equalTo(expirationDateLabel.snp.trailing).offset(16)
        }
        
        recommendCocktailButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.bottom.equalTo(safeArea)
        }
    }
    
    private func fill(with itemDetail: IngredientDetailResult) {
        guard let imageURL = URL(string: itemDetail.imageURI) else { return }
        
        ingredientImageView.load(url: imageURL)
        titleLabel.text = itemDetail.itemName
        purchaseLinkLabel.text = itemDetail.purchaseLink
        expirationDateDescriptionLabel.text = itemDetail.expirationDate
    }
}
