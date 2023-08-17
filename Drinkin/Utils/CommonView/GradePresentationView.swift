//
//  GradeView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/03.
//

import UIKit
import SnapKit

final class GradePresentationView: UIView {
    var title: String = ""
    var grade: Int = 0
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.text = title
        
        return label
    }()
    
    private lazy var gradeView = GradeView(grade: grade)
    
    init(title: String, grade: Int) {
        super.init(frame: .zero)
        self.title = title
        self.grade = grade
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(titleLabel)
        self.addSubview(gradeView)
        
        switch title {
        case "난이도":
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            
            gradeView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(titleLabel.snp.trailing).offset(12)
                $0.trailing.equalToSuperview()
            }
        case  "당    도", "도    수":
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
            }

            gradeView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(titleLabel.snp.trailing).offset(11)
                $0.trailing.equalToSuperview()
            }
        default:
            break
        }
    }
}
