//
//  FELineChartDefine.swift
//  LineGraph
//
//  Created by hzf on 2017/7/14.
//  Copyright © 2017年 hzf. All rights reserved.
//

import UIKit

enum FELineChartAnimationStyle {
    case drawing
    case alpha
    case rise
    case spring
    case none
}

enum FELineChartLineStyle {
    case straight
    case bezierWave
    case bezierTaper
    case none
}

@objc  protocol FELineChartViewDelegate: class {
    func horizontalPointsSpacing( chartView: FELineChartView) -> CGFloat
}
