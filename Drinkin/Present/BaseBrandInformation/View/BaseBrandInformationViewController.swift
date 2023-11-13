//
//  BaseBrandInformationViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/06.
//

import UIKit
import SnapKit
import Combine

final class BaseBrandInformationViewController: UIViewController {
    private var viewModel: BaseBrandInformationViewModel
    var flowDelegate: BaseBrandInformationVCFlow?
    private var cancelBag: Set<AnyCancellable> = []
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let brandImageView: UIImageView = {
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
    
    private let classificationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        label.text = InformationStrings.classification
        
        return label
    }()
    
    private let classificationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
        
        return label
    }()
    
    private let abvLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        label.text = InformationStrings.abv
        
        return label
    }()
    
    private let abvDescriptionLabel: UILabel = {
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
        button.layer.borderColor = ColorPalette.buttonBorderColor
        button.addTarget(self, action: #selector(tapRecommendCocktailButton), for: .touchUpInside)
        
        return button
    }()
    
    init(viewModel: BaseBrandInformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchBaseBrandDetail()
        binding()
        configureBackgroundColor()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppCoordinator.tabBarController.tabBar.isHidden = true
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        let brandImageSize = view.bounds.width * 0.27
        view.addSubview(brandImageView)
        view.addSubview(titleLabel)
        view.addSubview(informationLabel)
        view.addSubview(classificationLabel)
        view.addSubview(classificationDescriptionLabel)
        view.addSubview(abvLabel)
        view.addSubview(abvDescriptionLabel)
        view.addSubview(recommendCocktailButton)
        
        brandImageView.snp.makeConstraints {
            $0.size.equalTo(brandImageSize)
            $0.top.equalTo(safeArea.snp.top).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(brandImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        informationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        
        classificationLabel.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        classificationDescriptionLabel.snp.makeConstraints{
            $0.top.equalTo(classificationLabel.snp.top)
            $0.leading.equalTo(classificationLabel.snp.trailing).offset(16)
        }
        
        abvLabel.snp.makeConstraints {
            $0.top.equalTo(classificationLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        abvDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(abvLabel.snp.top)
            $0.leading.equalTo(abvLabel.snp.trailing).offset(16)
        }
        
        recommendCocktailButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.bottom.equalTo(safeArea)
        
        }
    }
    
    private func fill(with brandDetail: BaseBrandDetail?) {
        guard let brandDetail = brandDetail else { return }
        
        brandImageView.load(urlString: brandDetail.imageURI)
        titleLabel.text = brandDetail.baseBrandName
//        classificationDescriptionLabel.text = brandDetail.classification
        abvDescriptionLabel.text = brandDetail.abv
    }
    
    @objc
    private func tapRecommendCocktailButton() {
        flowDelegate?.pushMakeableCocktailListVC(brandID: viewModel.brandID)
    }
}

//MARK: - Binding
extension BaseBrandInformationViewController {
    private func binding() {
        viewModel.baseBrandDetailPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            
            self.fill(with: $0)
        }.store(in: &cancelBag)
    }
}
