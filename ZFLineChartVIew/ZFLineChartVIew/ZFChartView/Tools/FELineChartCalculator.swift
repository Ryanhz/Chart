//
//  ZFLineChartCalculator.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/8/15.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

class FELineChartCalculator: NSObject {
    
    weak var parentView: FELineChartView!
    
    var drawableAreaWidth: CGFloat!
    
    var drawableAreaHeight: CGFloat!
    
    func xLocationForPointAt(_ index: Int) -> CGFloat {
        var x: CGFloat
        var gap: CGFloat
        
        gap = self.drawableAreaWidth/CGFloat(maxCount - 1)
        
        x = gap * CGFloat(index)
        x = round(x)
        return x
    }
    
    func yLocationForPoints(_ value: CGFloat) -> CGFloat {
        var y: CGFloat
        let maxValue: CGFloat = 500
        let minValue: CGFloat = 0
        let differ = maxValue - minValue
        
        let pixels = self.drawableAreaHeight
        y = (differ > 0 ? ((maxValue - value) * pixels!/differ) : 0)
        y = round(y)
        return y
    }
    
    var maxCount: Int {
        return parentView.points.count
    }
    
    func maxValueOfPoints(_ points: [FELineChartPoint]) -> FELineChartPoint?{
        
        let max = FELineChartPoint.filter(points: points) { (firstPoint, secondPoint) -> Bool in
            return firstPoint.value > secondPoint.value
        }
        return max
    }
    
    func minValueOfPoints(_ points: [FELineChartPoint]) -> FELineChartPoint?{
        
        let min = FELineChartPoint.filter(points: points) { (firstPoint, secondPoint) -> Bool in
            return firstPoint.value > secondPoint.value
        }
        return min
    }
    
    func recaclculatePointsCoordinate(){
        calculatePointsCoordinate(parentView.points)
    }
    
    func calculatePointsCoordinate(_ points: [FELineChartPoint]) {
        
        guard points.count > 0 else {
            return
        }
        
        for (index, point) in points.enumerated() {
            point.index = index
            point.y = yLocationForPoints(point.value)
            point.x = xLocationForPointAt(index)
        }
    }
}

extension FELineChartCalculator {
    
    
    func pathSegmentsWithpPoints(_ points: [FELineChartPoint], lineStyle: FELineChartLineStyle) -> [FELineChartPathSegment]? {
        guard points.count >= 2 else {
            return nil
        }
        
        var segments = [FELineChartPathSegment]()
        var currentPoint = points[0]
        var newPoint: FELineChartPoint!
        
        for (offset, point) in points.enumerated() {
            if offset == 0 {
                continue
            }
            
            newPoint = point
            
            var controlPointPre: CGPoint
            var controlPointSub: CGPoint
            let midPoint = middlePointWith(currentPoint.point, point2: newPoint.point)
            
            var segment: FELineChartPathSegment!
            if lineStyle == .bezierWave {
                if currentPoint.y > newPoint.y {
                    controlPointPre = higherControlPointWith(currentPoint.point, point2: midPoint)
                    controlPointSub = lowerControlPointWith(midPoint, point2: newPoint.point)
                } else {
                    controlPointPre = lowerControlPointWith(currentPoint.point, point2: midPoint)
                    controlPointSub = higherControlPointWith(midPoint, point2: newPoint.point)
                }
                
                segment = FELineChartPathSegment()
                segment.lineStyle = lineStyle
                segment.isStartPointOriginalPoint = true
                segment.startPoint = currentPoint
                segment.endPoint = FELineChartPoint(midPoint)
                segment.controlPoint = FELineChartPoint(controlPointPre)
                calculateQuadraticCoefficentsFor(segment)
                segments.append(segment)
                
                segment = FELineChartPathSegment()
                segment.lineStyle = lineStyle
                segment.isStartPointOriginalPoint = false
                segment.startPoint = FELineChartPoint(midPoint)
                segment.endPoint = newPoint
                segment.controlPoint = FELineChartPoint(controlPointSub)
                calculateQuadraticCoefficentsFor(segment)
                segments.append(segment)
                
            } else if lineStyle == .straight {
                
                segment = FELineChartPathSegment()
                segment.lineStyle = lineStyle
                segment.startPoint = currentPoint
                segment.endPoint = newPoint
                calculateQuadraticCoefficentsFor(segment)
                segments.append(segment)
                
            } else if lineStyle == .bezierTaper {
                let controlPoint = higherControlPointWith(currentPoint.point, point2: newPoint.point)
                
                segment = FELineChartPathSegment()
                segment.lineStyle = lineStyle
                segment.startPoint = currentPoint
                segment.endPoint = newPoint
                segment.controlPoint = FELineChartPoint(controlPoint)
                calculateQuadraticCoefficentsFor(segment)
                segments.append(segment)
            }
            
            currentPoint = newPoint
            
        }
        return segments
    }
    
