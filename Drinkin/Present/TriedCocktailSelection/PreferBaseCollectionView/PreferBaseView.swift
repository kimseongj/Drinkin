//
//  PreferBaseCollectionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/02.
//

import UIKit

class PreferBaseView: UIView {
    
    //MARK:- baseCollectionView
    var preferBaseCollectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(BaseTypeCell.self, forCellWithReuseIdentifier: "BaseCell")

        return view
    }()
    
    private let data = ["전체", "위스키 베이스", "리큐르 베이스", "보드카 베이스", "진 베이스", "asdasf", "asdasfqwe", "qwexzcsad", "qweasdxzc"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setBaseCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(preferBaseCollectionView)
        
        preferBaseCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setBaseCollectionView() {
        preferBaseCollectionView.register(BaseTypeCell.self, forCellWithReuseIdentifier: BaseTypeCell.identifier)
        preferBaseCollectionView.delegate = self
        preferBaseCollectionView.dataSource = self
        
        if let flowLayout = preferBaseCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

extension PreferBaseView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = preferBaseCollectionView.dequeueReusableCell(withReuseIdentifier: BaseTypeCell.identifier, for: indexPath) as! BaseTypeCell
        cell.baseNameLabel.text = data[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
