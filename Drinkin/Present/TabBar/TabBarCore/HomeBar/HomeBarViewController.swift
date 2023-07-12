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
    
    private let holdIngredientLabel: UILabel = {
        let label = UILabel()
        label.text = "가지고 있는 재료"
        label.font = UIFont(name: "Pretendard-Bold", size: 17)
        
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vertical_elipsis"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private let addLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "첫번 째 재료를 추가하고"
        
        return label
    }()
    
    private let addLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "만들 수 있는 칵테일을 찾아보세요."
        
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Black", size: 15)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        button.layer.borderWidth = 3
        
        return button
    }()
    
    private let cocktailListTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(holdIngredientLabel)
        view.addSubview(moreButton)
        view.addSubview(addLabel1)
        view.addSubview(addLabel2)
        view.addSubview(addButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        holdIngredientLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(34)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
            $0.height.width.equalTo(28)
        }
        
        addLabel1.snp.makeConstraints {
            $0.top.equalTo(holdIngredientLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        addLabel2.snp.makeConstraints {
            $0.top.equalTo(addLabel1.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(addLabel2.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(39)
            $0.width.equalTo(108)
        }
    }
}

