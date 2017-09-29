//
//  FEBarChartBarView.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/9/28.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

protocol FEBarChartBarViewDelegate: class {
    
    func barView(_ lineView: FEBarChartBarView, didBeganTouchAt point: CGPoint,  originalPoint: FEBarChartPoint)
    
    func barView(_ lineView: FEBarChartBarView, didmovedTouchTo point: CGPoint,  originalPoint: FEBarChartPoint)
    
    func barView(_ lineView: FEBarChartBarView, didEndedTouchAt point: CGPoint, originalPoint: FEBarChartPoint)
}

class FEBarChartBarView: UIView {
    
    var points: [FEBarChartPoint] = [FEBarChartPoint]()
    weak var parentView: FEBarChartView!
    var tapGestureRecognizer: UITapGestureRecognizer!
    var panGestureRecognizer: UIPanGestureRecognizer!
    weak var delegate: FEBarChartBarViewDelegate?
    var lastPoint: FEBarChartPoint?
    var barWidth: CGFloat = 6 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var barColor: UIColor = UIColor.white.withAlphaComponent(0.3) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    var touchable: Bool = true {
        didSet{
            guard let _ = tapGestureRecognizer else {
                return
            }
            tapGestureRecognizer.isEnabled = touchable
        }
    }
    convenience init(parentView: FEBarChartView) {
        self.init()
        self.parentView = parentView
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleGestureRecognize(_:)))
        tapGestureRecognizer.isEnabled = touchable
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGestureRecognize(_:)))
        panGestureRecognizer.isEnabled = touchable
        self.addGestureRecognizer(panGestureRecognizer)
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    func handleGestureRecognize(_ recognize: UIGestureRecognizer) {
        let location = recognize.location(in: self)
        if let barPoint = parentView.calculator.pointFor(location: location, points: points){
            lastPoint = barPoint
            
            if recognize.state == .ended ||
                recognize.state == .cancelled ||
                recognize.state == .recognized{
                delegate?.barView(self, didEndedTouchAt: barPoint.heightPoint, originalPoint: barPoint)
            } else if recognize.state == .began {
                delegate?.barView(self, didBeganTouchAt: barPoint.heightPoint, originalPoint: barPoint)
            } else if recognize.state == .changed {
                delegate?.barView(self, didmovedTouchTo: barPoint.heightPoint, originalPoint: barPoint)
            }
        } else {
            if recognize.state == .ended ||
                recognize.state == .cancelled ||
                recognize.state == .recognized {
                let barPoint = lastPoint == nil ? points.first! : lastPoint
                delegate?.barView(self, didEndedTouchAt: barPoint!.heightPoint,
                                  originalPoint: barPoint!)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
        
        guard let firstPoint = points.first else {
            return
        }

        delegate?.barView(self, didEndedTouchAt: firstPoint.heightPoint, originalPoint: firstPoint)
        
        for point in points {
            
            if point.value == 0 {
                continue
            }
             let barLayer = CAShapeLayer()
   
            if parentView.style == .areaBar {
                barLayer.backgroundColor = barColor.cgColor
//                barLayer.lineCap = kCALineCapSquare
                barLayer.cornerRadius = 3
                barLayer.masksToBounds = true
                
                let height = abs(point.lowY - point.heightY)
                barLayer.bounds = CGRect(x: 0, y: 0, width: point.barWidth, height: height)
                barLayer.position = CGPoint(x: point.x, y: point.lowY - height/2)
            } else {
                barLayer.strokeColor = barColor.cgColor
                barLayer.fillColor = UIColor.clear.cgColor
                barLayer.lineCap = kCALineCapRound
                let path = UIBezierPath()
                path.lineWidth = 1
                let starPoint = CGPoint(x: point.x, y: point.lowY)
                let endPoint = CGPoint(x: point.x, y: point.heightY)
                path.move(to: starPoint)
                path.addLine(to: endPoint)
                barLayer.path = path.cgPath
                barLayer.lineWidth = point.barWidth

            }
            
        
            self.layer.addSublayer(barLayer)
        }
    }
}
