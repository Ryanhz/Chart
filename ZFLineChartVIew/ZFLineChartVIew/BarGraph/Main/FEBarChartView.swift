//
//  FEBarChartView.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/9/28.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

@objc protocol FEBarChartViewDataSource: class {
    
    func barChartView(_ view: FEBarChartView)->[FEBarChartPoint]
    
    func barChartViewNumberOfTitleInXAxis(_ view: FEBarChartView)-> Int
    
    @objc optional func barChartView(_ view: FEBarChartView, titleLoactionAtXAxis index: Int)-> CGFloat

    func barChartView(_ view: FEBarChartView, contentTextForXAxisLabel index: Int) ->String
    
//    func barChartViewNumberReferenceLineInYAxis(view: FEBarChartView)->Int
//
//    func barChartView(_ lineChartView: FEBarChartView, referenceLineInYAxis index: Int) ->FELineChartReferenceLine
}

class FEBarChartView: UIView {
    
    enum BarStyle {
        case bar, areaBar
    }
    
    var points: [FEBarChartPoint] = [FEBarChartPoint]()
    var titleLabel: UILabel!
    private(set) var backgroundView: FEBarChartBackgroundView!
    private(set) var coordinateView: FEBarChartCoordinateView!
    private(set) var coordinateTitlesView: FEBarChartCoordinateTitlesView!
    private(set) var referenceLineView: FEBarChartReferenceLineView!
    private(set) var barView: FEBarChartBarView!
    
    var calculator: FEBarChartCalculator!
    
    weak var dataSource: FEBarChartViewDataSource?
    
    var style: BarStyle = .bar
    
    var chartMargin_bottom: CGFloat = 30
    var chartMargin_top: CGFloat = 60
    var chartMargin_left: CGFloat = 32
    var chartMargin_right: CGFloat = 32
    
    var chartContentView_height: CGFloat {
        return self.height - chartMargin_bottom - chartMargin_top
    }
    
    var chartContentView_Width: CGFloat {
        return self.width - chartMargin_left - chartMargin_right
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        calculator = FEBarChartCalculator()
        backgroundView = FEBarChartBackgroundView()
        backgroundView.backgroundColor = UIColor(rgb: 0x359dff)
        coordinateView = FEBarChartCoordinateView(parentView: self)
        coordinateTitlesView = FEBarChartCoordinateTitlesView(parentView: self)
        referenceLineView = FEBarChartReferenceLineView(parentView: self)
        barView = FEBarChartBarView()

        addSubview(backgroundView)
        addSubview(coordinateView)
        addSubview(coordinateTitlesView)
        addSubview(referenceLineView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = self.bounds
        coordinateView.frame = self.bounds
        coordinateTitlesView.frame = self.bounds
        referenceLineView.frame = self.bounds
        barView.frame = CGRect(x: chartMargin_left, y: chartMargin_top, width: chartContentView_Width, height: chartContentView_height)
    }
    
    func updataGraph(){
        calculator.drawableAreaHeight = self.chartContentView_height
        calculator.drawableAreaWidth = self.chartContentView_Width
        calculator.parentView = self
        points = dataSource?.barChartView(self) ?? [FEBarChartPoint]()
        calculator.recaclculatePointsCoordinate()
        
        if barView != nil {
            barView.removeFromSuperview()
        }
        barView = FEBarChartBarView(parentView: self)
        barView.delegate = referenceLineView
        barView.backgroundColor = UIColor.clear
        barView.frame = CGRect(x: chartMargin_left, y: chartMargin_top, width: chartContentView_Width, height: chartContentView_height)
        barView.points = self.points
        self.addSubview(barView)
        barView.setNeedsDisplay()
    }
}
