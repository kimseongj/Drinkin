//
//  MainViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.

import UIKit
import SnapKit

class MainViewController: UIViewController {

    var delegate: MainViewDelegate?
    var viewModel: CocktailRecommendViewModel?

    static var login: Bool = false
 
    private lazy var loggedinMainViewController = CocktailRecommendViewController(viewModel: viewModel)
    private let unloggedinMainViewController = UnloggedinMainViewController()
    
    init(viewModel: CocktailRecommendViewModel? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if MainViewController.login {
            fetchLoggedinMainView()
        } else {
            fetchUnloggedinMainView()
        }
    }
        
    private func fetchUnloggedinMainView() {
        addChild(unloggedinMainViewController)
        configureUnloggedinMainView()
        unloggedinMainViewController.sendDelegate(delegate)
    }
    
    private func configureUnloggedinMainView() {
        view.addSubview(unloggedinMainViewController.view)
        
        unloggedinMainViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
    }
    
    private func fetchLoggedinMainView() {

        unloggedinMainViewController.removeFromParent()
        unloggedinMainViewController.view.removeFromSuperview()
        addChild(loggedinMainViewController)
        configureLoggedinMainView()
        loggedinMainViewController.sendDelegate(delegate)
    }
    
    private func configureLoggedinMainView() { 
        view.addSubview(loggedinMainViewController.view)
        
        loggedinMainViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
    }
}
