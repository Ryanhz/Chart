//
//  FELineChartLineView.swift
//  LineGraph
//
//  Created by hzf on 2017/7/14.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

protocol FELineChartLineViewDelegate: class {
    
    func lineView(_ lineView: FELineChartLineView, didBeganTouchAt point: CGPoint, belongToSegmentOf originalPoint: FELineChartPoint)
    
    func lineView(_ lineView: FELineChartLineView, didmovedTouchTo point: CGPoint, belongToSegmentOf originalPoint: FELineChartPoint)
    
    func lineView(_ lineView: FELineChartLineView, didEndedTouchAt point: CGPoint, belongToSegmentOf originalPoint: FELineChartPoint)
    
}

let default_rise_height: CGFloat = 7
//let 
class FELineChartLineView: UIView {

    weak var delegate: FELineChartLineViewDelegate?
    weak var parentView: FELineChartView!
    
    var points: [FELineChartPoint]!
    var style: FELineChartLineStyle = .bezierWave
    var lineColor: UIColor = UIColor.white
    var lineWidth: CGFloat = 1
    var pathSegments: [FELineChartPathSegment]!
    var touchView: UIView!
    var touchable: Bool = true
    
    var pressGestureRecognize: UIPanGestureRecognizer?
    var movingPointView: UIView!
    var lineShapeLayer: CAShapeLayer!
    var gradientMaskLayer: CAShapeLayer!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if pressGestureRecognize == nil {
            setupLongPressGestureRecognize()
        }
    }

    override func draw(_ rect: CGRect) {
        self.pathSegments = parentView.calculator.pathSegmentsWithpPoints(points, lineStyle: style)
        
        movingPointView = UIView()
        movingPointView.backgroundColor = UIColor.white
        movingPointView.bounds = CGRect(x: 0, y: 0, width: 6, height: 6)
        self.addSubview(movingPointView)
        
        var linePath: UIBezierPath

        if lineShapeLayer != nil {
            lineShapeLayer.removeFromSuperlayer()
        }

        var point: FELineChartPoint
        if style != .none {
            lineShapeLayer = CAShapeLayer()
            lineShapeLayer.strokeColor = lineColor.cgColor
            lineShapeLayer.fillColor = UIColor.clear.cgColor
            lineShapeLayer.backgroundColor = UIColor.clear.cgColor
            lineShapeLayer.lineWidth = lineWidth
          
            self.layer.addSublayer(lineShapeLayer)
            linePath = UIBezierPath()
            point = points[0]
            
            linePath.move(to: CGPoint(x: point.x, y: point.y))
            for pathSegment in pathSegments {
//                print(pathSegment.endPoint.point)
                switch style {
                case .straight:
                    linePath.addLine(to: pathSegment.endPoint.point)

                case .bezierWave, .bezierTaper:
                    linePath.addQuadCurve(to: pathSegment.endPoint.point, controlPoint: pathSegment.controlPoint.point)
                default:
                    break
                }
            }
            lineShapeLayer.path = linePath.cgPath
        }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 5
        animation.fromValue = 0
        animation.toValue = 1
        animation.isRemovedOnCompletion = true
        lineShapeLayer.add(animation, forKey: "strokeEnd")
    }

    func setupLongPressGestureRecognize(){
        pressGestureRecognize = UIPanGestureRecognizer()
        pressGestureRecognize?.addTarget(self, action: #selector(handleGestureRecognize(_:)))
        pressGestureRecognize?.isEnabled = touchable
        self.addGestureRecognizer(pressGestureRecognize!)
    }
    
    func handleGestureRecognize(_ recognize: UIGestureRecognizer) {
        
        let location = recognize.location(in: self)
        var originalPoint: FELineChartPoint!
        var segment: FELineChartPathSegment?
        var locationOnBezierPath: CGFloat!
        var movingPoint: CGPoint = .zero

        var minX: CGFloat
        minX = points.first!.x + 1
        segment = parentView.calculator.segmentFor(point: location, in: pathSegments)
        if segment == nil {
            if recognize.state == .ended ||
                recognize.state == .cancelled ||
                recognize.state == .recognized {
                
                originalPoint = movingPoint.x <= minX ? points.first : points.last
                movingPoint = originalPoint.point
                delegate?.lineView(self, didEndedTouchAt: movingPoint, belongToSegmentOf: originalPoint)
            }
        } else {
            
            originalPoint = segment!.originalPoint(location)
            locationOnBezierPath = segment!.yValue(location)
            movingPoint = CGPoint(x: location.x, y: locationOnBezierPath)
            
            // touchview center
            // 1.recalculate scale from touchview's transform
            // reference from : (http://stackoverflow.com/questions/2690337/get-just-the-scaling-transformation-out-of-cgaffinetransform)
            movingPointView.center = movingPoint
            
            if recognize.state == .ended ||
                recognize.state == .cancelled ||
                recognize.state == .recognized{
                delegate?.lineView(self, didEndedTouchAt: movingPoint, belongToSegmentOf: originalPoint)
            } else if recognize.state == .began {
                movingPointView.isHidden = false
                delegate?.lineView(self, didBeganTouchAt: movingPoint, belongToSegmentOf: originalPoint)
            } else if recognize.state == .changed {
                delegate?.lineView(self, didmovedTouchTo: movingPoint, belongToSegmentOf: originalPoint)
            }
        }
    }
    
    func pointBelowPoint(_ point: CGPoint, for distanc: CGFloat) -> CGPoint {
        return CGPoint(x: point.x, y: point.y + distanc)
    }
}
