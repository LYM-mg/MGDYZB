//
//  ColorExtesion.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class ColorExtesion: UIColor {
    
}

struct CustomColor {
    // 颜色的三原色，都是Double类型
    let red, green, blue: Double;
    // 使用下划线`_`来显示描述外部参数名
    init(_ red:Double,_ green:Double,_ blue:Double) {
        self.red = red;
        self.green = green;
        self.blue = blue;
    }
}

extension UIColor {
    static func randomInt(min: UInt32, _ max: UInt32) -> Int {
        return Int(arc4random_uniform(max - min + 1) + min)
    }
    
    static func randomColor() -> UIColor {
        let r = CGFloat(randomInt(0, 255)) / 255.0
        let g = CGFloat(randomInt(0, 255)) / 255.0
        let b = CGFloat(randomInt(0, 255)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    static func RGBColor(red red:CGFloat,green:CGFloat,blue:CGFloat) -> UIColor {
        let r = (red) / 255.0
        let g = (green) / 255.0
        let b = (blue) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    static func KNormalColorForPageTitle() -> UIColor {
        let r = CGFloat(85) / 255.0
        let g = CGFloat(85) / 255.0
        let b = CGFloat(85) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    static func KSelectedColorForPageTitle() -> UIColor {
        let r = CGFloat(255) / 255.0
        let g = CGFloat(128) / 255.0
        let b = CGFloat(0) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }

}


