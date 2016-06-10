//
//  MGNavigationController.swift
//  MGHuaTian
//
//  Created by ming on 16/6/10.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class MGNavigationController: UINavigationController {

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            // push的时候, 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            // 添加返回按钮
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .Done, target: self, action: Selector("back"))
        }
        super.pushViewController(viewController, animated: true)
        
    }
    
    func back() {
        popViewControllerAnimated(true)
    }
}
