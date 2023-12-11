//
//  MainViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private var viewModel: CocktailRecommendViewModel
    private let loginManager: LoginManager
    var flowDelegate: MainVCFlow?
    
    private lazy var loggedinMainViewController = CocktailRecommendViewController(viewModel: viewModel)
    private let unloggedinMainViewController = UnloggedinMainViewController()
    
    //MARK: - Init
    
    init(viewModel: CocktailRecommendViewModel, loginManager: LoginManager) {
        self.viewModel = viewModel
        self.loginManager = loginManager
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
        
        if loginManager.isAuthenticated() {
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
        if self.children.contains(loggedinMainViewController) {
                    loggedinMainViewController.removeFromParent()
                    loggedinMainViewController.view.removeFromSuperview()
        }
    
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
        if self.children.contains(unloggedinMainViewController) {
                    unloggedinMainViewController.removeFromParent()
                    unloggedinMainViewController.view.removeFromSuperview()
        }
        
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
