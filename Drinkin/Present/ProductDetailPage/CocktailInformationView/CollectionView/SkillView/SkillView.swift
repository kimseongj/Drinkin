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
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    var skillCollectionView: SkillCollectionView = {
        let layout = UICollectionViewLayout()
        let collectionView = SkillCollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout())
        collectionView.backgroundColor = .white
 
        return collectionView
    }()
    
    let skillLabel: UILabel = {
        let label = UILabel()
        label.text = "기법"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 15)
        return label
    }()
    
    let skillButtonName = ["asd", "asdzxc", "asddd", "zxczxca"]
    
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
