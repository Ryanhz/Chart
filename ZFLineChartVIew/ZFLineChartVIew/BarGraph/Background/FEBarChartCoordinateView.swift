//
//  FEBarChartCoordinateView.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/9/28.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

class FEBarChartCoordinateView: UIView {
    
    weak var barChartView: FEBarChartView!
    var x_axisLayer: CAShapeLayer!
    var top_axisLayer: CAShapeLayer!
    
    var x_axisMargin_left: CGFloat = 10
    var x_axisMargin_right: CGFloat = 10
    
    convenience init(parentView: FEBarChartView) {
        self.init()
        self.barChartView = parentView
        
        x_axisLayer =  {
            let shapLayer = CAShapeLayer()
            shapLayer.strokeColor = UIColor.white.cgColor
            shapLayer.fillColor = UIColor.clear.cgColor
            shapLayer.lineWidth = 1
            return shapLayer
        }()
        
       self.layer.addSublayer(x_axisLayer)
        top_axisLayer =  {
            let shapLayer = CAShapeLayer()
            shapLayer.strokeColor = UIColor.white.cgColor
            shapLayer.fillColor = UIColor.clear.cgColor
            shapLayer.lineWidth = 1
            return shapLayer
        }()
        self.layer.addSublayer(top_axisLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawXPath()
        drawTopXPath()
    }
    
    func drawTopXPath(){
        let path: UIBezierPath =  {
            let path = UIBezierPath()
            path.lineWidth = 1
            let starPoint = CGPoint(x: x_axisMargin_left, y: barChartView.chartMargin_top - 5)
            let endPoint = CGPoint(x: self.width-x_axisMargin_right, y: barChartView.chartMargin_top - 5)
            path.move(to: starPoint)
            path.addLine(to: endPoint)
            return path
        }()
        top_axisLayer.path = path.cgPath
    }
    
    func drawXPath(){
        let path: UIBezierPath = {
            let path =  UIBezierPath()
            path.lineWidth = 1
            let starPoint = CGPoint(x: x_axisMargin_left, y: self.height - barChartView.chartMargin_bottom + 5)
            let endPoint = CGPoint(x: self.width-x_axisMargin_right, y: self.height - barChartView.chartMargin_bottom + 5)
            path.move(to: starPoint)
            path.addLine(to: endPoint)
            return path
        }()
        x_axisLayer.path = path.cgPath
    }
}
