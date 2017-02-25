//
//  MGTabBarController.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class MGTabBarController: UITabBarController {

    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarAppear = UITabBarItem.appearance()
        tabBarAppear.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: UIControlState.selected)
        
        setUpAllChildViewControllers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - setUpAllChildViewControllers
    fileprivate func setUpAllChildViewControllers () {
        let normalImages = ["btn_home_normal","btn_live_normal","btn_column_normal","btn_user_normal"]
        let selectedImages = ["btn_home_selected","btn_live_selected","btn_column_selected","btn_user_selected"]
        //        self.tabBar.barTintColor = UIColor(red: 39/255.0, green: 39/255.0, blue: 40/255.0, alpha: 1)
        //        self.edgesForExtendedLayout = UIRectEdge.None;
        //        self.tabBar.translucent = false;
        
        let newsVC = HomeViewController()
        setUpNavRootViewCOntrollers(vc: newsVC, title: "首页", imageName: normalImages[0], selImage: selectedImages[0])
        
        let circleVC = LiveViewController()
        setUpNavRootViewCOntrollers(vc: circleVC, title: "直播", imageName: normalImages[1], selImage: selectedImages[1])
        
        let garageVC = UIViewController()
        setUpNavRootViewCOntrollers(vc: garageVC, title: "关注", imageName: normalImages[2], selImage: selectedImages[2])
        
        let profileVC = ProfileViewController()
        setUpNavRootViewCOntrollers(vc: profileVC, title: "我的", imageName: normalImages[3], selImage: selectedImages[3])
    }
    
    
    fileprivate func setUpNavRootViewCOntrollers(vc: UIViewController, title:String, imageName: String, selImage: String) {
        vc.title = title
//        vc.view.backgroundColor = UIColor.randomColor()
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: selImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.addChildViewController(MGNavController(rootViewController: vc))
    }

}
