//
//  BrandInformation.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/06.
//

import UIKit
import SnapKit
import Combine

final class BrandInformationViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    private let brandImageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 24)
        
        return label
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 20)
        
        return label
    }()
    
    private let classificationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        
        return label
    }()
    
    private let classificationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
        
        return label
    }()
    
    private let abvLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        
        return label
    }()
    
    private let abvDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.pretendardBold, size: 15)
        
        return label
    }()
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
    }
    
    private func fill() {
        
    }
}
