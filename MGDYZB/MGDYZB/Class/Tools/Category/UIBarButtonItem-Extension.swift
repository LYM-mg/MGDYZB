//
//  UIBarButtonItem-Extension.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /**
      推荐使用： 类方法创建UIBarButtonItem
    
    - parameter imageName:     图片名称
    - parameter highImageName: 高亮时的图片名称（默认为""）
    - parameter size:          按钮的尺寸（默认为"CGSizeZero"）
    
    - returns: UIBarButtonItem
    */
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSizeZero)  {
        // 1.创建UIButton
        let btn = UIButton()
        
        // 2.设置btn的图片
        btn.setImage(UIImage(named: imageName), forState: UIControlState())
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSizeZero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        // 4.创建UIBarButtonItem
        self.init(customView : btn)
    }
    
    /**
      不推荐使用： 类方法创建UIBarButtonItem
    
    - parameter imageName:     图片名称
    - parameter highImageName: 高亮时的图片名称
    - parameter size:          按钮的尺寸
    
    - returns: UIBarButtonItem
    */
    class func createItem(imageName : String, highImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highImageName), forState: .Highlighted)
        
        btn.frame = CGRect(origin: CGPointZero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
    
}

