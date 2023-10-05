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
        label.font = UIFont(name: FontStrings.themeFont, size: 13)
        
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
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        brandImageView.snp.updateConstraints {
            $0.width.equalTo(brandImageView.bounds.height)
        }
    }
    
//    func fill(with baseBrand: BaseBrandDescription) {
//        guard let imageURL = URL(string: baseBrand.imageURI) else { return }
//        
//        titleLabel.text = baseBrand.title
//        brandImageView.load(url: imageURL)
//    }
}
