//
//  HoldView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/20.
//

import UIKit
import SnapKit

class HoldView: UIView {
    private var title = ""
    private var result: Result?
    
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
    
    lazy var holdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 14)
        label.text = title
        
        return label
    }()
    
    let holdButtonName: [String] = []
    
    init(result: Result, title: String) {
        super.init(frame: .zero)
        self.title = title
        self.result = result
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
            make.trailing.equalTo(holdCollectionView.snp.leading).offset(-16)
            make.top.equalToSuperview()
            make.bottom.equalTo(holdCollectionView)
            make.width.equalTo(40)
        }
        
        holdLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(2)
        }
        
        holdCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview()
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
        guard let validResult = result else { return 0 }
        
        switch title {
        case "베이스":
            return validResult.categoryList.count
        case "재    료":
            return validResult.ingredientList.count
        case "가니쉬":
            return validResult.garnishList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = holdCollectionView.dequeueReusableCell(withReuseIdentifier: HoldCollectionViewCell.identifier, for: indexPath) as! HoldCollectionViewCell
        
        guard let validResult = result else { return cell }
        
        switch title {
        case "베이스":
            cell.label.text = validResult.categoryList[indexPath.row].categoryNameKo
        case "재    료":
            cell.label.text = validResult.ingredientList[indexPath.row].ingredientNameKo
        case "가니쉬":
            cell.label.text = validResult.garnishList[indexPath.row].garnishNameKo
        default: break
        }
        
        return cell
    }
}
