//
//  LoginViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/07.
//

import UIKit
import SnapKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    let loginViewModel = LoginViewModel()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete_icon"), for: .normal)
        button.addTarget(self, action: #selector(dismissLoginVC), for: .touchUpInside)
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        return stackView
    }()
    
    lazy var kakaoLoginStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인 여부 라벨"
        
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "drinkin_description_logo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let descriptionLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 17)
        label.textAlignment = .center
        label.text = "갖고있는 재료, 추천 칵테일을 저장하기 위해"
        
        return label
    }()
    
    private let descriptionLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 17)
        label.textAlignment = .center
        label.text = "로그인 해주세요"
        
        return label
    }()
    
    lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorPalette.kakaoThemeColor
        button.titleLabel?.textColor = .black
        button.setImage(ImageStorage.kakaoLoginIcon, for: .normal)
        button.setTitle("카카오로 로그인", for: .normal)
        button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.setImage(ImageStorage.appleLoginIcon, for: .normal)
        button.setTitle("Apple로 로그인", for: .normal)
        button.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    @objc
    private func dismissLoginVC() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func loginButtonClicked() {
        print("loginButtonClicked")
        loginViewModel.handleKakaoLogin()
    }
    
    @objc
    private func appleLoginButtonClicked() {
        print("appleClicked")
        
        loginViewModel.performRequests()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(dismissButton)
        view.addSubview(logoImageView)
        view.addSubview(descriptionLabel1)
        view.addSubview(descriptionLabel2)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(kakaoLoginButton)
        stackView.addArrangedSubview(appleLoginButton)
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(190)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(view.bounds.height * 0.2)
        }
        
        descriptionLabel1.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(descriptionLabel1.snp.bottom).offset(5)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(view.bounds.height * 0.8)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(200)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(200)
        }
    }
}

extension LoginViewController:  ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
