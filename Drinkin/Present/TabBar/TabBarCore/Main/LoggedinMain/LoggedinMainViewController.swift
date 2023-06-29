//
//  LoggedinMainView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/16.
//

import UIKit
import SnapKit

final class LoggedinMainViewController: UIViewController {
    private enum Constant {
        static let itemSize = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.7)

        static let itemSpacing = 18.0
        
        static var insetX: CGFloat {
            (UIScreen.main.bounds.width) - itemSize.width / 2.0
        }
        
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        }
    }
    
    private let carouselFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Constant.itemSize
        layout.minimumLineSpacing = Constant.itemSpacing
        layout.minimumLineSpacing = 0
        
        return layout
    }()
    
    weak var delegate: MainViewDelegate?
    
    private let logoImage2: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "drinkinLogo")
        return logoImage
    }()
    
    private lazy var recommendCocktailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: carouselFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.clipsToBounds = true
        collectionView.contentInset = Constant.collectionViewContentInset
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        configureUI()
    }
    
    func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
//        view.addSubview(logoImage2)
        view.addSubview(recommendCocktailCollectionView)
        
//        logoImage2.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(safeArea)
//            make.height.equalTo(25)
//            make.width.equalTo(120)
//        }
        
        recommendCocktailCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(logoImage2.snp.bottom).offset(20)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func sendDelegate(_ delegate: MainViewDelegate?) {
        self.delegate = delegate
    }
    
    func setupRecommendCocktailCollectionView() {
        recommendCocktailCollectionView.register(LoggedInCell.self, forCellWithReuseIdentifier: "LoggedInCell")
        recommendCocktailCollectionView.delegate = self
        recommendCocktailCollectionView.dataSource = self
    }
    
    @objc func seeMoreButtonAction() {
        delegate?.pushProductDetailVC()
        print("SeeMoreButon was Pushed")
    }
}


extension LoggedinMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return recommendCocktailCollectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendCocktailCollectionView.dequeueReusableCell(withReuseIdentifier: "LoggedInCell", for: indexPath) as! LoggedInCell

        cell.seeMoreButton.addTarget(self, action: #selector(seeMoreButtonAction), for: .touchUpInside)
        
        return cell
    }
}

extension LoggedinMainViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}
