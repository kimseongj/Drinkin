//
//  File.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/06.
//

import UIKit

class LevelOneView: UIStackView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    private func configureUI() {
        self.spacing = 4
        
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = EmptyRectangleView()
        let thirdRectangleView = EmptyRectangleView()
        
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
}

class LevelTwoView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.spacing = 4
        
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = YellowRectangleView()
        let thirdRectangleView = EmptyRectangleView()
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
}

class LevelThreeView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.spacing = 4
        
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = YellowRectangleView()
        let thirdRectangleView = YellowRectangleView()
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
}
