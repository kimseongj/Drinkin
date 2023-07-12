//
//  CocktailScrollView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

class CocktailCollectionViewCell: UICollectionViewCell {
    static let cellID = "CocktailCell"
    
    private let selectedView = SelectedView()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.addSubview(selectedView)
                selectedView.snp.makeConstraints {
                    $0.top.leading.trailing.bottom.equalToSuperview()
                }
            } else {
                selectedView.removeFromSuperview()
            }
        }
    }
    
    private lazy var cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var cocktailNameLabel: UILabel = {
        let cocktailNameLabel = UILabel()
        cocktailNameLabel.font = UIFont.systemFont(ofSize: 13)
        return cocktailNameLabel
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(cocktailImageView)
        self.addSubview(cocktailNameLabel)
        
        cocktailImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(8)
        }
        
        cocktailNameLabel.snp.makeConstraints { make in
            make.top.equalTo(cocktailImageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureBackground(){
        self.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.layer.cornerRadius = 4
    }
}

