//
//  FEBarChartCalculator.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/9/28.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

class FEBarChartCalculator {
    
    weak var parentView: FEBarChartView!
    
    var drawableAreaWidth: CGFloat = 0
    var drawableAreaHeight: CGFloat = 0
    var barPadding: CGFloat = 12
    
    func xLocationForPointAt(_ index: Int) -> CGFloat {
        var x: CGFloat
        var gap: CGFloat
        
        if parentView.style == .areaBar {
            gap =  self.drawableAreaWidth / CGFloat(maxCount)
            
            x = gap * CGFloat(index) + barPadding/2 + barWidth/2
        } else {
            gap = self.drawableAreaWidth/CGFloat(maxCount - 1)
            
            x = gap * CGFloat(index)
        }
        x = round(x)
        return x
    }
    
    func yLocationForPoint(_ value: CGFloat) -> CGFloat {
        var y: CGFloat
        let maxValue: CGFloat = maxValueOfPoints(parentView.points)?.value ?? 0
        print(maxValue)
        let minValue: CGFloat = 0
        let differ = maxValue - minValue
        
        let pixels = self.drawableAreaHeight
        y = (differ > 0 ? ((maxValue - value) / differ  * pixels) : 0)
        y = round(y)
        return y
    }
    
    var barWidth: CGFloat {
        let barWidth = (self.drawableAreaWidth - CGFloat(maxCount) * barPadding)/CGFloat(maxCount)
        return barWidth
    }
    
    var maxCount: Int {
        return parentView.points.count
    }
    
    func maxValueOfPoints(_ points: [FEBarChartPoint]) -> FEBarChartPoint?{
        
        let max = FEBarChartPoint.filter(points: points) { (firstPoint, secondPoint) -> Bool in
            return firstPoint.value < secondPoint.value
        }
        return max
    }
    
    func minValueOfPoints(_ points: [FEBarChartPoint]) -> FEBarChartPoint?{
        
        let min = FEBarChartPoint.filter(points: points) { (firstPoint, secondPoint) -> Bool in
            return firstPoint.value > secondPoint.value
        }
        return min
    }
    
    func recaclculatePointsCoordinate(){
        calculatePointsCoordinate(parentView.points)
    }
    
    func calculatePointsCoordinate(_ points: [FEBarChartPoint]) {
        
        guard points.count > 0 else {
            return
        }
        
        for (index, point) in points.enumerated() {
            point.index = index
            point.x = xLocationForPointAt(index)
            point.lowY = self.drawableAreaHeight
            point.heightY = yLocationForPoint(point.value)
            
            if parentView.style == .areaBar {
                point.barWidth = barWidth
            } else {
                point.barWidth = 6
            }
        }
    }
    
    func pointFor(location: CGPoint, points: [FEBarChartPoint])-> FEBarChartPoint? {
        
        guard points.count > 0 else {
            return nil
        }
        
        var point: FEBarChartPoint?
        for item in points {
            if abs(item.x - location.x) <= item.barWidth/2 {
                point = item
                break
            }
        }
        return point
    }
}
