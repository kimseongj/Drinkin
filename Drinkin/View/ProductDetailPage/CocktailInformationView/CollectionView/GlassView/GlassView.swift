//
//  GlassView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit
import SnapKit

class GlassView: UIView {
    
    var delegate: ProductDetailViewDelegate?
    
    var glassLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var glassCollectionView: GlassCollectionView = {
        let layout = UICollectionViewLayout()
        let collecionView = GlassCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collecionView.backgroundColor = .white
        collecionView.layoutIfNeeded()
        return collecionView
    }()
    
    let glassLabel: UILabel = {
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
        self.addSubview(glassLabelView)
        glassLabelView.addSubview(glassLabel)
        self.addSubview(glassCollectionView)
        
        
        glassLabelView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(glassCollectionView)
            make.width.equalTo(62)
        }
        
        glassLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        glassCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(glassLabelView.snp.trailing)
        }
        
    }
    
    func setGlassCollectionView() {
        glassCollectionView.register(GlassCollectionViewCell.self, forCellWithReuseIdentifier: "GlassCell")
        glassCollectionView.delegate = self
        glassCollectionView.dataSource = self
    }
    
}

extension GlassView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientButtonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = glassCollectionView.dequeueReusableCell(withReuseIdentifier: "GlassCell", for: indexPath) as! GlassCollectionViewCell
        cell.label.text = ingredientButtonName[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        let labelText = self.ingredientButtonName[indexPath.row]
        
        return calculateCellWidth(index: indexPath.row)
    }
    
    func calculateCellWidth(index: Int) -> CGSize {
        
                let ingredientButtonName = self.ingredientButtonName[index]
        
                let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        
                let ingredientButtonNameSize = (ingredientButtonName as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
        
        let yellowViewRectangleSize = YellowRectangleView().bounds.width
        
                return CGSize(width: ingredientButtonNameSize.width + 32 + yellowViewRectangleSize, height: 30 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushGlassModalVC()
    }
}
