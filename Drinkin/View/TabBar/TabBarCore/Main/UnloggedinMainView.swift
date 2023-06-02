//
//  UnloggedinMainView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/16.
//

import UIKit

class UnloggedinMainView: UIView {
    
    weak var delegate: MainViewDelegate?

    private let logoImage1: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "drinkinLogo")
        return logoImage
    }()
    
    private let skeletonView: UIImageView = {
        let skeletonView = UIImageView()
        skeletonView.image = UIImage(named: "skeletonView")
        return skeletonView
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
        startButton.backgroundColor = .black
        startButton.layer.cornerRadius = 20
        startButton.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        startButton.layer.borderWidth = 3
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        return startButton
    }()
    
    @objc func startButtonAction() {
        guard let validDelegate = delegate else {
            print("delegate가 nil입니다.")
            return
        }
        
        validDelegate.pushChooseCocktailVC()
    }
    
    func configureUI() {
        let safeArea = self.safeAreaLayoutGuide
    
        self.backgroundColor = .white
        
        self.addSubview(logoImage1)
        self.addSubview(skeletonView)
        skeletonView.addSubview(recommendLabel1)
        skeletonView.addSubview(recommendLabel2)
        self.addSubview(startButton)
        
        logoImage1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeArea)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        skeletonView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalToSuperview().multipliedBy(0.63)
            make.centerY.centerX.equalToSuperview()
        }
        
        recommendLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(recommendLabel2.snp.top).offset(-4)
        }
        
        recommendLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(39)
            make.width.equalTo(108)
            make.top.equalTo(recommendLabel2.snp.bottom).offset(10)
        }
    }
    
    func sendDelegate(_ delegate: MainViewDelegate?) {
        self.delegate = delegate
    }
}