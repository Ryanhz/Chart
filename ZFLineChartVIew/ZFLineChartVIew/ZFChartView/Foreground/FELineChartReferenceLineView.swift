//
//  FELineChartReferenceLineView.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/8/16.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

struct FELineChartReferenceLine {
    var location: Float
    var color: UIColor
    var lineWidth: CGFloat
}

class FELineChartReferenceLineView: UIView {

    weak var lineChartView: FELineChartView!
    
    
    var drawRect: CGRect = CGRect.zero

    convenience init(lineChartView: FELineChartView) {
        self.init()
        self.lineChartView = lineChartView
        drawRect = CGRect(x: lineChartView.lineMargin_left, y: lineChartView.lineMargin_top, width: lineChartView.charLineContentView_Width, height: lineChartView.charLineContentView_height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let  subLayers = self.layer.sublayers{
            for subLayer in subLayers  {
                subLayer.removeFromSuperlayer()
            }
        }
        setLineDashX()
        setLineDashY()
    }
    
    /// 绘制y轴上的虚线
    func setLineDashY(){
        
        let dashYNumber = lineChartView.dataSource?.feLineChartViewNumberReferenceLineInYAxis(view: lineChartView) ?? 0
        
        for index in 0..<dashYNumber {
            let refline = lineChartView.dataSource!.feLineChartView(lineChartView, referenceLineInYAxis: index)
            
            let dashLayer = CAShapeLayer()
            dashLayer.strokeColor = refline.color.cgColor
            dashLayer.fillColor = UIColor.clear.cgColor
            dashLayer.lineWidth = refline.lineWidth
            
            let value_height = lineChartView.charLineContentView_height * CGFloat(refline.location)
            
            let point_y =  self.height - lineChartView.lineMargin_bottom - value_height
            let path = UIBezierPath()
            path.lineWidth = 1
            let starPoint = CGPoint(x: drawRect.origin.x, y: point_y)
            let endPoint = CGPoint(x: self.width, y: point_y)
            path.move(to: starPoint)
            path.addLine(to: endPoint)
            dashLayer.path = path.cgPath
            self.layer.addSublayer(dashLayer)
        }
    }
    
    /// 绘制x轴上的虚线
    func setLineDashX(){
        
        let dashXNumber = lineChartView.dataSource?.feLineChartViewNumberReferenceLineInXAxis(view: lineChartView) ?? 0
        
        for index in 0..<dashXNumber {
            let refline = lineChartView.dataSource!.feLineChartView(lineChartView, referenceLineInXAxis: index)
            
            let dashLayer = CAShapeLayer()
            dashLayer.strokeColor = refline.color.cgColor
            dashLayer.fillColor = UIColor.clear.cgColor
            dashLayer.lineWidth = refline.lineWidth
            
            let value_Height = lineChartView.charLineContentView_Width * CGFloat(refline.location)
            
            let point_x = lineChartView.lineMargin_left + value_Height
            let path = UIBezierPath()
            path.lineWidth = 1
            let starPoint = CGPoint(x: point_x, y: drawRect.origin.y)
            let endPoint = CGPoint(x: point_x, y: drawRect.origin.y+drawRect.size.height)
            path.move(to: starPoint)
            path.addLine(to: endPoint)
            dashLayer.path = path.cgPath
            self.layer.addSublayer(dashLayer)
        }
    }
    
}
