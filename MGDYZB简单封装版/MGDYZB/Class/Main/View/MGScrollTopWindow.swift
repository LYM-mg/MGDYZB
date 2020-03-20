//
//  MGScrollTopWindow.swift
//  MGDYZB
//
//  Created by ming on 16/10/27.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class MGScrollTopWindow: NSObject{
    static let shareInstance: MGScrollTopWindow = MGScrollTopWindow()
    static let scrollToWindow: UIButton = {
        let btn = UIButton(frame: UIApplication.shared.statusBarFrame)
        btn.backgroundColor = UIColor.clear
        btn.isHidden = true
        return btn
    }()
//    private lazy var btn: UIButton = { [weak self] in
//           let btn = UIButton(frame: UIApplication.sharedApplication().statusBarFrame)
//        btn.addTarget(self, action: Selector("scrollTopWindowclick"), forControlEvents: UIControl.Event.TouchUpInside)
//        btn.backgroundColor = UIColor.redColor()
//        self!.statusBarView().addSubview(btn)
//        btn.hidden = true;
//        return btn
//    }()
    
//    override class func initialize() {
//        let btn = UIButton(frame: UIApplication.sharedApplication().statusBarFrame)
//        btn.backgroundColor = UIColor.redColor()
//        btn.hidden = true
//        MGScrollTopWindow.scrollToWindow = btn
//    }
    
    override init() {
        super.init()
        statusBarView().insertSubview(MGScrollTopWindow.scrollToWindow, at: 200)
        MGScrollTopWindow.scrollToWindow.addTarget(self, action: #selector(MGScrollTopWindow.scrollTopWindowclick(_:)), for: UIControl.Event.touchUpInside)
    }
    
    deinit {
        print("MGScrollTopWindow--deinit")
    }
    
    @objc func scrollTopWindowclick(_ btn: UIButton) {
        NSLog("点击了最顶部...");
        if let window = UIApplication.shared.keyWindow {
            self.seekAllScrollViewInView(window)
        }
    }

}

// MARK: - statusBarView
extension MGScrollTopWindow {
    func statusBarView() -> UIView {
        var statusBar: UIView?
//        let data = NSData(bytes: [0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72], length: 9)
//        let key2 = NSString(data: data, encoding: NSASCIIStringEncoding) as! String
//        kCFStringEncodingGB_18030_2000
//        let enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingASCII)
//        let key3 = NSString(data: data, encoding: enc) as! String
//        let key4 = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
        let key = "statusBar"
        let object = UIApplication.shared
        
        if object.responds(to: NSSelectorFromString(key)) {
            statusBar = object.value(forKey: key) as? UIView
        }
        return statusBar!
    }
}

// MARK: - show AND hidden
extension MGScrollTopWindow {
    func show() {
       MGScrollTopWindow.scrollToWindow.isHidden = false
    }
    
    func hide() {
        MGScrollTopWindow.scrollToWindow.isHidden = true
    }
}

// MARK: - 点击
extension MGScrollTopWindow {
    @objc func scrollTopWindowclick() {
//        NSLog("点击了最顶部...");
        if let window = UIApplication.shared.keyWindow {
            self.seekAllScrollViewInView(window)
        }
    }
}

// MARK: - 寻找
extension MGScrollTopWindow {
    func seekAllScrollViewInView(_ view: UIView) {
        // 递归 这样就可以获得所有的View
        for subView in view.subviews {
            self.seekAllScrollViewInView(subView)
        }
        
        // 是否是ScrollView    不是，直接返回
//        print("The class is: \(view.classForCoder)") // NSClassFromString("UIScrollView")!
        guard view.isKind(of: UIScrollView.classForCoder()) else {
            return
        }
        
        let scrollView = view as! UIScrollView
        let isShowInWindow = scrollView.intersectsOtherView(nil) && scrollView.window == UIApplication.shared.keyWindow 
        if isShowInWindow {
            // 是ScrollView滚动到最前面（包括内边距）
            NotificationCenter.default.post(name: Notification.Name(rawValue: KScrollTopWindowNotification), object: nil, userInfo: nil)
            scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated:true)
        }
        
        /*
        guard let window = UIApplication.sharedApplication().keyWindow else { return }
        //  窗口的window的bounds
        let windowBounds = window.convertRect(window.frame,toView: nil)
        // 判断ScrollView是否跟窗口有重叠  没有重叠，直接返回
        // 得到subview在窗口中得frame 把subview.superview转到window frame上 nil = window
        let newFrame = scrollView.superview!.convertRect(scrollView.frame,toView: nil)
//        scrollView.hidden  &&  && scrollView.window == UIApplication.sharedApplication().keyWindow
        let isShowInWindow = CGRectIntersectsRect(newFrame, windowBounds) && scrollView.window == UIApplication.sharedApplication().keyWindow
        if isShowInWindow {
            // 是ScrollView滚动到最前面（包括内边距）
            scrollView.scrollRectToVisible(CGRectMake(scrollView.frame.origin.x, 0, 1, 1), animated:true)
        }
        print("=========================cishu==================")
        */
    }
}


// MARK: - 失败的方法
//class MGScrollTopWindow: NSObject{
//    private var scrollTopWindow: UIWindow = {
//           let window = UIWindow(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 20))
//        return window
//    }()
//    
//    override init() {
//        super.init()
//        initilize()
//    }
//}
//
//struct SomeStructure {
//    static var storedTypeProperty = "Some value."
//}
//
//extension MGScrollTopWindow {
//    // MARK:- 自定义构造函数
//    func initilize() {
//        scrollTopWindow.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 80)
//        scrollTopWindow.backgroundColor = UIColor.redColor()
//        scrollTopWindow.windowLevel = UIWindowLevelAlert
//        let tapGes = UITapGestureRecognizer(target: self, action: Selector("scrollTopWindowclick:"))
//        scrollTopWindow.addGestureRecognizer(tapGes)
//        UIApplication.sharedApplication().keyWindow?.addSubview(scrollTopWindow)
//    }
//    
//    func show() {
//        scrollTopWindow.hidden = false
//    }
//    
//    @objc func scrollTopWindowclick(tapGes: UITapGestureRecognizer) {
//        let keywindow = UIApplication.sharedApplication().keyWindow
//        self.searScrollViewInView(keywindow!)
//    }
//    
//    func searScrollViewInView(superView: UIView) {
//        //  窗口的window的bounds
//        let windowBounds = UIApplication.sharedApplication().keyWindow!.bounds
//        for  sc in superView.subviews {
//            // 得到subview在窗口中得frame 把subview.superview转到window frame上 nil = window
//            let newFrame = sc.superview!.convertRect(sc.frame,toView: nil)
//            
//            let isShowInWindow = !sc.hidden && sc.alpha > 0.01 && CGRectIntersectsRect(newFrame, windowBounds) && sc.window == UIApplication.sharedApplication().keyWindow
//            if sc.isKindOfClass(UIScrollView.classForCoder()) && isShowInWindow {
//                var offset = (sc as! UIScrollView).contentOffset as CGPoint
//                offset.y = -(sc as! UIScrollView).contentInset.top
//                (sc as! UIScrollView).setContentOffset(offset, animated: true)
//            }
//            // 利用递归思想遍历
//            self.searScrollViewInView(sc)
//        }
//    }
//    
//}
