//
//  SelectionFilterCollectionView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/02.
//

import UIKit

class SelectionFilterView: UIView {
    
    //MARK:- baseCollectionView
    var selectionFilterCollectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .zero
        view.clipsToBounds = true
        view.register(SelectionFilterCell.self, forCellWithReuseIdentifier: SelectionFilterCell.identifier)
  
        return view
    }()
    
    private let data = ["전체", "위스키 베이스", "리큐르 베이스", "보드카 베이스", "진 베이스"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setSelectionFilterCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(selectionFilterCollectionView)
        
        selectionFilterCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setSelectionFilterCollectionView() {
        selectionFilterCollectionView.register(SelectionFilterCell.self, forCellWithReuseIdentifier: SelectionFilterCell.identifier)
        selectionFilterCollectionView.delegate = self
        selectionFilterCollectionView.dataSource = self
        
        if let flowLayout = selectionFilterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

}

extension SelectionFilterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectionFilterCollectionView.dequeueReusableCell(withReuseIdentifier: SelectionFilterCell.identifier, for: indexPath) as! SelectionFilterCell
        cell.baseNameLabel.text = data[indexPath.row] + " ▼"

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
