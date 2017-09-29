//
//  UIView+Rect.swift
//  TableClient
//
//  Created by hzf on 16/9/26.
//  Copyright © 2016年 hzf. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// viewOrigin
    var viewOrigin : CGPoint {
        
        get { return frame.origin}
        
        set(newVal) {
            
            var tmpFrame    = frame
            tmpFrame.origin = newVal
            frame           = tmpFrame
        }
    }
    
    /// viewSize
    var viewSize : CGSize {
        
        get{ return frame.size}
        
        set(newVal) {
            
            var tmpFrame  = frame
            tmpFrame.size = newVal
            frame         = tmpFrame
        }
    }
    
    /// x
    var x : CGFloat {
        
        get { return frame.origin.x}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal
            frame             = tmpFrame
        }
    }
    
    /// y
    var y : CGFloat {
        
        get { return frame.origin.y}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal
            frame             = tmpFrame
        }
    }
    
    /// height
    var height : CGFloat {
        
        get { return frame.size.height}
        
        set(newVal) {
            
            var tmpFrame         = frame
            tmpFrame.size.height = newVal
            frame                = tmpFrame
        }
    }
    
    /// width
    var width : CGFloat {
        
        get { return frame.size.width}
        
        set(newVal) {
            
            var tmpFrame        = frame
            tmpFrame.size.width = newVal
            frame               = tmpFrame
        }
    }
    
    /// left
    var left : CGFloat {
        
        get { return frame.origin.x}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal
            frame             = tmpFrame
        }
    }
    
    /// right
    var right : CGFloat {
        
        get { return frame.origin.x + frame.size.width}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal - frame.size.width
            frame             = tmpFrame
        }
    }
    
    /// top
    var top : CGFloat {
        
        get { return frame.origin.y}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal
            frame = tmpFrame
        }
    }
    
    /// bottom
    var bottom : CGFloat {
        
        get { return frame.origin.y + frame.size.height}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal - frame.size.height
            frame             = tmpFrame
        }
    }
    
    /// centerX
    var centerX : CGFloat {
        
        get { return center.x}
        set(newVal) { center = CGPoint(x: newVal, y: center.y)}
    }
    
    /// centerY
    var centerY : CGFloat {
        
        get { return center.y}
        set(newVal) { center = CGPoint(x: center.x, y: newVal)}
    }
    
    /// middleX
    var middleX : CGFloat {
        
        get { return bounds.width / 2}
    }
    
    /// middleY
    var middleY : CGFloat {
        
        get { return bounds.height / 2}
    }
    
    /// middlePoint
    var middlePoint : CGPoint {
        
        get { return CGPoint(x: bounds.width / 2, y: bounds.height / 2)}
    }
}



extension UIView {
    
    /// viewOrigin
    var fe_viewOrigin : CGPoint {
        
        get { return frame.origin}
        
        set(newVal) {
            
            var tmpFrame    = frame
            tmpFrame.origin = newVal
            frame           = tmpFrame
        }
    }
    
    /// viewSize
    var fe_viewSize : CGSize {
        
        get{ return frame.size}
        
        set(newVal) {
            
            var tmpFrame  = frame
            tmpFrame.size = newVal
            frame         = tmpFrame
        }
    }
    
    /// x
    var fe_x : CGFloat {
        
        get { return frame.origin.x}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal
            frame             = tmpFrame
        }
    }
    
    /// y
    var fe_y : CGFloat {
        
        get { return frame.origin.y}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal
            frame             = tmpFrame
        }
    }
    
    /// height
    var fe_height : CGFloat {
        
        get { return frame.size.height}
        
        set(newVal) {
            
            var tmpFrame         = frame
            tmpFrame.size.height = newVal
            frame                = tmpFrame
        }
    }
    
    /// width
    var fe_width : CGFloat {
        
        get { return frame.size.width}
        
        set(newVal) {
            
            var tmpFrame        = frame
            tmpFrame.size.width = newVal
            frame               = tmpFrame
        }
    }
    
    /// left
    var fe_left : CGFloat {
        
        get { return frame.origin.x}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal
            frame             = tmpFrame
        }
    }
    
    /// right
    var fe_right : CGFloat {
        
        get { return frame.origin.x + frame.size.width}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal - frame.size.width
            frame             = tmpFrame
        }
    }
    
    /// top
    var fe_top : CGFloat {
        
        get { return frame.origin.y}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal
            frame = tmpFrame
        }
    }
    
    /// bottom
    var fe_bottom : CGFloat {
        
        get { return frame.origin.y + frame.size.height}
        
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal - frame.size.height
            frame             = tmpFrame
        }
    }
    
    /// centerX
    var fe_centerX : CGFloat {
        
        get { return center.x}
        set(newVal) { center = CGPoint(x: newVal, y: center.y)}
    }
    
    /// centerY
    var fe_centerY : CGFloat {
        
        get { return center.y}
        set(newVal) { center = CGPoint(x: center.x, y: newVal)}
    }
    
    /// middleX
    var fe_middleX : CGFloat {
        
        get { return bounds.width / 2}
    }
    
    /// middleY
    var fe_middleY : CGFloat {
        
        get { return bounds.height / 2}
    }
    
    /// middlePoint
    var fe_middlePoint : CGPoint {
        
        get { return CGPoint(x: bounds.width / 2, y: bounds.height / 2)}
    }
}





