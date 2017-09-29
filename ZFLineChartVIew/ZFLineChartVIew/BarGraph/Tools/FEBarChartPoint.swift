//
//  FEBarChartPoint.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/9/28.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

class FEBarChartPoint: NSObject {
  
    var x: CGFloat = 0
    var lowY: CGFloat = 0
    var heightY: CGFloat = 0
    var value: CGFloat = 0
    var index: Int = 0
    var barWidth: CGFloat = 6
    var lowPoint: CGPoint {
        return CGPoint(x: x, y: lowY)
    }
    var heightPoint: CGPoint {
        return CGPoint(x: x, y: heightY)
    }
    
   override var description: String {
        return "value:\(value) low: \(lowPoint), height: \(heightPoint)"
    }
    
   override var debugDescription: String {
        return  "\(lowPoint), \(heightPoint)"
    }
}

extension FEBarChartPoint {
    
    static func pointsWithValues(_ values: [CGFloat])->[FEBarChartPoint]{
        
        var array = [FEBarChartPoint]()
        for (index, value)  in values.enumerated() {
            let point = FEBarChartPoint()
            point.value = CGFloat(value)
            point.index += index
            array.append(point)
        }
        return array
    }
    
    static func maxValuePoint(_ points: [FEBarChartPoint])->FEBarChartPoint?{
        let maxValuePoint = filter(points: points) { (firstPoint, secondPoint) -> Bool in
            return firstPoint.value < secondPoint.value
        }
        return maxValuePoint
    }
    
    static func mimValuePoint(_ points: [FEBarChartPoint])->FEBarChartPoint?{
        let minValuePoint = filter(points: points) { (firstPoint, secondPoint) -> Bool in
            return firstPoint.value > secondPoint.value
        }
        return minValuePoint
    }
    ///
    static func filter(points: [FEBarChartPoint], comparator: (FEBarChartPoint, FEBarChartPoint)->Bool)->FEBarChartPoint?{
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
