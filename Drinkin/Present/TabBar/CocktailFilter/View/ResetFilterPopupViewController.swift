//
//  ResetFilterPopupViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/01.
//

import UIKit
import SnapKit

protocol ResetFilterDelegate {
    func resetFilter()
}

final class ResetFilterPopupViewController: UIViewController {
    var delegate: ResetFilterDelegate?
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "필터를 모두 초기화하시겠어요?"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "설정한 모든 필터가 초기화됩니다."
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = ColorPalette.subTitleGrayColor
       
        return label
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: FontStrings.pretendardBlack, size: 15)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapDismissButton() {
        self.dismiss(animated: true)
    }
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: FontStrings.pretendardBlack, size: 15)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.layer.borderColor = ColorPalette.buttonBorderColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(tapResetButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapResetButton() {
        delegate?.resetFilter()
        self.dismiss(animated: true)
    }
    
    //MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dismissButton)
        contentView.addSubview(resetButton)
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.5)
            $0.width.equalTo(view.bounds.width * 0.9)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.75)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().offset(-24)
            $0.height.equalTo(42)
            $0.width.equalTo(74)
        }
        
        resetButton.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(1.25)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().offset(-24)
            $0.height.equalTo(42)
            $0.width.equalTo(87)
        }
    }
}
