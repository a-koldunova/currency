//
//  CurvedView.swift
//  currency
//
//  Created by Anastasia Koldunova on 22.03.2022.
//

import UIKit

@IBDesignable class CurvedView: UIView {

    @IBInspectable var curveHeight:CGFloat = 73.0
    @IBInspectable var secondCurveHeight:CGFloat = 65.0
        var curvedLayer = CAShapeLayer()
        
        override func draw(_ rect: CGRect) {
            
            let path = UIBezierPath()

            path.move(to: CGPoint(x: 0, y: 0))
            path.addArc(withCenter: CGPoint(x: curveHeight, y: curveHeight*1.5), radius: curveHeight, startAngle: CGFloat.pi, endAngle: 1.5 * CGFloat.pi, clockwise: true)
            path.addLine(to: CGPoint(x: CGFloat(rect.width) - secondCurveHeight , y: secondCurveHeight))
//            path.addCurve(to: CGPoint(x: CGFloat(rect.width) - secondCurveHeight , y: secondCurveHeight), controlPoint1: CGPoint(x: curveHeight * 2, y: curveHeight * 2), controlPoint2: CGPoint(x: secondCurveHeight, y: secondCurveHeight))
            path.addArc(withCenter: CGPoint(x: CGFloat(rect.width) - secondCurveHeight, y: secondCurveHeight*0), radius: secondCurveHeight, startAngle:  0.5 * CGFloat.pi, endAngle: 0 , clockwise: false)
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.close()
            
            curvedLayer.path = path.cgPath
            curvedLayer.fillColor = UIColor.white.cgColor
            curvedLayer.frame = rect
            
            self.layer.insertSublayer(curvedLayer, at: 0)
        }

}
