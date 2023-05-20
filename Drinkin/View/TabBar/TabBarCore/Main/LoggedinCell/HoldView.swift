//
//  HoldView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/20.
//

import UIKit
import SnapKit

class HoldView: UIView {
    
    var holdLabelView: UIView = {
        let label = UIView()
        label.backgroundColor = .white
        return label
    }()
    
    var holdCollectionView: HoldCollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = HoldCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collectionView.backgroundColor = .white

        return collectionView
    }()
    
    let holdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        
        return label
    }()
    
    let holdButtonName = ["asd", "asdzxc", "asdqweqwe", "123sdasdzxc", "asdasfasd", "123asdaszxczxasd123", "Serbossa American good"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setHoldCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .white
        self.addSubview(holdLabelView)
        holdLabelView.addSubview(holdLabel)
        self.addSubview(holdCollectionView)
        
        holdLabelView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(holdCollectionView)
            make.width.equalTo(62)
        }
        
        holdLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        holdCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(holdLabelView.snp.trailing)
        }
    }
    
    func setHoldCollectionView() {
        holdCollectionView.register(HoldCollectionViewCell.self, forCellWithReuseIdentifier: HoldCollectionViewCell.identifier)
        holdCollectionView.delegate = self
        holdCollectionView.dataSource = self
        if let flowLayout = holdCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

extension HoldView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return holdButtonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = holdCollectionView.dequeueReusableCell(withReuseIdentifier: HoldCollectionViewCell.identifier, for: indexPath) as! HoldCollectionViewCell
        cell.label.text = holdButtonName[indexPath.row]
        
        return cell
    }
}
