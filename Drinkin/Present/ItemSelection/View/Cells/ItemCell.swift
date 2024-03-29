//
//  IngredientCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import UIKit
import SnapKit

final class ItemCell: UICollectionViewCell {
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        
        return stackView
    }()
    
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 15)
        
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 12)
        label.textColor = ColorPalette.subTitleGrayColor
        
        return label
    }()
    
    private let emptyCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageStorage.checkEmptyIcon
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageStorage.checkFillIcon
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override func prepareForReuse() {
        itemImageView.image = nil
    }
    
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
        contentView.layer.borderWidth = 3
        contentView.layer.cornerRadius = 4
        
        contentView.addSubview(itemImageView)
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(itemTitleLabel)
        labelStackView.addArrangedSubview(categoryLabel)
        contentView.addSubview(emptyCheckImageView)
        contentView.addSubview(checkImageView)
        
        itemImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.size.equalTo(68)
        }

        labelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(itemImageView.snp.trailing).offset(8)
            $0.trailing.equalTo(emptyCheckImageView.snp.leading).offset(-8)
        }
        
        emptyCheckImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(26)
        }
        
        checkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(26)
        }
        
        checkImageView.isHidden = true
    }
    
    private func showActivityIndicator() {
        itemImageView.showActivityIndicator()
    }
    
    //MARK: - Fill Cell
    
    func fill(with item: Item) {
        itemTitleLabel.text = item.itemName
        categoryLabel.text = item.detail
        itemImageView.load(urlString: item.imageURI) { [weak self] in
            guard let self = self else { return }
            self.itemImageView.hideActivityIndicator()
        }
    }
    
    func presentHoldItem() {
        checkImageView.isHidden = false
    }
    
    func presentUnholdItem() {
        checkImageView.isHidden = true
    }
}
