//
//  Pie.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 13.11.2022.
//

import Foundation
import UIKit

class PieView: UIView {
    
    let shapeLayer = CAShapeLayer()
    let traceLayer = CAShapeLayer()
    
    internal var percentage: CGFloat = 0
    
    private lazy var lblPercent: UILabel = {
        let lbl = UILabel()
        lbl.text = "%0"
        lbl.textAlignment = .center
        lbl.font = .Poppins.bold(size: 10).font
        lbl.frame = CGRect(x: 0, y: 0, width: 110, height: 110)
        lbl.textColor = CustomColor.textColor
        return lbl
    }()
 
    init() {
        super.init(frame: .zero)
        shapeLayer.needsDisplayOnBoundsChange = true
        layer.insertSublayer(traceLayer, at: 0)
        layer.insertSublayer(shapeLayer, at: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.frame = bounds
        traceLayer.frame = bounds
        addSubview(lblPercent)
        lblPercent.anchorCenter(centerX: centerXAnchor, centerY: centerYAnchor)
        
        let endAngle = (2 * CGFloat.pi * abs(percentage)) / 100
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: bounds.width / 2, startAngle: 0, endAngle: endAngle, clockwise: true)
        let traceCircularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: bounds.width / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = percentage > 0 ? CustomColor.textColorGreen?.cgColor : CustomColor.textColorRed?.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        traceLayer.path = traceCircularPath.cgPath
        traceLayer.strokeColor = CustomColor.pieTraceColor?.cgColor
        traceLayer.lineWidth = 5
        traceLayer.lineCap = CAShapeLayerLineCap.round
        traceLayer.fillColor = UIColor.clear.cgColor
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0.8
        
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        shapeLayer.add(animation, forKey: "animation")
        lblPercent.text = "%\(abs(percentage).stringValue)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
