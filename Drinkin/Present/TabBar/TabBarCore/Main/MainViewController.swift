//
//  MainViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func pushChooseCocktailVC()
    func pushProductDetailVC()
}

class MainViewController: UIViewController {

    var delegate: MainViewDelegate?

    static var login: Bool = false
 
    private let loggedinMainViewController = LoggedinMainViewController()
    private let unloggedinMainViewController = UnloggedinMainViewController()
    
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
        //view.addSubview(unloggedinMainViewController.view)
        //let unloggedinMainViewController = UnloggedinMainViewController()
        //unloggedinMainViewController.configureUI()
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

