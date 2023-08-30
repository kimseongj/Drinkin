//
//  CocktailFilterModalViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/29.
//

import UIKit
import SnapKit

protocol CocktailFilterDelegate: AnyObject {
    func checkSelectedFilter()
}

final class CocktailFilterModalViewController: UIViewController {
    weak var delegate: CocktailFilterDelegate?
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private let filterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        tableView.register(CocktailFilterCell.self, forCellReuseIdentifier: CocktailFilterCell.identifier)
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)
        
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBackgroundColor()
        configureFilterTableView()
    }
    
    private func configureUI() {
        view.addSubview(contentView)
        contentView.addSubview(filterTableView)
        contentView.addSubview(dismissButton)
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
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
//        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    }
    
    private func configureFilterTableView() {
        filterTableView.dataSource = self
        filterTableView.delegate = self
    }
    
    @objc private func tapDismissButton() {
        self.dismiss(animated: false)
    }
}

extension CocktailFilterModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterTableView.snp.makeConstraints {
            $0.height.equalTo(50 * 3)
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailFilterCell.identifier, for: indexPath) as! CocktailFilterCell
        cell.fill(with: "")

        return cell
    }
}

extension CocktailFilterModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.checkSelectedFilter()
        self.dismiss(animated: true)
    }
}

