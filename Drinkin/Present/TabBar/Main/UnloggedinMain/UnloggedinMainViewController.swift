//
//  UnloggedinMainView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/16.
//

import UIKit
import SnapKit

final class UnloggedinMainViewController: UIViewController {
    weak var flowDelegate: MainVCFlow?

    private let logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = ImageStorage.drinkinLogo
        
        return logoImage
    }()
    
    private let skeletonView: UIImageView = {
        let skeletonView = UIImageView()
        skeletonView.image = ImageStorage.skeletonViewImage
        
        return skeletonView
    }()
    
    private let exampleCocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageStorage.cocktaiImage
        
        return imageView
    }()
    
    private let recommendLabel1: UILabel = {
        let recommendLabel = UILabel()
        recommendLabel.font = UIFont.boldSystemFont(ofSize: 17)
        recommendLabel.text = "마셔봤던 칵테일을 선택하고"
        
        return recommendLabel
    }()
    
    private let recommendLabel2: UILabel = {
        let recommendLabel = UILabel()
        recommendLabel.font = UIFont.boldSystemFont(ofSize: 17)
        recommendLabel.text = "다양한 칵테일을 추천받아보세요"
        
        return recommendLabel
    }()
    
    private let startButton: UIButton = {
        let startButton = UIButton()
        startButton.setTitle("시작하기", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont(name: FontStrings.pretendardBlack, size: 15)
        startButton.backgroundColor = .black
        startButton.layer.cornerRadius = 20
        startButton.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        startButton.layer.borderWidth = 3
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        return startButton
    }()
    
    @objc func startButtonAction() {
        flowDelegate?.presentLoginVC()
    }
    
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(logoImage)
        view.addSubview(skeletonView)
        skeletonView.addSubview(exampleCocktailImageView)
        skeletonView.addSubview(recommendLabel1)
        skeletonView.addSubview(recommendLabel2)
        view.addSubview(startButton)
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeArea)
            $0.height.equalTo(25)
            $0.width.equalTo(120)
        }
        
        skeletonView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(view.bounds.width)
            $0.centerY.centerX.equalToSuperview()
        }
        
        exampleCocktailImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.bottom.equalTo(recommendLabel1.snp.top).offset(-4)
            $0.centerX.equalToSuperview()
        }
        
        recommendLabel1.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(recommendLabel2.snp.top).offset(-4)
        }
        
        recommendLabel2.snp.makeConstraints { 
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(39)
            $0.width.equalTo(108)
            $0.top.equalTo(recommendLabel2.snp.bottom).offset(10)
        }
    }
    
    func sendDelegate(_ delegate: MainVCFlow?) {
        self.flowDelegate = delegate
    }
}
