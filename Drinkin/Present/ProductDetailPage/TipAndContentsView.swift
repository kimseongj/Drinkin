//
//  TipAndContentsView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import UIKit
import SnapKit

class TipAndContentsView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = .white
        return titleView
    }()
    
    let categoryName: UILabel = {
        let categoryName = UILabel()
        categoryName.textColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1)
        categoryName.text = "CATEGORY_NAME"
        categoryName.font = UIFont.systemFont(ofSize: 14)
        categoryName.backgroundColor = .white
        return categoryName
    }()
    
    let contentTitle: UILabel = {
        let contentTitle = UILabel()
        contentTitle.textColor = UIColor(red: 0.14, green: 0.137, blue: 0.122, alpha: 1)
        contentTitle.font = UIFont.boldSystemFont(ofSize:20)
        contentTitle.text = "CONTENT_TITLE"
        return contentTitle
    }()
    
    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.backgroundColor = .lightGray
        profileImage.layer.cornerRadius = 18
        return profileImage
    }()
    
    let profileName: UILabel = {
        let profileName = UILabel()
        profileName.textColor = .black
        profileName.font = UIFont.systemFont(ofSize: 14)
        profileName.text = "USER_NAME"
        return profileName
    }()
    
    let followButton: UIButton = {
        let followButton = UIButton()
        followButton.backgroundColor =  UIColor(red: 1, green: 0.3, blue: 0.468, alpha: 1)
        followButton.layer.cornerRadius = 8
        followButton.setTitle("팔로우", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return followButton
    }()
    
    let partition: UILabel = {
        let partition = UILabel()
        partition.layer.backgroundColor = UIColor(red: 0.906, green: 0.906, blue: 0.906, alpha: 1).cgColor
        return partition
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(imageView)
        self.addSubview(titleView)
        
        let width = UIScreen.main.bounds.size.width // 화면의 넓이 구하는 방식
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(width)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(128)
        }
        configureTitleView()
        
    }
    
    func configureTitleView() {
        titleView.addSubview(categoryName)
        titleView.addSubview(contentTitle)
        titleView.addSubview(profileImage)
        titleView.addSubview(profileName)
        titleView.addSubview(followButton)
        titleView.addSubview(partition)
        
        categoryName.snp.makeConstraints { make in
            make.top.equalTo(titleView).offset(16)
            make.leading.equalTo(titleView).offset(16)
            make.trailing.equalTo(titleView).offset(-16)
            make.height.equalTo(14)
        }
        
        contentTitle.snp.makeConstraints { make in
            make.top.equalTo(categoryName.snp.bottom).offset(4)
            make.leading.equalTo(titleView).offset(16)
            make.trailing.equalTo(titleView).offset(-16)
            make.height.equalTo(30)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(contentTitle.snp.bottom).offset(12)
            make.leading.equalTo(titleView).offset(16)
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
        
        profileName.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.leading.equalTo(profileImage.snp.trailing).offset(8)
            make.height.equalTo(14)
            make.width.equalTo(100)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.trailing.equalTo(titleView).offset(-16)
            make.width.equalTo(69)
            make.height.equalTo(30)
        }
        
        partition.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.leading.equalTo(titleView).offset(16)
            make.trailing.equalTo(titleView).offset(-16)
            make.height.equalTo(1)
        }
    }
}
