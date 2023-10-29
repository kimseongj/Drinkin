//
//  HoldView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/20.
//

import UIKit
import SnapKit

final class HoldView: UIView {
    private var title = MiscStrings.emptySpace
    private var briefDescription: CocktailBrief?
    
    private var holdLabelView: UIView = {
        let label = UIView()
        label.backgroundColor = .white
        
        return label
    }()
    
    private var holdCollectionView: HoldCollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = HoldCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    private lazy var holdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 14)
        label.text = title
        
        return label
    }()
    
    init(briefDescription: CocktailBrief, title: String) {
        super.init(frame: .zero)
        self.title = title
        self.briefDescription = briefDescription
        configureUI()
        setHoldCollectionView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
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
    
    private func setHoldCollectionView() {
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
        guard let validBriefDescription = briefDescription else { return 0 }
        
        switch title {
        case InformationStrings.base:
            if validBriefDescription.baseList.count == 0 {
                return 1
            } else {
                return validBriefDescription.baseList.count
            }
        case InformationStrings.ingredient:
            if validBriefDescription.ingredientList.count == 0 {
                return 1
            } else {
                return validBriefDescription.ingredientList.count
            }
        case InformationStrings.garnish:
            if validBriefDescription.garnishList.count == 0 {
                return 1
            } else {
                return validBriefDescription.garnishList.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = holdCollectionView.dequeueReusableCell(withReuseIdentifier: HoldCollectionViewCell.identifier, for: indexPath) as! HoldCollectionViewCell
        
        guard let validBriefDescription = briefDescription else { return cell }
        
        switch title {
        case InformationStrings.base:
            if validBriefDescription.baseList.count == 0 {
                cell.makeEmptyCell()
            } else {
                cell.fill(with: validBriefDescription.baseList[indexPath.row].baseNameKo) 
                cell.makeHoldedItemCell()
            }
        case InformationStrings.ingredient:
            if validBriefDescription.ingredientList.count == 0 {
                cell.makeEmptyCell()
            } else {
                cell.fill(with: validBriefDescription.ingredientList[indexPath.row].ingredientNameKo)
                cell.makeHoldedItemCell()
            }
        case InformationStrings.garnish:
            if validBriefDescription.garnishList.count == 0 {
                cell.makeEmptyCell()
            } else {
                cell.fill(with: validBriefDescription.garnishList[indexPath.row].garnishNameKo)
                cell.makeHoldedItemCell()
            }
        default: break
        }
        
        return cell
    }
}

