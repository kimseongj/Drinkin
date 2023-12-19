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
    private let viewModel: LoginSettingViewModel
    var flowDelegate: LoginSettingVCFlow?
    private var cancelBag: Set<AnyCancellable> = []
    
    private lazy var loginButton: UIButton = {
        let button = configureButtonUI(title: "로그인")
        button.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapLoginButton() {
        flowDelegate?.presentLoginVC()
    }
    
    private lazy var userAgreementButton: UIButton = {
        return configureButtonUI(title: "이용약관")
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = configureButtonUI(title: "로그아웃")
        button.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapLogoutButton() {
        let logoutAlert = makeLogoutAlert()
        present(logoutAlert, animated: true, completion: nil)
    }
    
    func makeLogoutAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "로그아웃하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "예", style: .default) { _ in
            self.viewModel.logout()
            alertController.dismiss(animated: true)
        }
        
        let dismissAction = UIAlertAction(title: "아니요", style: .cancel)
        
        alertController.addAction(okAction)
        alertController.addAction(dismissAction)
        
        return alertController
    }
    
    private lazy var memberLeaveButton: UIButton = {
        return configureButtonUI(title: "회원탈퇴")
    }()
    
    //MARK: - Init
    
    init(viewModel: LoginSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticationBinding()
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureButtonUI(title: String) -> UIButton {
        let button = UIButton()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: FontStrings.pretendardBold, size: 17)
        
        button.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        return button
    }
    
    //MARK: - Loggedin UI
    
    private func configureLoggedinUI() {
        loginButton.isHidden = true
        userAgreementButton.isHidden = true
        
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
        
        logoutButton.isHidden = false
        userAgreementButton.isHidden = false
        memberLeaveButton.isHidden = false
    }
    
    //MARK: - Loggedout UI
    
    private func configureLoggedoutUI() {
        logoutButton.isHidden = true
        userAgreementButton.isHidden = true
        memberLeaveButton.isHidden = true
        
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
        
        loginButton.isHidden = false
        userAgreementButton.isHidden = false
    }
}

//MARK: - Authentication Binding

extension LoginSettingViewController {
    func authenticationBinding() {
        viewModel.accessTokenStatusPublisher().receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            if $0 == true {
                self.configureLoggedinUI()
            }  else {
                self.configureLoggedoutUI()
            }
        }.store(in: &cancelBag)
    }
}
