//
//  MainViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.


import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func pushChooseCocktailVC()
    func pushProductDetailVC()
}

class MainViewController: UIViewController {

    var delegate: MainViewDelegate?
    
    static var login: Bool = false
    
    //MARK:- UnNLoggedinUI
    private let unLoggedInView = UIView()
    
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
    
    
    //MARK:- LoggedinView
    private let loggedInView = UIView()
    
    private let logoImage2: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "drinkinLogo")
        return logoImage
    }()
    
    private var recommendCocktailCollectionView: UICollectionView = { 
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupRecommendCocktailCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if MainViewController.login {
            configureLoggedinUI()
        } else {
            configureUnLoggedinUI()
        }
    }
    
    //MARK:- UnLoggedinUI
    private func configureUnLoggedinUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(unLoggedInView)
        unLoggedInView.addSubview(logoImage1)
        unLoggedInView.addSubview(skeletonView)
        skeletonView.addSubview(recommendLabel1)
        skeletonView.addSubview(recommendLabel2)
        unLoggedInView.addSubview(startButton)
        
        unLoggedInView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
        
        logoImage1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeArea)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        skeletonView.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(140)
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalTo(safeArea).offset(-140)
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
    
    //MARK:- LoginUI
    func configureLoggedinUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(loggedInView)
        loggedInView.addSubview(logoImage2)
        loggedInView.addSubview(recommendCocktailCollectionView)
        
        loggedInView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
        
        logoImage2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeArea)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        recommendCocktailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImage2.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func setupRecommendCocktailCollectionView() {
        recommendCocktailCollectionView.register(LoggedInCell.self, forCellWithReuseIdentifier: "LoggedInCell")
        recommendCocktailCollectionView.delegate = self
        recommendCocktailCollectionView.dataSource = self
        recommendCocktailCollectionView.isPagingEnabled = true
        recommendCocktailCollectionView.showsHorizontalScrollIndicator = false
    }
    
    @objc func startButtonAction() {
        guard let validDelegate = delegate else {
            print("delegate가 nil입니다.")
            return
        }
        
        validDelegate.pushChooseCocktailVC()//self.navigationController!)
    }
    
    @objc func seeMoreButtonAction() {
        delegate?.pushProductDetailVC()
        print("SeeMoreButon was Pushed")
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return recommendCocktailCollectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendCocktailCollectionView.dequeueReusableCell(withReuseIdentifier: "LoggedInCell", for: indexPath) as! LoggedInCell
        //cell.imageView.image = data[indexPath.row]
        cell.seeMoreButton.addTarget(self, action: #selector(seeMoreButtonAction), for: .touchUpInside)
        return cell
    }
}
