//
//  FEBarChartCoordinateTitlesView.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/9/28.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

class FEBarChartCoordinateTitlesView: UIView {

    weak var barChartView: FEBarChartView!
    var labelHeight: CGFloat = 22
    var labelWidth: CGFloat = 35
    
    convenience init(parentView: FEBarChartView) {
        self.init()
        self.barChartView = parentView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        createLabelX()
    }
    
    func createLabelX(){
        
        guard let xLabelNumber = barChartView.dataSource?.barChartViewNumberOfTitleInXAxis(barChartView), xLabelNumber > 0 else {
            return
        }
        
        for index in 0..<xLabelNumber {
            let title = barChartView.dataSource!.barChartView(barChartView, contentTextForXAxisLabel: index)
            var x: CGFloat = 0
            if let loaction = barChartView.dataSource!.barChartView?(barChartView, titleLoactionAtXAxis: index) {
                x = loaction * barChartView.chartContentView_Width + barChartView.chartMargin_left - labelWidth/2
            } else {
                x = barChartView.chartContentView_Width * CGFloat(index)/CGFloat(xLabelNumber - 1)  + barChartView.chartMargin_left - labelWidth/2
            }
            
            let x_Label = UILabel()
            x_Label.textColor = UIColor.white
            x_Label.frame = CGRect(x: x, y: self.frame.size.height - barChartView.chartMargin_bottom + barChartView.chartMargin_bottom*0.3, width: labelWidth, height: labelHeight)
            x_Label.centerY = self.frame.size.height - barChartView.chartMargin_bottom/2
            x_Label.text = title
            x_Label.textAlignment = .center
            x_Label.font = UIFont.systemFont(ofSize: 10)
            addSubview(x_Label)
        }
    }

}
