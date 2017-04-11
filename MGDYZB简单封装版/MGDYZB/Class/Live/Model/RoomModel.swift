//
//  RoomModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class RoomModel: AnchorModel {

    /// 房间图片url
//    var cate_id: String = ""
    var cate_id: NSNumber!
//    var url: String = ""
//    var game_url: String = ""
    /// 在线数
//    var online: Int = 0
    /// 所属分类
    var game_name: String = ""
    var game_icon_url: String = ""
    /// 头像
    var owner_avatar: String = ""
    /// 粉丝
    var fans: String = ""
    var owner_weight: String = ""
    /// 直播地址
    var hls_url: String = ""
    /// 直播公告
    var show_details: String = ""
    var data: [RoomModel] = []
    
//    init(dict : [String: Any]) {
//        super.init()
//        setValuesForKeys(dict)
//    }
//    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

//   https://www.douyu.com/976537

