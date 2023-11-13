//
//  ScorePresentationView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/03.
//

import UIKit
import SnapKit

final class ScorePresentationView: UIView {
    var title: String?
    var score: Int?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.text = title
        
        return label
    }()
    
    private lazy var scoreView = ScoreView(score: score)
    
    init(title: String?, score: Int?) {
        super.init(frame: .zero)
        self.title = title
        self.score = score
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(titleLabel)
        self.addSubview(scoreView)
        
        switch title {
        case InformationStrings.level:
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            
            scoreView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(titleLabel.snp.trailing).offset(12)
                $0.trailing.equalToSuperview()
            }
        case  InformationStrings.sugarContent, InformationStrings.abv:
            titleLabel.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
            }

            scoreView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(titleLabel.snp.trailing).offset(11)
                $0.trailing.equalToSuperview()
            }
        default:
            break
        }
    }
}
