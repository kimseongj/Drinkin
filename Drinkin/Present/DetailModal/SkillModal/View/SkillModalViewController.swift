//
//  SkillModalViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/26.
//

import UIKit
import SnapKit

final class SkillModalViewController: UIViewController {
    private var viewModel: SkillModalViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontStrings.themeFont, size: 24)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: FontStrings.pretendardSemiBold, size: 15)
        
        return label
    }()
    
    //MARK: - Init
    init(viewModel: SkillModalViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.fetchSkillDetail { [weak self] in
            guard let self = self else { return }
            
            self.fill(skillDetail: $0)
        }
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { 
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }

    //MARK: - Fill View
    
    private func fill(skillDetail: SkillDetail) {
        titleLabel.text = skillDetail.skillName
        descriptionLabel.text = skillDetail.description
    }
}
