//
//  ScoreView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/06.
//

import UIKit

class ScoreView: UIStackView {
    var score: Int?
    
    init(score: Int?) {
        super.init(frame: CGRect())
        self.spacing = 4
        self.score = score
        determineLevel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureScoreOne() {
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = EmptyRectangleView()
        let thirdRectangleView = EmptyRectangleView()
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
    
    private func configureScoreTwo() {
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = YellowRectangleView()
        let thirdRectangleView = EmptyRectangleView()
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
    
    private func configureScoreThree() {
        let firstRectangleView = YellowRectangleView()
        let secondRectangleView = YellowRectangleView()
        let thirdRectangleView = YellowRectangleView()
        
        self.addArrangedSubview(firstRectangleView)
        self.addArrangedSubview(secondRectangleView)
        self.addArrangedSubview(thirdRectangleView)
    }
    
    private func determineLevel() {
        switch score {
        case 1:
           configureScoreOne()
        case 2:
            configureScoreTwo()
        case 3:
            configureScoreThree()
        default: break
        }
    }
}
