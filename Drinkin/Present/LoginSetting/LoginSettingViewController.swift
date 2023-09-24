//
//  LoginSettingViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit
import Combine

final class LoginSettingViewController: UIViewController {
    private var login: Bool = false
    
    private lazy var loginButton: UIButton = {
        return configureButtonUI(title: "로그인")
    }()
    
    private lazy var userAgreementButton: UIButton = {
        return configureButtonUI(title: "이용약관")
    }()
    
    private lazy var logoutButton: UIButton = {
        return configureButtonUI(title: "로그아웃")
    }()
    
    private lazy var memberLeaveButton: UIButton = {
        return configureButtonUI(title: "회원탈퇴")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor()
        configureUI()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        switch login {
        case true:
            configureLoggedinUI()
        case false:
            configureLoggedoutUI()
        }
    }
    
    private func configureButtonUI(title: String) -> UIButton {
        let button = UIButton()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Pretendard-Bold", size: 17)
        
        button.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        return button
    }
    
    private func configureLoggedinUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(loginButton)
        view.addSubview(userAgreementButton)
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        userAgreementButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    private func configureLoggedoutUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(logoutButton)
        view.addSubview(userAgreementButton)
        view.addSubview(memberLeaveButton)
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        userAgreementButton.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        memberLeaveButton.snp.makeConstraints {
            $0.top.equalTo(userAgreementButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}
