//
//  FEBarChartReferenceLineView.swift
//  ZFLineChartVIew
//
//  Created by hzf on 2017/9/28.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

class FEBarChartReferenceLineView: UIView {

    var label: UILabel!
    var titleLabel: UILabel!
    var dashLayer: CAShapeLayer!
    weak var parentView: FEBarChartView!
    convenience init(parentView: FEBarChartView) {
        self.init()
        self.parentView = parentView
        self.backgroundColor = UIColor.clear
        setupSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.y = parentView.chartMargin_top - label.height - 10
        titleLabel.frame = CGRect(x: 0, y: 10, width: self.width, height: 20)
    }
    
    func setLocation(_ point: CGPoint){
        label.centerX = parentView.chartMargin_left + point.x
        let endPointy = parentView.chartMargin_top + point.y
        let path = UIBezierPath()
        path.lineWidth = 1
        let starPoint = CGPoint(x: label.centerX, y: label.bottom)
        let endPoint = CGPoint(x: label.centerX, y: endPointy)
        path.move(to: starPoint)
        path.addLine(to: endPoint)
        dashLayer.path = path.cgPath
    }
    
    func setupSubviews(){
        label = {
            let label = UILabel()
            label.bounds = CGRect(x: 0, y: 0, width: 33, height: 12)
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.blue
            label.backgroundColor = UIColor.white
            label.layer.cornerRadius = 6
            label.layer.masksToBounds = true
            label.textAlignment = .center
            return label
        }()
        
        titleLabel = {
            let label = UILabel()
            label.textColor = UIColor.white
            label.text = "今天(预警次数)"
            label.font = UIFont.systemFont(ofSize: 10)
            label.textAlignment = .center
            return label
        }()
        
        dashLayer = CAShapeLayer()
        dashLayer.strokeColor = UIColor.white.cgColor
        dashLayer.fillColor = UIColor.clear.cgColor
        dashLayer.lineWidth = 1
        dashLayer.lineDashPattern = [0.5, 0.5]
        
        self.layer.addSublayer(dashLayer)
        self.addSubview(titleLabel)
        self.addSubview(label)
    }
}

extension FEBarChartReferenceLineView: FEBarChartBarViewDelegate {
    
    func barView(_ lineView: FEBarChartBarView, didBeganTouchAt point: CGPoint,  originalPoint: FEBarChartPoint) {
        label.text = "\(Int(originalPoint.value))"
        setLocation(point)
        print(originalPoint)
    }
    
    func barView(_ lineView: FEBarChartBarView, didmovedTouchTo point: CGPoint,  originalPoint: FEBarChartPoint) {
        label.text = "\(Int(originalPoint.value))"
        setLocation(point)
        print(originalPoint)
    }
    
    func barView(_ lineView: FEBarChartBarView, didEndedTouchAt point: CGPoint, originalPoint: FEBarChartPoint) {
        label.text = "\(Int(originalPoint.value))"
        setLocation(point)
        print(originalPoint)
    }
}
