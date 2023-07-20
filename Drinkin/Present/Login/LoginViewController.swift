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
    let navigationController1 = UINavigationController()
    let kakaoAuthVM = KakaoAuthViewModel()
    let appleAuthVM = AppleAuthViewModel()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var kakaoLoginStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인 여부 라벨"
        
        return label
    }()
    
    lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_medium_wide"), for: .normal)
        button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    lazy var appleLoginbutton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "appleid_button"), for: .normal)
        button.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    lazy var kakaoLogoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오 로그아웃", for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(logoutButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    @objc
    private func loginButtonClicked() {
        print("loginButtonClicked")
        kakaoAuthVM.handleKakaoLogin()
    }
    
    @objc
    private func logoutButtonClicked() {
        print("logoutButtonClicked")
    }
    
    @objc
    private func appleLoginButtonClicked() {
        print("appleClicked")
        
        appleAuthVM.performRequests()
    }
    
    private func configureUI() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(kakaoLoginStatusLabel)
        stackView.addArrangedSubview(kakaoLoginButton)
        stackView.addArrangedSubview(appleLoginbutton)
        stackView.addArrangedSubview(kakaoLogoutButton)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        

    }
}

extension LoginViewController:  ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
