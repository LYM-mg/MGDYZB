//
//  GroupItem.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class GroupItem: NSObject {
    /** 记录下组头部标题 */
    var headerTitle:String = ""
    
    /**  记录下组尾部标题 */
    var footerTitle:String = ""
    
    // 记录下当前组有多少行
    // items:XMGSettingItem
    // 行模型数组
    var items:[SettingItem]?
}