    func calculateQuadraticCoefficentsFor(_ segment: FELineChartPathSegment){
        
        var p1: CGPoint, p2: CGPoint, p3 : CGPoint
        
        p1 = segment.startPoint.point
        p2 = segment.controlPoint.point
        p3 = segment.endPoint.point
        
        
        if segment.lineStyle == .bezierTaper || segment.lineStyle == .bezierWave {
            // Convert quadratic bezier curve to parabola
            // reference : (http://math.stackexchange.com/questions/1257576/convert-quadratic-bezier-curve-to-parabola)
            // here we are sure that x2 = (x1+x3)/2
            segment.coefficientA = (p1.y - 2 * p2.y + p3.y) / CGFloat(powf((Float(p3.x - p1.x)), 2))
            segment.coefficientB = 2 * (p3.x*(p2.y - p1.y) + p1.x*(p2.y - p3.y)) / CGFloat(powf((Float(p3.x - p1.x)), 2))
            
            segment.coefficientC = p1.y - segment.coefficientA * CGFloat(powf(Float(p1.x), 2)) - segment.coefficientB * p1.x;
        } else if segment.lineStyle == .straight {
            segment.coefficientA = 0;
            segment.coefficientB = (p3.y - p1.y) / (p3.x - p1.x);
            segment.coefficientC = p1.y - segment.coefficientB * p1.x;
        }
    }
    
    func segmentFor(point: CGPoint, in segments: [FELineChartPathSegment]) -> FELineChartPathSegment? {
        
        guard segments.count > 0 else {
            return nil
        }
        
        var segment: FELineChartPathSegment?
        
        for obj in segments {
            if obj.startPoint.x <= point.x, obj.endPoint.x >= point.x {
                segment = obj
                break
            }
        }
        return segment
    }
    
    func middlePointWith(_ point1: CGPoint, point2: CGPoint) -> CGPoint {
        
        return CGPoint(x: (point1.x + point2.x)/2, y: (point2.y+point1.y)/2)
    }
    
    func lowerControlPointWith(_ point1: CGPoint, point2: CGPoint) -> CGPoint {
        
        var newPoint: CGPoint = .zero
        newPoint.x = (point1.x + point2.x) / 2
        newPoint.y = point1.y > point2.y ? point2.y : point1.y
        return newPoint
    }
    
    func higherControlPointWith(_ point1: CGPoint, point2: CGPoint) -> CGPoint {
        
        var newPoint: CGPoint = .zero
        newPoint.x = (point1.x + point2.x) / 2
        newPoint.y = point1.y > point2.y ? point1.y : point2.y
        return newPoint
    }
    
    func verticalLocationForValue(_ average: CGFloat) -> CGFloat {
        
        return self.yLocationForPoints(average)
    }
    
    func valueReferToVertical(_ location: CGFloat) -> CGFloat {
        
        var value: CGFloat
        let maxValue: CGFloat = 500
        
        let minValue: CGFloat = 0
        
        let  differ = maxValue - minValue
        
        value = maxValue - location * differ / self.drawableAreaHeight
        return value
        
    }
}

