//
//  ToolModalViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit
import SnapKit
import Combine

final class ToolModalViewController: UIViewController {
    private var viewModel: ToolModalViewModel
    private var cancelBag: Set<AnyCancellable> = []
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스푼"
        label.font = UIFont(name: FontStrings.themeFont, size: 24)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 15)
        label.text = "바 스푼은 재료를 저을 때 사용한다. 일반 스푼과 다르게, 더 기다랗고 젓는 데 도움이 되는 꼬인 줄기 부분이 있다."
        
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 20)
        
        return label
    }()
    
    private let purchaseLabel: UILabel = {
        let label = UILabel()
        label.text = InformationStrings.purchase
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        
        return label
    }()
    
    private let purchaseLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
        
        return label
    }()
    
    //MARK: - Init
    
    init(viewModel: ToolModalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToolData()
        errorBinding()
        configureUI()
        showActivityIndicator()
        showImageViewActivityIndicator()
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(informationLabel)
        view.addSubview(purchaseLabel)
        view.addSubview(purchaseLinkLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        informationLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        purchaseLabel.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        purchaseLinkLabel.snp.makeConstraints {
            $0.top.equalTo(purchaseLabel.snp.top)
            $0.leading.equalTo(purchaseLabel.snp.trailing).offset(16)
        }
    }
    
    private func showImageViewActivityIndicator() {
        imageView.showActivityIndicator()
    }
    
    //MARK: - Fill View
    
    private func fill(toolDetail: ToolDetail) {
        titleLabel.text = toolDetail.toolName
        descriptionLabel.text = toolDetail.description
        purchaseLinkLabel.text = toolDetail.purchaseLink
        imageView.load(urlString: toolDetail.imageURI) { [weak self] in
            guard let self = self else { return }
            self.imageView.hideActivityIndicator()
        }
    }
    
    //MARK: Fetch Data
    private func fetchToolData() {
        viewModel.fetchToolDetail { [weak self] in
            guard let self = self else { return }
            self.fill(toolDetail: $0)
            self.hideActivityIndicator()
        }
    }
}

//MARK: - Handling Error

extension ToolModalViewController {
    func errorBinding() {
        viewModel.errorHandlingPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.handlingError(errorType: $0)
            }).store(in: &cancelBag)
    }
}
