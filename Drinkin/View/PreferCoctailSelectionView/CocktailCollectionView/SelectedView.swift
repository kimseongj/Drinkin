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
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        
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
        
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        
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
        context.move(to: CGPoint(x: bounds.width * 0.15, y: bounds.height * 0.5))
        context.addLine(to: CGPoint(x: bounds.width * 0.4, y: bounds.height * 0.8))
        context.addLine(to: CGPoint(x: bounds.width * 0.8, y: bounds.height * 0.3))
        context.drawPath(using: .stroke)
    }
}
