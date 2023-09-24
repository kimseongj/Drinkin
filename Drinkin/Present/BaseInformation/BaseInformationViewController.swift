//
//  BaseInformationViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit

final class BaseInformationViewController: UIViewController {
    private let scrollView: UIScrollView = UIScrollView()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 24)
    
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
         label.font = UIFont(name: "Pretendard-SemiBold", size: 15)
     
         return label
     }()
    
    private let brandCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(brandCollectionView)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(safeArea)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        brandCollectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0
        }
    }
}
