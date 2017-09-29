//
//  FELineChartPoint.swift
//  LineGraph
//
//  Created by hzf on 2017/7/13.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

class FELineChartPoint: CustomDebugStringConvertible, CustomStringConvertible  {

    var x: CGFloat = 0
    var y: CGFloat = 0
    var value: CGFloat = 0
    var index: Int = 0
    var point: CGPoint {
        return CGPoint(x: x, y: y)
    }
    
    init(_ x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    convenience init(_ point: CGPoint){
        self.init(point.x, y: point.y)
    }
    
    init() {}
    
    var description: String {
        return "\(point.x), \(point.y)"
    }
    
    var debugDescription: String {
        return  "\(point.x), \(point.y)"
    }
}

extension FELineChartPoint {
    
    static func pointsWithValues(_ values: [CGFloat])->[FELineChartPoint]{
        
        var array = [FELineChartPoint]()
        for (index, value)  in values.enumerated() {
            let point = FELineChartPoint()
            point.value = CGFloat(value)
            point.index += index
            array.append(point)
        }
        return array
    }
    
    static func maxValuePoint(_ points: [FELineChartPoint])->FELineChartPoint?{
        let maxValuePoint = filter(points: points) { (firstPoint, secondPoint) -> Bool in
            return firstPoint.value < secondPoint.value
        }
        return maxValuePoint
    }
    
    static func mimValuePoint(_ points: [FELineChartPoint])->FELineChartPoint?{
        let minValuePoint = filter(points: points) { (firstPoint, secondPoint) -> Bool in
            return firstPoint.value > secondPoint.value
        }
        return minValuePoint
    }
    ///
    static func filter(points: [FELineChartPoint], comparator: (FELineChartPoint, FELineChartPoint)->Bool)->FELineChartPoint?{
        guard points.count > 0 else {
            return nil
        }
        var targetPoint = points[0]
        points.forEach { (nextPoint) in
            if comparator(targetPoint, nextPoint) {
                targetPoint = nextPoint
            }
        }
        return targetPoint
    }
}


class FELineChartPathSegment {
    
    var startPoint: FELineChartPoint =  FELineChartPoint()
    var endPoint: FELineChartPoint = FELineChartPoint()
    var controlPoint: FELineChartPoint = FELineChartPoint()
    
    var coefficientA: CGFloat = 0
    var coefficientB: CGFloat = 0
    var coefficientC: CGFloat = 0
    
    var lineStyle: FELineChartLineStyle = .none
    var isStartPointOriginalPoint: Bool = false
    
    func isContainedPoint(_ point: CGPoint) -> Bool{
        
        if point.x >= startPoint.x , point.x <= endPoint.x {
            return true
        }
        return false
    }
    
    func yValue(_ point: CGPoint) -> CGFloat {
        let x = point.x
        let y = coefficientA * CGFloat(powf(Float(x), 2)) + coefficientB*x + coefficientC
        return y
    }
    
    func originalPoint(_ point: CGPoint) -> FELineChartPoint? {
        
        switch lineStyle {
        case .none:
            return nil
        case .straight, .bezierTaper:
            let newPoint = FELineChartPoint((startPoint.x + endPoint.x)/2, y: (startPoint.y + endPoint.y)/2)
            return newPoint
        case .bezierWave:
            
            if isStartPointOriginalPoint {
                return startPoint
            } else {
                return endPoint
            }
        }
    }
}





