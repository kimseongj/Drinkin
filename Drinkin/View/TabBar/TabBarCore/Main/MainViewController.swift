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
    
    //MARK:- LoggedinView
    private let loggedInView = UIView()
    
    private let logoImage2: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "drinkinLogo")
        return logoImage
    }()
    
    private var recommendCocktailCollectionView: UICollectionView = { 
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        return view
    }()
    
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
        let unloggedinMainView = UnloggedinMainView(frame: view.bounds)
        unloggedinMainView.configureUI()
        unloggedinMainView.sendDelegate(delegate)
        view = unloggedinMainView
    }
    
    private func fetchLoggedinMainView() {
        let loggedinMainView = LoggedinMainView(frame: view.bounds)
        
        loggedinMainView.configureUI()
        loggedinMainView.sendDelegate(delegate)
        loggedinMainView.setupRecommendCocktailCollectionView()
        view = loggedinMainView
        
    }
}

