//
//  UIBUtton+Extension.swift
//  chart2
//
//  Created by i-Techsys.com on 16/12/7.
//  Copyright © 2016年 i-Techsys. All rights reserved.
//

import UIKit

extension UIButton {
    /// 遍历构造函数
    convenience init(imageName:String, bgImageName:String){
        self.init()
        
        // 1.设置按钮的属性
        // 1.1图片
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        // 1.2背景
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        
        // 2.设置尺寸
        sizeToFit()
    }
    
    convenience init(imageName:String, target:AnyObject, action:Selector) {
        self.init()
        // 1.设置按钮的属性
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        sizeToFit()
        
        // 2.监听
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(image:UIImage?,highlightedImage: UIImage?,title: String?, target:AnyObject, action:Selector) {
        self.init(title: title ?? "", target: target, action: action)
        // 1.设置按钮的属性
        setImage(image, for: .normal)
        if highlightedImage != nil {
            setImage(highlightedImage, for: .selected)
        }
//        showsTouchWhenHighlighted = true
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        sizeToFit()
        
        // 2.监听
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(title:String, target:AnyObject, action:Selector) {
        self.init()
        setTitle(title, for: UIControl.State.normal)
        sizeToFit()
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(imageName:String, title: String, target:AnyObject, action:Selector) {
        self.init()
        
        // 1.设置按钮的属性
        setImage(UIImage(named: imageName), for: .normal)
//        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setTitle(title, for: UIControl.State.normal)
        showsTouchWhenHighlighted = true
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        sizeToFit()
        
        // 2.监听
        addTarget(target, action: action, for: .touchUpInside)
    }

    convenience init(image: UIImage, title: String, target:AnyObject, action:Selector) {
        self.init()
        
        // 1.设置按钮的属性
        setImage(image, for: .normal)
        //        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setTitle(title, for: UIControl.State.normal)
        showsTouchWhenHighlighted = true
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        sizeToFit()
        
        // 2.监听
        addTarget(target, action: action, for: .touchUpInside)
    }
}
