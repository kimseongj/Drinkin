//
//  UpdateView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/30.
//

import UIKit
import SnapKit

final class UpdateView: UIView {
    private let updateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        
        return activityIndicator
    }()
    
    private let updateLabel: UILabel = {
        let label = UILabel()
        label.text = "데이터를 업데이트 중입니다."
        label.textColor = .white
        
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
        self.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        self.addSubview(updateView)
        updateView.addSubview(activityIndicator)
        updateView.addSubview(updateLabel)
        
        updateView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(80)
            $0.width.equalTo(250)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        updateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(activityIndicator.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(10)
        }
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
}
