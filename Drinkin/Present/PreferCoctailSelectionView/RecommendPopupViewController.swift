//
//  RecommendPopupViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/04.
//

import UIKit
import SnapKit

final class RecommendPopupViewController: UIViewController {
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "마셔봤던 칵테일이 없나요?"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    private let firstDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "맛과 난이도 등을 고려해"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.47, green: 0.46, blue: 0.45, alpha: 1)
       
        return label
    }()
    
    private let secondDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "추천해드릴 수 있습니다."
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.47, green: 0.46, blue: 0.45, alpha: 1)
        
        return label
    }()
    
    private lazy var recommendButton: UIButton = {
        let button = UIButton()
        button.setTitle("추천 받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Black", size: 15)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(tapRecommendButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(firstDescriptionLabel)
        contentView.addSubview(secondDescriptionLabel)
        contentView.addSubview(recommendButton)
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.5)
            $0.width.equalTo(view.bounds.width * 0.9)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
        }
        
        firstDescriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
        }
        
        secondDescriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(firstDescriptionLabel.snp.bottom).offset(8)
        }
        
        recommendButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(secondDescriptionLabel.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().offset(-24)
            $0.height.equalTo(42)
            $0.width.equalTo(104)
        }
    }
    
    @objc
    private func tapRecommendButton() {
        self.dismiss(animated: true)
    }
}
