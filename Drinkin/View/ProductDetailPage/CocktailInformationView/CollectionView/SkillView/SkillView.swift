//
//  SkillView.swift
//  TestLeftAlignment
//
//  Created by kimseongjun on 2023/05/08.
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
        let label = UILabel()
        label.text = "기법"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let skillButtonName = ["asd", "asdzxc", "asdqweqwe", "123sdasdzxc", "asdasfasd", "123asdaszxczxasd123", "Serbossa American good"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setSkillCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .white
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
        skillCollectionView.register(SkillCollectionViewCell.self, forCellWithReuseIdentifier: SkillCollectionViewCell.identifier)
        skillCollectionView.delegate = self
        skillCollectionView.dataSource = self
        if let flowLayout = skillCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

extension SkillView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillButtonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = skillCollectionView.dequeueReusableCell(withReuseIdentifier: SkillCollectionViewCell.identifier, for: indexPath) as! SkillCollectionViewCell
        cell.label.text = skillButtonName[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushSkillModalVC()
    }
}
