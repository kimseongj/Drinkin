//
//  GlassModalViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/26.
//

import UIKit
import SnapKit

final class GlassModalViewController: UIViewController {
    private var viewModel: GlassModalViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 24)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 15)
        
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 20)
        
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.text = InformationStrings.volume
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        label.textAlignment = .left
        
        return label
    }()
    
    private let volumeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
        
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
    
    init(viewModel: GlassModalViewModel) {
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
        viewModel.fetchGlassDetail { [weak self] in
            guard let self = self else { return }
            
            self.fill(glassDetail: $0)
        }
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(informationLabel)
        view.addSubview(volumeLabel)
        view.addSubview(volumeDescriptionLabel)
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
        
        volumeLabel.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        volumeDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(volumeLabel.snp.top)
            $0.leading.equalTo(volumeLabel.snp.trailing).offset(16)
        }
        
        purchaseLabel.snp.makeConstraints {
            $0.top.equalTo(volumeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        purchaseLinkLabel.snp.makeConstraints {
            $0.top.equalTo(purchaseLabel.snp.top)
            $0.leading.equalTo(purchaseLabel.snp.trailing).offset(16)
        }
    }

    private func fill(glassDetail: GlassDetail) {
        imageView.load(urlString:  glassDetail.imageURI)
        titleLabel.text = glassDetail.glassName
        descriptionLabel.text = glassDetail.description
        volumeDescriptionLabel.text = glassDetail.volume
        purchaseLinkLabel.text = glassDetail.purchaseLink
    }
}
