//
//  CocktailSelectionCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

final class CocktailSelectionCell: UICollectionViewCell {
    private let selectedView = SelectedView()
        
    private lazy var cocktailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var cocktailNameLabel: UILabel = {
        let cocktailNameLabel = UILabel()
        cocktailNameLabel.font = UIFont(name: FontStrings.themeFont, size: 13)
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
        self.addSubview(selectedView)
        
        cocktailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.top.equalToSuperview().offset(8)
        }
        
        cocktailNameLabel.snp.makeConstraints {
            $0.top.equalTo(cocktailImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-16)
            $0.centerX.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureBackground(){
        self.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        self.layer.cornerRadius = 4
        selectedView.isHidden = true
    }
    
    func fill(with previewDescription: SelectablePreviewDescription) {
        guard let imageURL = URL(string: previewDescription.imageURI) else { return }
        
        cocktailImageView.load(url: imageURL)
        cocktailNameLabel.text = previewDescription.cocktailNameKo
    }
    
    func presentSelected() {
        selectedView.isHidden = false
    }
    
    func presentDeselected() {
        selectedView.isHidden = true
    }
}
