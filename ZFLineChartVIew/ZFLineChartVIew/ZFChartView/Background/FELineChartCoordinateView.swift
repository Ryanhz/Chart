//
//  ZFLineChartCoordinateView.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/8/15.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

struct FELineCoordinateAxis {
    var color: UIColor = UIColor.white
    var width: CGFloat = 1
}

/// x y轴
class FELineChartCoordinateView: UIView {
    
    weak var lineChartView: FELineChartView!
    var y_axis: [Int]!
    
    var labelHeight: CGFloat = 22
    var y_labelWidth: CGFloat = 35
    
   convenience init(lineChartView: FELineChartView) {
        self.init()
        self.lineChartView = lineChartView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        createLabelY()
        createLabelX()
    }
 
    func createLabelY(){
        let yLabelNumber = lineChartView.dataSource?.feLineChartViewNumberOfTitleInYAxis(view: lineChartView) ?? 0
        
        for index in 0..<yLabelNumber {
            let title = lineChartView.dataSource!.feLineChartView(lineChartView, contentTextForYAxisLabel: index)
            
            let y = lineChartView.charLineContentView_height/CGFloat(yLabelNumber-1) * CGFloat(index) + lineChartView.lineMargin_top - labelHeight/2
            
            let y_Label = UILabel()
            
            y_Label.frame = CGRect(x: 0, y: y, width: y_labelWidth, height: labelHeight)
            y_Label.text = title
            y_Label.textAlignment = .right
            y_Label.textColor = UIColor.white
            y_Label.font = UIFont.systemFont(ofSize: 10)
            self.addSubview(y_Label)
        }
    }
    
    func createLabelX(){
        let xLabelNumber = lineChartView.dataSource?.feLineChartViewNumberOfTitleInXAxis(view: lineChartView) ?? 0
        
        for index in 0..<xLabelNumber {
            let title = lineChartView.dataSource!.feLineChartView(lineChartView, contentTextForXAxisLabel: index)
            
            let x = lineChartView.charLineContentView_Width/CGFloat(xLabelNumber - 1) * CGFloat(index) + lineChartView.lineMargin_left - y_labelWidth/2
            
            let x_Label = UILabel()
            x_Label.textColor = UIColor.white
            x_Label.frame = CGRect(x: x, y: self.frame.size.height - lineChartView.lineMargin_bottom + lineChartView.lineMargin_bottom*0.3, width: y_labelWidth, height: labelHeight)
            x_Label.centerY = self.frame.size.height - lineChartView.lineMargin_bottom/2
            x_Label.text = title
            x_Label.textAlignment = .center
            x_Label.font = UIFont.systemFont(ofSize: 10)
            self.addSubview(x_Label)
        }
    }
}



