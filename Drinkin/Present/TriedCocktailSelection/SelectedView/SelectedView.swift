//
//  SelectedView.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/06.
//

import UIKit

class  SelectedView: UIView {
    private let selectCircleView = SelectCircleView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackgroundColor()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundColor() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
    }
    
    private func configureUI() {
        self.addSubview(selectCircleView)
        
        selectCircleView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(25)
        }
    }
}

class SelectCircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
       // self.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        
        let circleRect = bounds.insetBy(dx: bounds.height * 0.1, dy: bounds.width * 0.1)
        
        //원 그리기
        context.beginPath()
        context.setLineWidth(2)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setFillColor(UIColor(red: 1, green: 0.706, blue: 0.259, alpha: 1).cgColor)
        context.addEllipse(in: circleRect)
        context.drawPath(using: .fillStroke)
        context.closePath()
        
        //체크 표시 그리기
        context.beginPath()
        context.setLineWidth(2)
        context.setLineJoin(.round)
        context.setLineCap(.square)
        context.move(to: CGPoint(x: bounds.width * 0.3, y: bounds.height * 0.55))
        context.addLine(to: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.7))
        context.addLine(to: CGPoint(x: bounds.width * 0.7 , y: bounds.height * 0.35))
        context.drawPath(using: .stroke)
        context.closePath()
    }
}
