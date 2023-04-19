//
//  ToolView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit
import SnapKit

class ToolView: UIView {
    
    var delegate: ProductDetailViewDelegate?
    
    var toolLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var toolCollectionView: ToolCollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = ToolCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.layoutIfNeeded()
        return collectionView
    }()
    
    let toolLabel: UILabel = {
        let label = UILabel()
        label.text = "도  구"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let baseButtonName = ["asd", "asdzxc", "asdqweqwe", "123sdasdzxc", "asdasfasd", "123asdaszxczxasd123"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
        setToolCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(toolLabelView)
        toolLabelView.addSubview(toolLabel)
        self.addSubview(toolCollectionView)
        
        toolLabelView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(toolCollectionView)
            make.width.equalTo(62)
        }
        
        toolLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        toolCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(toolLabelView.snp.trailing)
        }
    }
    
    func setToolCollectionViewCell() {
        toolCollectionView.register(ToolCollectionViewCell.self, forCellWithReuseIdentifier: "ToolCell")
        toolCollectionView.delegate = self
        toolCollectionView.dataSource = self
    }
}

extension ToolView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseButtonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = toolCollectionView.dequeueReusableCell(withReuseIdentifier: "ToolCell", for: indexPath) as! ToolCollectionViewCell
        cell.label.text = baseButtonName[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let baseButtonName = self.baseButtonName[indexPath.row]
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        
        let baseButtonNameSize = (baseButtonName as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
        
        return CGSize(width: baseButtonNameSize.width + 32, height: 30 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushToolModalVC()
    }
}
