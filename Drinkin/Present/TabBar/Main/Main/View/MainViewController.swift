//
//  MainViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.

import UIKit
import SnapKit
import Combine

final class MainViewController: UIViewController {
    private let viewModel: MainViewModel
    private let cocktailRecommendViewModel: CocktailRecommendViewModel
    var flowDelegate: MainVCFlow?
    
    private var cancelBag: Set<AnyCancellable> = []
    
    private lazy var loggedinMainViewController = CocktailRecommendViewController(viewModel: cocktailRecommendViewModel)
    private let unloggedinMainViewController = UnloggedinMainViewController()
    
    //MARK: - Init
    
    init(viewModel: MainViewModel,
         cocktailRecommendViewModel: CocktailRecommendViewModel) {
        self.viewModel = viewModel
        self.cocktailRecommendViewModel = cocktailRecommendViewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticationBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        AppCoordinator.tabBarController.tabBar.isHidden = false
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
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

//MARK: - Authentication Binding

extension MainViewController {
    func authenticationBinding() {
        viewModel.accessTokenStatusPublisher().receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            if $0 == true {
                self.fetchLoggedinMainView()
            }  else {
                self.fetchUnloggedinMainView()
            }
        }.store(in: &cancelBag)
    }
}
