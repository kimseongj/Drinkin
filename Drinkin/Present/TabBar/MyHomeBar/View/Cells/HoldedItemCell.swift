//
//  HoldedItemCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import UIKit
import SnapKit

final class HoldedItemCell: UICollectionViewCell {
    weak var delegate: CellDeleteButtonDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 13)
        
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageStorage.deleteIcon, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapDeleteButton() {
        guard let titleText = titleLabel.text else { return }
        delegate?.delete(holdedItem: titleText)
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        contentView.backgroundColor = ColorPalette.grayCellColor
        
        contentView.layer.cornerRadius = 4
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-12)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    
    //MARK: - FillCell
    
    func fill(with itemName: String) {
        titleLabel.text = itemName
    }
}
