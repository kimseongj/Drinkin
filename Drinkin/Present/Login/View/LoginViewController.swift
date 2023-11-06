//
//  LoginViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/07.
//

import UIKit
import SnapKit
import Combine
import AuthenticationServices

final class LoginViewController: UIViewController {
    private var viewModel: LoginViewModel
    var delegate: LoginFlowDelegate?
    private var cancelBag: Set<AnyCancellable> = []
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        
        let deleteImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "delete_icon")
            imageView.contentMode = .scaleAspectFit
            
            return imageView
        }()
        
        button.addSubview(deleteImageView)
        
        deleteImageView.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.center.equalToSuperview()
        }
        
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
    
    private let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cocktail_image")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
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
        label.text = "계정을 생성하고"
        
        return label
    }()
    
    private let descriptionLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 17)
        label.textAlignment = .center
        label.text = "칵테일을 추천 받아보세요."
        
        return label
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = ColorPalette.kakaoThemeColor
        button.layer.cornerRadius = 12
        
        let view = UIView()
        view.isUserInteractionEnabled = false
        
        let kakaoLogoImageView:UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "kakao_logo")
            imageView.contentMode = .scaleAspectFit
            
            return imageView
        }()
        
        let kakaoLoginLabel: UILabel = {
            let label = UILabel()
            label.text = "카카오톡으로 계속하기"
            label.textColor = .black
            label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 15)
            
            return label
        }()
        
        button.addSubview(view)
        view.addSubview(kakaoLogoImageView)
        view.addSubview(kakaoLoginLabel)
        
        kakaoLogoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(18)
        }
        
        kakaoLoginLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(kakaoLogoImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
        }
        
        view.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton()
        
        let view = UIView()
        view.isUserInteractionEnabled = false
        
        let appleLogoImageView:UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "apple_logo")
            imageView.contentMode = .scaleAspectFit
            
            return imageView
        }()
        
        let appleLoginLabel: UILabel = {
            let label = UILabel()
            label.text = "Apple로 계속하기"
            label.textColor = .white
            label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 15)
            
            return label
        }()
        
        button.addSubview(view)
        view.addSubview(appleLogoImageView)
        view.addSubview(appleLoginLabel)
        
        appleLogoImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.size.equalTo(18)
        }
        
        appleLoginLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(appleLogoImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
        }
        
        view.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        binding()
    }
    
    @objc
    private func dismissLoginVC() {
        print("dismissClicked")
        self.dismiss(animated: true)
    }
    
    @objc
    private func loginButtonClicked() {
        print("kakaoClicked")
        viewModel.handleKakaoLogin()
    }
    
    @objc
    private func appleLoginButtonClicked() {
        print("appleClicked")
        viewModel.performRequests()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(dismissButton)
        view.addSubview(cocktailImageView)
        view.addSubview(logoImageView)
        view.addSubview(descriptionLabel1)
        view.addSubview(descriptionLabel2)
        view.addSubview(kakaoLoginButton)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(kakaoLoginButton)
        stackView.addArrangedSubview(appleLoginButton)
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        cocktailImageView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeArea.snp.top).offset(40)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(cocktailImageView.snp.bottom).offset(20)
            $0.width.equalTo(190)
            $0.height.equalTo(60)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel2.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(descriptionLabel1.snp.bottom).offset(5)
            $0.bottom.equalTo(stackView.snp.top).offset(-30)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(view.bounds.height * 0.8)
//            $0.height.equalTo(50)
//            $0.width.equalTo(300)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(300)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(300)
        }
    }
}

extension LoginViewController:  ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LoginViewController {
    func binding() {
        viewModel.tokenExistencePublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            
            if $0 == true {
                self.dismiss(animated: true)
                self.delegate?.presentTriedCocktailSelectionVC()
            }
        }.store(in: &cancelBag)
    }
}
