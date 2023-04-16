//
//  CocktailScrollView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

class CocktailCollectionView: UICollectionView {
    private let flowLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionView() {
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        self.isScrollEnabled = true
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = false
        self.contentInset = .zero
        self.clipsToBounds = true
        self.register(CocktailCollectionViewCell.self, forCellWithReuseIdentifier: "CocktailCell")
        self.layoutIfNeeded()
    }
}

class CocktailCollectionViewCell: UICollectionViewCell {
    static let cellID = "CocktailCell"
    
    private lazy var cocktailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var cocktailNameLabel: UILabel = {
        let cocktailNameLabel = UILabel()
        cocktailNameLabel.font = UIFont.systemFont(ofSize: 13)
        return cocktailNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        self.addSubview(cocktailImageView)
        self.addSubview(cocktailNameLabel)
        
        cocktailImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        cocktailNameLabel.snp.makeConstraints { make in
            make.top.equalTo(cocktailImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
}
