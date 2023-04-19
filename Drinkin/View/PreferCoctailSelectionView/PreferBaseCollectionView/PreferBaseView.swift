//
//  PreferBaseView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

class PreferBaseView: UIView {
    
    //MARK:- baseCollectionView
    var preferBaseCollectionView: PreferBaseCollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let view = PreferBaseCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(BaseCell.self, forCellWithReuseIdentifier: "BaseCell")
        view.layoutIfNeeded()
        return view
    }()
    
    private let data = ["위스키 베이스", "리큐르 베이스", "보드카 베이스", "진 베이스", "asdasf", "asdasfqwe", "qwexzcsad", "qweasdxzc"]

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
        preferBaseCollectionView.register(BaseCell.self, forCellWithReuseIdentifier: "BaseCell")
        preferBaseCollectionView.delegate = self
        preferBaseCollectionView.dataSource = self
    }

}

extension PreferBaseView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = preferBaseCollectionView.dequeueReusableCell(withReuseIdentifier: BaseCell.id, for: indexPath) as! BaseCell
        cell.baseNameLabel.text = data[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let baseName = self.data[indexPath.row]
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        
        let baseNameSize = (baseName as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
        
        return CGSize(width: baseNameSize.width + 32, height: 40 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            15
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
