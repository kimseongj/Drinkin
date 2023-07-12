//
//  PreferCocktailViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation
import UIKit

class PreferCocktailSelectionViewController: UIViewController {
    
    //MARK:- mainLabel
    let mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.font = UIFont.boldSystemFont(ofSize: 20)
        mainLabel.text = "마셔봤던 칵테일 선택"
        
        return mainLabel
    }()
    
    //MARK:- subLabel
    let subLabel: UILabel = {
        let subLabel = UILabel()
        subLabel.font = UIFont.boldSystemFont(ofSize: 14)
        subLabel.textColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1)
        subLabel.text = "선택을 기반으로 다양한 칵테일을 추천해 드립니다."
        
        return subLabel
    }()
    
    //MARK:- exitButton
    let exitButton: UIButton = {
        let exitButton = UIButton()
        exitButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        exitButton.addTarget(self, action: #selector(presentPopupViewController), for: .touchUpInside)
        
        return exitButton
    }()
    
    //MARK:- baseCollectionView
    let preferBaseView = PreferBaseView()
    
    //MARK:- cocktailCollectionView
    private lazy var cocktailCollectionView: UICollectionView = {
        let flowLayout = setUpCompositionalIconLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.clipsToBounds = true
        collectionView.register(CocktailCollectionViewCell.self, forCellWithReuseIdentifier: "CocktailCell")
        
        return collectionView
    }()
    
    
    private let completeSelectionButton: UIButton = {
        let completeSelectionButton = UIButton()
        completeSelectionButton.layer.borderColor = UIColor(red: 0.467, green: 0.467, blue: 0.459, alpha: 1).cgColor
        completeSelectionButton.layer.borderWidth = 3
        completeSelectionButton.backgroundColor = .black
        completeSelectionButton.titleLabel?.textColor = UIColor(red: 0.909, green: 0.906, blue: 0.903, alpha: 1)
        completeSelectionButton.titleLabel?.font = UIFont(name: "Pretendard-Black", size: 15)
        
        return completeSelectionButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        MainViewController.login = true
        configureCocktailCollectionView()
        configureCompleteSelectionButton()
    }
    
    func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(exitButton)
        view.addSubview(preferBaseView)
        view.addSubview(cocktailCollectionView)
        view.addSubview(completeSelectionButton)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom)
            make.leading.equalToSuperview().offset(16)
        }
        
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        preferBaseView.snp.makeConstraints { make in
            make.top.equalTo(exitButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        cocktailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(preferBaseView.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(7)
            make.trailing.equalToSuperview().offset(-7)
            make.bottom.equalTo(completeSelectionButton.snp.top)
        }
        
        completeSelectionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeArea.snp.bottom)//.offset(-AppCoordinator.tabBarHeight)
            make.height.equalTo(54)
        }
        
    }
    
    private func configureCocktailCollectionView() {
        cocktailCollectionView.delegate = self
        cocktailCollectionView.dataSource = self
    }
    
    private func configureCompleteSelectionButton() {
        var isSelected: Bool = false
        
        switch isSelected {
        case false:
            completeSelectionButton.setTitle("다음", for: .normal)
            completeSelectionButton.addTarget(self, action: #selector(presentPopupViewController), for: .touchUpInside)
        case true:
            completeSelectionButton.setTitle("선택 완료", for: .normal)
        }
    }
    
    @objc
    private func presentPopupViewController() {
        let recommendPopupViewController = RecommendPopupViewController()
        recommendPopupViewController.modalPresentationStyle = .formSheet
        present(recommendPopupViewController, animated: true)
    }
}

extension PreferCocktailSelectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cocktailCollectionView.dequeueReusableCell(withReuseIdentifier: "CocktailCell", for: indexPath) as! CocktailCollectionViewCell
        cell.cocktailNameLabel.text = "asd"
        return cell
    } 
}

extension PreferCocktailSelectionViewController {
    private func setUpCompositionalIconLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
}
