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
    private var cocktailBrief: CocktailBrief
    
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
    
    init(cocktailBrief: CocktailBrief, title: String) {
        self.title = title
        self.cocktailBrief = cocktailBrief
        super.init(frame: .zero)
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
        
        holdLabelView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(holdCollectionView.snp.leading).offset(-16)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(holdCollectionView)
            $0.width.equalTo(40)
        }
        
        holdLabel.snp.makeConstraints { 
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(2)
        }
        
        holdCollectionView.snp.makeConstraints { 
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview()
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
        switch title {
        case InformationStrings.base:
            if cocktailBrief.baseList.count == 0 {
                return 1
            } else {
                return cocktailBrief.baseList.count
            }
        case InformationStrings.ingredient:
            if cocktailBrief.ingredientList.count == 0 {
                return 1
            } else {
                return cocktailBrief.ingredientList.count
            }
        case InformationStrings.garnish:
            if cocktailBrief.garnishList.count == 0 {
                return 1
            } else {
                return cocktailBrief.garnishList.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = holdCollectionView.dequeueReusableCell(withReuseIdentifier: HoldCollectionViewCell.identifier, for: indexPath) as! HoldCollectionViewCell
        
        switch title {
        case InformationStrings.base:
            if cocktailBrief.baseList.count == 0 {
                cell.makeEmptyCell()
                return cell
            }
            
            let configuredCell = configureCell(itemName: cocktailBrief.baseList[indexPath.row].baseNameKo,
                                 hold: cocktailBrief.baseList[indexPath.row].hold,
                                 cell: cell)
            return configuredCell
            
        case InformationStrings.ingredient:
            if cocktailBrief.ingredientList.count == 0 {
                cell.makeEmptyCell()
                return cell
            }
            
            let configuredCell = configureCell(itemName: cocktailBrief.ingredientList[indexPath.row].ingredientNameKo,
                                 hold: cocktailBrief.ingredientList[indexPath.row].hold,
                                 cell: cell)
            return configuredCell
            
        case InformationStrings.garnish:
            if cocktailBrief.garnishList.count == 0 {
                cell.makeEmptyCell()
                return cell
            }
            
            let configuredCell = configureCell(itemName: cocktailBrief.garnishList[indexPath.row].garnishNameKo,
                                 hold: cocktailBrief.garnishList[indexPath.row].hold,
                                 cell: cell)
            return configuredCell
            
        default:
            return cell
        }
    }
    
    private func configureCell(itemName: String, hold: Bool, cell: HoldCollectionViewCell) -> HoldCollectionViewCell {
        cell.fill(with: itemName)
        
        if hold == true {
            cell.makeHoldedItemCell()
            return cell
        }
        
        cell.makeUnholdedItemCell()
        return cell
    }
}
