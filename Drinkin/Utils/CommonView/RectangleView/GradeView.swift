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


class GradeView: UIStackView {
    var grade: Int?
    
    init(grade: Int?) {
        super.init(frame: CGRect())
        self.spacing = 4
        self.grade = grade
        determineLevel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLevelOne() {
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = EmptyRectangleView()
        let thirdRectangleView = EmptyRectangleView()
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
    
    private func configureLevelTwo() {
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = YellowRectangleView()
        let thirdRectangleView = EmptyRectangleView()
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
    
    private func configureLevelThree() {
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = YellowRectangleView()
        let thirdRectangleView = YellowRectangleView()
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
    
    private func determineLevel() {
        switch grade {
        case 1:
           configureLevelOne()
        case 2:
            configureLevelTwo()
        case 3:
            configureLevelThree()
        default: break
            //에러 처리하기
        }
    }
    
}
