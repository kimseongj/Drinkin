//
//  LoggedinMainView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/16.
//

import UIKit
import SnapKit

class LoggedinMainView: UIView {
    
    weak var delegate: MainViewDelegate?
    
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
    
    func configureUI() {
        let safeArea = self.safeAreaLayoutGuide
        
        self.backgroundColor = .white
        
        self.addSubview(logoImage2)
        self.addSubview(recommendCocktailCollectionView)
        
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
    
    func sendDelegate(_ delegate: MainViewDelegate?) {
        self.delegate = delegate
    }
    
    func setupRecommendCocktailCollectionView() {
        recommendCocktailCollectionView.register(LoggedInCell.self, forCellWithReuseIdentifier: "LoggedInCell")
        recommendCocktailCollectionView.delegate = self
        recommendCocktailCollectionView.dataSource = self
        recommendCocktailCollectionView.isPagingEnabled = true
        recommendCocktailCollectionView.showsHorizontalScrollIndicator = false
    }
    
    @objc func seeMoreButtonAction() {
        delegate?.pushProductDetailVC()
        print("SeeMoreButon was Pushed")
    }
}


extension LoggedinMainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
