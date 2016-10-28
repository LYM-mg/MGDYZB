//
//  AppDelegate.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit
import pop

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var bgView: UIView = {
        let bgView = UIView(frame: UIScreen.mainScreen().bounds)
        bgView.backgroundColor = UIColor.blackColor()
        return bgView
    }()
    private lazy var scrollView: GuardScrollView = {
        let scrollView = GuardScrollView(frame: UIScreen.mainScreen().bounds)
        scrollView.backgroundColor = UIColor.whiteColor()
        return scrollView
    }()
    private lazy var tabBarVC:MGTabBarController = MGTabBarController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSThread.sleepForTimeInterval(1.0) //延迟启动程序
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = tabBarVC;
        window!.makeKeyAndVisible()
        
        
        let isfirst = SaveTools.KGetLocalData("isFirstOpen") as? String
        
        if (isfirst?.isEmpty == nil) {
            UIApplication.sharedApplication().statusBarHidden = true
            showAppGurdView()
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("EnterHomeView:"), name: KEnterHomeViewNotification, object: nil)
        // 点击状态栏滚动到顶部
        dispatch_after(1, dispatch_get_main_queue()) { () -> Void in
            MGScrollTopWindow.shareInstance.show()
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    private func showAppGurdView() {
        self.window!.addSubview(bgView)
        bgView.addSubview(scrollView)
    }
    
    func EnterHomeView(noti: NSNotification) {
        
        let dict = noti.userInfo as! [String : AnyObject]
        let btn = dict["sender"]
        SaveTools.kSaveLocal("false", key: "isFirstOpen")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(UInt64(3.5) * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            let showMenuAnimation = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
            showMenuAnimation.toValue = (0.0)
            showMenuAnimation.springBounciness = 10.0
            btn!.pop_addAnimation(showMenuAnimation,forKey:"hideBtn")
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.bgView.layer.transform = CATransform3DMakeScale(2, 2, 2)
                self.bgView.alpha = 0
            },completion: { (completion) -> Void in
                UIApplication.sharedApplication().statusBarHidden = false
                self.bgView.removeFromSuperview()
                    
            })
        })
    }
    
}

