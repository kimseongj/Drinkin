//
//  ViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/03.
//

import UIKit
import SnapKit
import Combine

class ViewController: UIViewController {
    private var cancelbag: Set<AnyCancellable> = []
    
    private var cocktail: [BriefDescription] = []
    
    private let briefDescriptionRepository = BriefDescriptionRepository()
    //private let fetchBriefDescriptionUsecase = FetchBriefDescriptionUsecase()
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트버튼", for: .normal)
        button.addTarget(self, action: #selector(pushTestButton), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
    }
    
    @objc func pushTestButton() {
        //briefDescriptionRepository.fetchPublisher()
        //fetchBriefDescriptionUsecase
        //    .sink(receiveCompletion: { print("\($0)")}, receiveValue: {
        //        print($0) }).store(in: &cancelbag)
    }
}

