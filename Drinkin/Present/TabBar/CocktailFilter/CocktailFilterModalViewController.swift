//
//  CocktailFilterModalViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/29.
//

import UIKit
import SnapKit

final class CocktailFilterModalViewController: UIViewController {
    private let filterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        tableView.register(CocktailFilterCell.self, forCellReuseIdentifier: CocktailFilterCell.identifier)
        
        return tableView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor()
        configureUI()
        configureFilterTableView()
    }
    
    private func configureUI() {
        view.addSubview(filterTableView)
        view.addSubview(dismissButton)
        
        filterTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(filterTableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureFilterTableView() {
        filterTableView.dataSource = self
    }
}

extension CocktailFilterModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailFilterCell.identifier, for: indexPath) as! CocktailFilterCell
        cell.fill(with: "")

        return cell
    }
}

