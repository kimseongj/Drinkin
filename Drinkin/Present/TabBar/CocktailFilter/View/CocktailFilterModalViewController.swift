//
//  CocktailFilterModalViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/29.
//

import UIKit
import SnapKit

final class CocktailFilterModalViewController: UIViewController {
    private var viewModel: CocktailFilterViewModel
    private let filterType: FilterType
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private let filterTableView: MutableSizeTableView = {
        let tableView = MutableSizeTableView()
        tableView.backgroundColor = .gray
        tableView.register(DetailFilterCell.self, forCellReuseIdentifier: DetailFilterCell.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapDismissButton() {
        self.dismiss(animated: false)
    }
    
    //MARK: - Init
    
    init(filterType: FilterType, viewModel: CocktailFilterViewModel) {
        self.filterType = filterType
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
        configureFilterTableView()
    }
    
    //MARK: - ConfigureUI()
    
    private func configureUI() {
        view.backgroundColor = ColorPalette.blackTransparencyColor
        
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
            $0.height.equalTo(60)
        }
    }
}

//MARK: - ConfigureTableView

extension CocktailFilterModalViewController {
    private func configureFilterTableView() {
        filterTableView.dataSource = self
        filterTableView.delegate = self
    }
}

//MARK: - FilterTableView DataSource

extension CocktailFilterModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchDetailFilter(filterType: filterType).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailFilterCell.identifier, for: indexPath) as! DetailFilterCell
        cell.fill(with: viewModel.fetchDetailFilter(filterType: filterType)[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - FilterTableView Delegate

extension CocktailFilterModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousSelectedIndexPath = viewModel.selectedDetailFilterIndexPath {
            tableView.cellForRow(at: previousSelectedIndexPath)?.isSelected = false
        }
        
        tableView.cellForRow(at: indexPath)?.isSelected = true
        viewModel.selectedDetailFilterIndexPath = indexPath
        viewModel.insertDetailFilter(filterType: filterType, detailFilterIndex: indexPath.row)
    }
}
