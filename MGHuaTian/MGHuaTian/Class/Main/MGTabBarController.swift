//
//  MGTabBarController.swift
//  MGHuaTian
//
//  Created by ming on 16/6/10.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class MGTabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpMainView(){
        // 设置tabBar的tintColor
        tabBar.tintColor = UIColor.blackColor()
        // 一个简单的本地化...
        addViewController(MGHomeTableController(), title: NSLocalizedString("tab_theme", comment: ""))
        addViewController(MGMallsTableController(), title: NSLocalizedString("tab_malls", comment: ""))
        
        let profile = MGColumnistViewController()
        // 由于注册登录, 原则上应该登录成功后, 返回这个信息的
//        let author = Author(dict: ["id" : "4a3dab7f-1168-4a61-930c-f6bc0f989f32", "auth":"专家", "content":"定义自己的美好生活\n", "headImg":"http://m.htxq.net//UploadFiles/headimg/20160422164405309.jpg", "identity":"官方认证"])
//        profile.author = author
//        profile.isUser = true
        addViewController(profile, title: NSLocalizedString("tab_profile", comment: ""))
        
        // 设置UITabBarControllerDelegate
        delegate = self
        
        // 添加通知监听
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.logout), name: LoginoutNotify, object: nil)rning()
        // Dispose of any resources that can be recreated.
    }
    
    // 添加子控件
    private func addViewController(childController: UIViewController, title: String) {
        let nav = MGNavigationController(rootViewController: childController)
        addChildViewController(nav)
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: "tb_\(childViewControllers.count - 1)")
        childController.tabBarItem.selectedImage = UIImage(named: "tb_\(childViewControllers.count - 1)" + "_selected")
        // 设置tabBarItem的tag, 方便判断点击
        childController.tabBarItem.tag = childViewControllers.count-1
    }

}
