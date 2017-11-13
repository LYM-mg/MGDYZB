//
//  Common.swift
//  DYZB
//
//  Created by 1 on 16/9/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

let kStatusBarH : CGFloat = 20
let kNavigationBarH : CGFloat = 44
let kTabbarH : CGFloat = 44

/// 状态栏高度20
let MGStatusHeight: CGFloat = (kScreenH==812.0) ? 44 : 20
/// 导航栏高度64
let MGNavHeight: CGFloat = (kScreenH==812.0) ? 88 : 64
/// tabBar的高度 50
let MGTabBarHeight: CGFloat = kScreenH == 812.0 ? 83 : 50
/// 全局的间距 10
let MGGloabalMargin: CGFloat = 10
/** 导航栏颜色 */
let navBarTintColor  = UIColor.colorWithCustom(r: 83, g: 179, b: 163)


let kScreenSize = UIScreen.main.bounds.size
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
// MARK:- 全局参数
let MGScreenBounds = UIScreen.main.bounds
let MGScreenW = UIScreen.main.bounds.size.width
let MGScreenH = UIScreen.main.bounds.size.height

let KScrollTopWindowNotification = "KScrollTopWindowNotification"
let KEnterHomeViewNotification = "KEnterHomeViewNotification"

