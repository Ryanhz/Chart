//
//  ViewController.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/8/15.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var y_axis: [Int]!
    var x_axis =  ["00:00", "06:00", "12:00", "18:00", "24:00"]
    var x_location = [0, 0.25, 0.5, 0.75, 1]
    var dashX: [Float] = [0.25, 0.5, 0.75, 1]
    
    var dashY: [Float] = [0.1, 0.3, 0.5, 0.7, 0.9]

    var barView2: FEBarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arr = stride(from: 0, through: 500, by: 50)
        y_axis = Array(arr).reversed()
        
        self.view.backgroundColor = UIColor.white
        
        let mframe = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 200)

        let chartView = FELineChartView(frame: mframe)
        chartView.backgroundColor = UIColor(rgb: 0x359dff)
        chartView.dataSource = self
        self.view.addSubview(chartView)
        
        chartView.updataGraph()
        
        let bframe = CGRect(x: 0, y: 250, width: self.view.frame.width, height: 150)
        let barView = FEBarChartView(frame: bframe)
        barView.dataSource = self

        view.addSubview(barView)
        barView.updataGraph()
        
        
        let bframe2 = CGRect(x: 0, y: 450, width: self.view.frame.width, height: 150)
        barView2 = FEBarChartView(frame: bframe2)
        barView2.style = .areaBar
        barView2.dataSource = self
        
        view.addSubview(barView2)
        barView2.updataGraph()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func moniData()->[CGFloat]{
        
        var data = [CGFloat]()
        for _ in 0...24 {
            
            let value = CGFloat(arc4random_uniform(500))
            data.append(value)
        }
        return data
    }
    
    func moniData2()->[CGFloat]{
        
        var data = [CGFloat]()
        for _ in 0...24 {
            
            let value = CGFloat(arc4random_uniform(100))
            data.append(value)
        }
        return data
    }

    func moniData3()->[CGFloat]{
        
        var data = [CGFloat]()
        for _ in 0...3 {
            
            let value = CGFloat(arc4random_uniform(100))
            data.append(value)
        }
        return data
    }
}

extension ViewController: FEBarChartViewDataSource {
    func barChartView(_ view: FEBarChartView)->[FEBarChartPoint] {
        
        if view == barView2 {
            return FEBarChartPoint.pointsWithValues(moniData3())
        }
        return FEBarChartPoint.pointsWithValues(moniData2())
    }
    
    func barChartViewNumberOfTitleInXAxis(_ view: FEBarChartView)-> Int {
        return x_axis.count
    }
    
    func barChartView(_ lineChartView: FEBarChartView, contentTextForXAxisLabel index: Int) ->String {
        return x_axis[index]
    }
    
    func barChartView(_ view: FEBarChartView, titleLoactionAtXAxis index: Int) -> CGFloat {
        return CGFloat(x_location[index])
    }
}

extension ViewController: FELineChartViewDataSource {
    
    func feLineChartView(_ lineChartView: FELineChartView)->[FELineChartPoint] {
        return FELineChartPoint.pointsWithValues(moniData())
    }
    
    func feLineChartViewNumberOfTitleInYAxis(view: FELineChartView)->Int {
        
        return y_axis.count
    }
    
    func feLineChartView(_ lineChartView: FELineChartView, contentTextForYAxisLabel index: Int) ->String {
        return "\(y_axis[index])"
    }
    
    func feLineChartViewNumberOfTitleInXAxis(view: FELineChartView)->Int {
        return x_axis.count
    }
    
    func feLineChartView(_ lineChartView: FELineChartView, contentTextForXAxisLabel index: Int) ->String {
        return x_axis[index]
    }

    func feLineChartViewNumberReferenceLineInYAxis(view: FELineChartView)->Int {
        return dashY.count
    }
    
    func feLineChartViewNumberReferenceLineInXAxis(view: FELineChartView)->Int {
        return dashX.count
    }
    
    func feLineChartView(_ lineChartView: FELineChartView, referenceLineInYAxis index: Int) ->FELineChartReferenceLine {
        
        if index == 1 {
            return FELineChartReferenceLine(location: dashY[index], color: UIColor.red, lineWidth: 1)
        }
        return FELineChartReferenceLine(location: dashY[index], color: UIColor.white.withAlphaComponent(0.6), lineWidth: 1)
    }
    
    func feLineChartView(_ lineChartView: FELineChartView, referenceLineInXAxis index: Int) ->FELineChartReferenceLine {
        
        return FELineChartReferenceLine(location: dashX[index], color: UIColor.white.withAlphaComponent(0.6), lineWidth: 1)
    }
}


