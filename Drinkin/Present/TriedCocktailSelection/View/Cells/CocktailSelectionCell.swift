//
//  CocktailSelectionCell.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit

final class CocktailSelectionCell: UICollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        cocktailImageView.image = nil
    }
    
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
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        makeSelectedViewHidden()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        contentView.backgroundColor = ColorPalette.grayCellColor
        contentView.layer.cornerRadius = 4
        
        contentView.addSubview(cocktailImageView)
        contentView.addSubview(cocktailNameLabel)
        contentView.addSubview(selectedView)
        
        cocktailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.top.equalToSuperview().offset(8)
            $0.height.equalTo(contentView.bounds.width - 16)
        }
        
        cocktailNameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.centerX.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func makeSelectedViewHidden() {
        selectedView.isHidden = true
    }
    
    //MARK: - Fill Cell
    
    func fill(with previewDescription: SelectableImageDescription) {
        cocktailImageView.load(urlString: previewDescription.imageURI)
        cocktailNameLabel.text = previewDescription.cocktailNameKo
    }
    
    func presentSelected() {
        selectedView.isHidden = false
    }
    
    func presentDeselected() {
        selectedView.isHidden = true
    }
}
