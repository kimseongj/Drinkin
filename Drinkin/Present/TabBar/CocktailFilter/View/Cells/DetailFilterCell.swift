//
//  DetailFilterCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/29.
//

import UIKit
import SnapKit

final class DetailFilterCell: UITableViewCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                presentSelected()
            } else {
                presentDeselected()
            }
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        return label
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageStorage.changeableCheckIcon
        imageView.tintColor = .white
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkImageView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        checkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func fill(with title: String) {
        titleLabel.text = title
    }
    
    private func presentSelected() {
        titleLabel.textColor = ColorPalette.themeColor
        checkImageView.tintColor = ColorPalette.themeColor
    }
    
    private func presentDeselected() {
        titleLabel.textColor = .black
        checkImageView.tintColor = .white
    }
}
