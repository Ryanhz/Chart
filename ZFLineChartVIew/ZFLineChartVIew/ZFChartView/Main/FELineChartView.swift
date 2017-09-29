//
//  FELineGraphView.swift
//  LineGraph
//
//  Created by hzf on 2017/7/14.
//  Copyright © 2017年 hzf. All rights reserved.
//
import UIKit

//UITableViewDataSource


/*
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

*/
protocol FELineChartViewDataSource: class {
    
    func feLineChartView(_ lineChartView: FELineChartView)->[FELineChartPoint]
    
    
    func feLineChartViewNumberOfTitleInYAxis(view: FELineChartView)->Int
    
    func feLineChartViewNumberOfTitleInXAxis(view: FELineChartView)->Int
    
    func feLineChartView(_ lineChartView: FELineChartView, contentTextForYAxisLabel index: Int) ->String
    
    func feLineChartView(_ lineChartView: FELineChartView, contentTextForXAxisLabel index: Int) ->String
    
    func feLineChartViewNumberReferenceLineInYAxis(view: FELineChartView)->Int
    
    func feLineChartViewNumberReferenceLineInXAxis(view: FELineChartView)->Int
    
    func feLineChartView(_ lineChartView: FELineChartView, referenceLineInYAxis index: Int) ->FELineChartReferenceLine
    
    func feLineChartView(_ lineChartView: FELineChartView, referenceLineInXAxis index: Int) ->FELineChartReferenceLine
}

class FELineChartView: UIView {
    
    var lineMargin_bottom: CGFloat = 40
    var lineMargin_top: CGFloat = 25
    var lineMargin_left: CGFloat = 45
    var lineMargin_right: CGFloat = 25
    
    var charLineContentView_height: CGFloat {
        return self.height - lineMargin_bottom - lineMargin_top
    }
    
    var charLineContentView_Width: CGFloat {
        return self.width - lineMargin_left - lineMargin_right
    }
    
    var points: [FELineChartPoint] = [FELineChartPoint]()
    
    
    let calculator: FELineChartCalculator = FELineChartCalculator()
    
    var backgroundView: FELineChartBackgroundView!
    var coordinateView: FELineChartCoordinateView!
    var referenceLineView: FELineChartReferenceLineView!
    var charLineContentView: UIView!

    var line: FELineChartLineView!
    
    weak var dataSource: FELineChartViewDataSource?
    
    func updataGraph(){

        calculator.drawableAreaHeight = self.charLineContentView_height
        calculator.drawableAreaWidth = self.charLineContentView_Width
        calculator.parentView = self
        
        points = dataSource?.feLineChartView(self) ?? [FELineChartPoint]()
        
        calculator.recaclculatePointsCoordinate()
        if line != nil {
            line.removeFromSuperview()
        }
        
        self.layoutIfNeeded()
        line = FELineChartLineView()
        line.backgroundColor = UIColor.clear
        line.frame = charLineContentView.bounds
        line.parentView = self
        line.delegate = self
        self.charLineContentView.addSubview(line)
        line.points = self.points
        line.setNeedsDisplay()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundView = FELineChartBackgroundView()
        
        coordinateView = FELineChartCoordinateView(lineChartView: self)
       
        referenceLineView = FELineChartReferenceLineView(lineChartView: self)
        
        charLineContentView = UIView()
        
        charLineContentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        self.addSubview(backgroundView)
        self.addSubview(coordinateView)
        self.addSubview(referenceLineView)
        self.addSubview(charLineContentView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = self.bounds
        coordinateView.frame = self.bounds
        referenceLineView.frame = self.bounds
        charLineContentView.frame = CGRect(x: lineMargin_left, y: lineMargin_top, width: charLineContentView_Width, height: charLineContentView_height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func transfromsPointWith(_ point: CGPoint)->CGPoint{
        let transfromsPoint = CGPoint(x: point.x/24*charLineContentView_Width, y: (1-point.y/500)*charLineContentView_height)
        return transfromsPoint
    }
}

extension FELineChartView: FELineChartLineViewDelegate{
    
    func lineView(_ lineView: FELineChartLineView, didBeganTouchAt point: CGPoint, belongToSegmentOf originalPoint: FELineChartPoint) {
        
    }
    
    func lineView(_ lineView: FELineChartLineView, didmovedTouchTo point: CGPoint, belongToSegmentOf originalPoint: FELineChartPoint) {
        print("point:\(point), originalPoint: \(calculator.valueReferToVertical(point.y))")
    }
    
    func lineView(_ lineView: FELineChartLineView, didEndedTouchAt point: CGPoint, belongToSegmentOf originalPoint: FELineChartPoint) {
        
    }
}

