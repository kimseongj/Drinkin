//
//  HomeBarViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import Foundation

import UIKit

class HomeBarViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 홈바"
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 20)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
    }
}
