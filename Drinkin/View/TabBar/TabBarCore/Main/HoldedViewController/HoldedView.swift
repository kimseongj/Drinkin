//
//  HoldedView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/07.
//

import UIKit
import SnapKit

class HoldedView: UIView {
    
    var delegate: ProductDetailViewDelegate?
    
    let labelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var holdedCollectionView: HoldedCollectionView = {
        let layout = UICollectionViewLayout()
        let collecionView = HoldedCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collecionView.backgroundColor = .white
        collecionView.layoutIfNeeded()
        return collecionView
    }()
    
    let titleLabel: UILabel = {
        let bl = UILabel()
        bl.text = "재료"
        bl.textColor = .black
        bl.font = UIFont.boldSystemFont(ofSize: 15)
        return bl
    }()
    
    let ingredientButtonName = ["asd", "asdzxc", "asdqweqwe", "123sdasdzxc", "asdasfasd", "123asdaszxczxasd123"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
        setGlassCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(labelView)
        labelView.addSubview(titleLabel)
        self.addSubview(holdedCollectionView)
        
        
        labelView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(holdedCollectionView)
            make.width.equalTo(62)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        holdedCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(labelView.snp.trailing)
        }
    }
    
    func setGlassCollectionView() {
        holdedCollectionView.register(GlassCollectionViewCell.self, forCellWithReuseIdentifier: "GlassCell")
        holdedCollectionView.delegate = self
        holdedCollectionView.dataSource = self
        
        if let flowLayout = holdedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
}

extension HoldedView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientButtonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = holdedCollectionView.dequeueReusableCell(withReuseIdentifier: "HoldedViewCell", for: indexPath) as! HoldedCollectionViewCell
        cell.label.text = ingredientButtonName[indexPath.row]
        return cell
    }
}

