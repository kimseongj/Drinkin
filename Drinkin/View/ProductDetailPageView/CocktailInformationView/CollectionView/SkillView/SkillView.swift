//
//  SkillView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit
import SnapKit

class SkillView: UIView {

    var delegate: ProductDetailViewDelegate?
    
    var skillLabelView: UIView = {
        let slv = UIView()
        slv.backgroundColor = .white
        return slv
    }()
    
    var skillCollectionView: SkillCollectionView = {
        let layout = UICollectionViewLayout()
        let scv = SkillCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        scv.backgroundColor = .white
        scv.layoutIfNeeded()
        return scv
    }()
    
    let skillLabel: UILabel = {
        let sl = UILabel()
        sl.text = "기법"
        sl.textColor = .black
        sl.font = UIFont.systemFont(ofSize: 17)
        return sl
    }()

    let skillButtonName = ["asd", "asdzxc", "asdqweqwe", "123sdasdzxc", "asdasfasd", "123asdaszxczxasd123", "Serbossa American good"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
        setSkillCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        self.addSubview(skillLabelView)
        skillLabelView.addSubview(skillLabel)
        self.addSubview(skillCollectionView)
        
        
        skillLabelView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(skillCollectionView)
            make.width.equalTo(62)
        }
        
        skillLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        skillCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(skillLabelView.snp.trailing)
        }
        
    }
    
    func setSkillCollectionView() {
        skillCollectionView.register(SkillCollectionViewCell.self, forCellWithReuseIdentifier: "SkillCell")
        skillCollectionView.delegate = self
        skillCollectionView.dataSource = self
    }
    
}

extension SkillView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillButtonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = skillCollectionView.dequeueReusableCell(withReuseIdentifier: "SkillCell", for: indexPath) as! SkillCollectionViewCell
        cell.label.text = skillButtonName[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let skillButtonName = self.skillButtonName[indexPath.row]
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        
        let skillButtonNameSize = (skillButtonName as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
        
        return CGSize(width: skillButtonNameSize.width + 32, height: 30 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            15
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushSkillModalVC()
    }
}
