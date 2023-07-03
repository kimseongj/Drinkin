//
//  FilterViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/15.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {
//    private dataSource: UITableViewDiffableDataSource<Section, >!
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일 리스트"
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 20)
        
        return label
    }()
    
    private let initializationButton: UIButton = {
       let button = UIButton()
        button.setTitle("필터 초기화", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    private let selectionFilterView = SelectionFilterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    private let tableView = UITableView()
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(titleLabel)
        view.addSubview(initializationButton)
        view.addSubview(selectionFilterView)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        initializationButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        selectionFilterView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(60)
        }
    }
    
//    private func configureDataSource() {
//        tableView.register
//    }
}

extension FilterViewController: UITableViewDelegate {
    
}

class BaseSortModalView: UIViewController {
    
}

class HoldedIngredientSortModalView: UIViewController {
    
}

class LevelSortModalView: UIViewController {
    
}

class ABVSortModalView: UIViewController {
    
}

class IngredientView: UIViewController {
    
}
