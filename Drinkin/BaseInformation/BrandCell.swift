//
//  BrandCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit

final class BrandCell: UICollectionViewCell {
    private let brandImageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 13)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(brandImageView)
        contentView.addSubview(titleLabel)
        
        brandImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(brandImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}
