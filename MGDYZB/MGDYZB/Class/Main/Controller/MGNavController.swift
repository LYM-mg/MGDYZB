//
//  MGNavController.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MGNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取target/action
        // 2.1.利用运行时机制查看所有的属性名称
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        // 0.设置导航栏的颜色
        setUpNavAppearance ()
        
        // 1.创建Pan手势
        let target = navigationController?.interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: Selector("handleNavigationTransition:"))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        
        // 2.禁止系统的局部返回手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - 拦截Push操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 这里判断是否进入push视图
        if (self.childViewControllers.count > 0) {
            //            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            [btn setTitle:"返回" forState:UIControlStateNormal];
            //            [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
            //            [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
            //            btn.size = CGSizeMake(70, 30);
            //            [btn setTitleColor:BSColor(2, 2, 2) forState:UIControlStateNormal];
            //            [btn setTitleColor:BSColor(255, 60, 48) forState:UIControlStateHighlighted];
            //            // 设置按钮内容左对齐
            //            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            //            // 内边距
            //            btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            //            [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            //            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            // 隐藏要push的控制器的tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
         super.pushViewController(viewController, animated: animated)
    }
}


extension MGNavController : UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        ///判断是否是根控制器
        if self.childViewControllers.count == 1
        {
            return false
        }  
        return true
    }
}


extension MGNavController  {
    fileprivate func setUpNavAppearance () {
        let navBar = UINavigationBar.appearance()
        if(Double(UIDevice.current.systemVersion)) > 8.0 {
            navBar.isTranslucent = true
        } else {
            self.navigationBar.isTranslucent  = true
        }
        navBar.barTintColor = UIColor.orange
        navBar.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.00)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 18)]
    }
}

