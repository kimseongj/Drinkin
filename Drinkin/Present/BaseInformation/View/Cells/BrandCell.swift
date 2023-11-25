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
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        showActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        contentView.backgroundColor = ColorPalette.grayCellColor
        
        contentView.addSubview(brandImageView)
        contentView.addSubview(titleLabel)
        
        brandImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-8)
            $0.size.equalTo(contentView.bounds.height * 0.72)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func showActivityIndicator() {
        brandImageView.showActivityIndicator()
    }
    
    //MARK: - Fill Cell
    
    func fill(with brandImageDescription: BrandImageDescription) {
        titleLabel.text = brandImageDescription.brandName
        brandImageView.load(urlString: brandImageDescription.imageURI) { [weak self] in
            guard let self = self else { return }
            self.brandImageView.hideActivityIndicator()
        }
    }
}
