//
//  MainViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private var viewModel: CocktailRecommendViewModel
    var flowDelegate: MainVCFlow?
    static var login: Bool = false
    
    private lazy var loggedinMainViewController = CocktailRecommendViewController(viewModel: viewModel)
    private let unloggedinMainViewController = UnloggedinMainViewController()
    
    //MARK: - Init
    
    init(viewModel: CocktailRecommendViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        AppCoordinator.tabBarController.tabBar.isHidden = false
        
        if MainViewController.login {
            fetchLoggedinMainView()
        } else {
            fetchUnloggedinMainView()
        }
    }
    
    //MARK: - ConfigureUI
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
}

//MARK: - UnloggedinVC Present

extension MainViewController {
    private func fetchUnloggedinMainView() {
        addChild(unloggedinMainViewController)
        configureUnloggedinMainView()
        unloggedinMainViewController.sendDelegate(flowDelegate)
    }
    
    private func configureUnloggedinMainView() {
        view.addSubview(unloggedinMainViewController.view)
        
        unloggedinMainViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
    }
}

//MARK: - LoggedinVC Present

extension MainViewController {
    private func fetchLoggedinMainView() {
        unloggedinMainViewController.removeFromParent()
        unloggedinMainViewController.view.removeFromSuperview()
        addChild(loggedinMainViewController)
        configureLoggedinMainView()
        loggedinMainViewController.sendDelegate(flowDelegate)
    }
    
    private func configureLoggedinMainView() {
        view.addSubview(loggedinMainViewController.view)
        
        loggedinMainViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
    }
    
}