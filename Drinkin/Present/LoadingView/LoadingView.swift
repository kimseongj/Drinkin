//
//  LoadingView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/19.
//

import UIKit
import SnapKit

final class LoadingView: UIView {
    
    let mainLoadingTitle: UILabel = {
        let mainLoadingTitle = UILabel()
        mainLoadingTitle.textColor = .black
        mainLoadingTitle.font = UIFont.systemFont(ofSize: 50)
        mainLoadingTitle.text = "tailbe"
        return mainLoadingTitle
    }()
    
    let subLoadingTitle: UILabel = {
        let subLoadingTitle = UILabel()
        subLoadingTitle.textColor = .black
        subLoadingTitle.font = UIFont.systemFont(ofSize: 18)
        subLoadingTitle.text = "for cocktail beginner"
        return subLoadingTitle
    }()
    
    let errorView: UIView = {
        let errorView = UIView()
        return errorView
    }()
    
    let mainNetworkErrorMessage: UILabel = {
        let mem = UILabel()
        mem.textColor = .black
        mem.font = UIFont.boldSystemFont(ofSize: 17)
        mem.text = "이용에 불편을 드려 죄송합니다."
        return mem
    }()
    
    let subNetworkErrorMessage: UILabel = {
        let sem = UILabel()
        sem.textColor = .black
        sem.font = UIFont.systemFont(ofSize: 15)
        sem.numberOfLines = 0
        sem.text = "일시적인 오류 또는 네트워크 문제일 수 있으니 잠시 후 다시 시도해 주시길 바랍니다."
        return sem
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(mainLoadingTitle)
        self.addSubview(subLoadingTitle)
        
        mainLoadingTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(296)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        subLoadingTitle.snp.makeConstraints { make in
            make.top.equalTo(mainLoadingTitle.snp.bottom).offset(6)
            make.height.equalTo(18)
            make.centerX.equalToSuperview()
        }
        
    }
}
