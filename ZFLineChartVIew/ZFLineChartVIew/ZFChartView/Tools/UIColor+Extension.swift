//
//  UIColor+Extension.swift
//  TableContractManage
//
//  Created by 马瑜 on 16/9/26.
//  Copyright © 2016年 MY. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        var colorString: String!
        
        if hexString.hasPrefix("#") {
            let index = hexString.characters.index(hexString.startIndex, offsetBy: 1)
            
            colorString = hexString.substring(from: index)
        } else {
            colorString = hexString
        }
        
        colorString = colorString.uppercased()
        
        let alphaString = (colorString as NSString).substring(to: 2)
        let redString = ((colorString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let greenString = ((colorString as NSString).substring(from: 4) as NSString).substring(to: 2)
        let blueString = ((colorString as NSString).substring(from: 6) as NSString).substring(to: 2)
        
        var red: UInt32 = 0x0, green: UInt32 = 0x0, blue: UInt32 = 0x0, alpha: UInt32 = 0x0
        
        Scanner(string: alphaString).scanHexInt32(&alpha)
        Scanner(string: redString).scanHexInt32(&red)
        Scanner(string: greenString).scanHexInt32(&green)
        Scanner(string: blueString).scanHexInt32(&blue)
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
    
    // MARK: -<##>
    convenience init(rgb: UInt) {
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255
        let blue = CGFloat((rgb & 0xFF)) / 255
    
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    convenience init(rgba: UInt) {
        let alpha     = CGFloat((rgba & 0xFF000000) >> 24) / 255
        let red   = CGFloat((rgba & 0xFF0000) >> 16) / 255
        let green    = CGFloat((rgba & 0xFF00) >> 8) / 255
        let blue   = CGFloat((rgba & 0xFF)) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func randomColor() ->Self{
        
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        return self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    
}
