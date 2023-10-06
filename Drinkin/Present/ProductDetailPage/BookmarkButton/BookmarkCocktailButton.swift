//
//  BookmarkButton.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/06.
//

import UIKit

final class BookmarkCocktailButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                presentSelected()
            } else {
                presentDeselected()
            }
        }
    }
    
    private let buttonImageView = UIImageView(image: ImageStorage.bookmarkIcon)
    private let selectedButtonImageView = UIImageView(image: ImageStorage.bookmarkFillIcon)
    private let buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "나중에 볼 칵테일에 저장"
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 11)
        label.textAlignment = .center
        
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
        self.addSubview(buttonImageView)
        self.addSubview(selectedButtonImageView)
        self.addSubview(buttonTitleLabel)
        
        buttonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        selectedButtonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        buttonTitleLabel.snp.makeConstraints {
            $0.top.equalTo(buttonImageView.snp.bottom)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        selectedButtonImageView.isHidden = true
    }
    
    private func presentSelected() {
        selectedButtonImageView.isHidden = false
    }
    
    private func presentDeselected() {
        selectedButtonImageView.isHidden = true
    }
}
