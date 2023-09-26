//
//  TextInformationView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/03.
//

import UIKit
import SnapKit

final class TextInformationView: UIView {
    private var title: String = ""
    
    private let titleLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: FontStrings.pretendardExtraBold, size: 15)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 14)
        
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        configureUI()
        configureTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(titleLabelView)
        titleLabelView.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        titleLabelView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
            $0.width.equalTo(65)
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.leading.equalTo(titleLabelView.snp.trailing)
        }
    }
    
    private func configureTitle() {
        titleLabel.text = title
    }
    
    func fill(with description: String) {
        descriptionLabel.text = description
    }
}
