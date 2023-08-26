//
//  CategoryCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

final class CategoryCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = .black
                categoryNameLabel.textColor = .white
            } else {
                self.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
                categoryNameLabel.textColor = .black
            }
        }
    }
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: "Pretendard-Bold", size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellSetting() {
        self.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
        self.layer.cornerRadius = 4
        self.addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func fill(with categoryName: String) {
        categoryNameLabel.text = categoryName
        
        if isSelected == true {
            self.backgroundColor = .black
            categoryNameLabel.textColor = .white
        }
    }
}
