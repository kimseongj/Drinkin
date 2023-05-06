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
        let yellowRectangleView = YellowRectangleView()
        let emptyRectangleView = EmptyRectangleView()
        
        self.addArrangedSubview(yellowRectangleView)
        self.addArrangedSubview(emptyRectangleView)
        self.addArrangedSubview(emptyRectangleView)
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
        let yellowRectangleView = YellowRectangleView()
        let emptyRectangleView = EmptyRectangleView()
        
        self.addArrangedSubview(yellowRectangleView)
        self.addArrangedSubview(yellowRectangleView)
        self.addArrangedSubview(emptyRectangleView)
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
        let yellowRectangleView = YellowRectangleView()
        let emptyRectangleView = EmptyRectangleView()
        
        self.addArrangedSubview(yellowRectangleView)
        self.addArrangedSubview(yellowRectangleView)
        self.addArrangedSubview(yellowRectangleView)
    }
}
