//
//  IntroductionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit
import SnapKit

class IntroductionView: UIView {
    
    let cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray3
        
        return imageView
    }()
    
    let cocktailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 24)
        label.text = "갓파더"
        
        return label
    }()
    
    let cocktailTDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
스카치 위스키의 향 위에 아마레또의 달달한 아몬드 향을 더했다. 아마레또는 생각보다 더 달다. 단 맛이 싫다면 아마레또의 비율을 줄여보자.
"""
        label.numberOfLines = 0
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        
        return label
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalIconLayout())
        collectionView.backgroundColor = .gray
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        
        return collectionView
    }()
    
    let receipeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피"
        label.font = UIFont(name: "Pretendard-ExtraBold", size: 20)
        
        return label
    }()
    
    let receipeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 15)
        label.text = """
1. 올드패션드 글라스에 얼음을 채운다.
2. 스카치 위스키 35ml, 디사론노 35ml를 순서대로 넣는다.
3. 바 스푼으로 적당히 저어준다.
"""
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
        configureItemCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(cocktailImageView)
        self.addSubview(cocktailTitleLabel)
        self.addSubview(cocktailTDescriptionLabel)
        self.addSubview(itemCollectionView)
        self.addSubview(receipeTitleLabel)
        self.addSubview(receipeDescriptionLabel)
        
        cocktailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        cocktailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(cocktailImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        cocktailTDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cocktailTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        itemCollectionView.snp.makeConstraints { make in
            make.top.equalTo(cocktailTDescriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(400)
        }
        
        receipeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(itemCollectionView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }
        
        receipeDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(receipeTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureItemCollectionView() {
        itemCollectionView.dataSource = self
    }
    
    private func updateItemCollectionViewHeight() {
        itemCollectionView.snp.makeConstraints {
            $0.height.equalTo(itemCollectionView.contentSize.height)
        }
    }
}

extension IntroductionView {
    private func configureCompositionalIconLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension IntroductionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
        
        
        
        updateItemCollectionViewHeight()

        return cell
    }


}
