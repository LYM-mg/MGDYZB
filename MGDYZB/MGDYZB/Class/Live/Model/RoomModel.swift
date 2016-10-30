//
//  RoomModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class RoomModel: AnchorModel {
    /// 房间号
//    var room_id: String = ""
    /// 房间名
//    var room_name: String = ""
    /// 房间图片url
    var room_src: String = ""
    var cate_id: String = ""
    var url: String = ""
    var game_url: String = ""
    /// 是否是竖屏播放直播 1 -> true
//    var isVertical: Int = 0
    /// 在线数
//    var online: Int = 0
    /// 主播名字
//    var nickname: String = ""
    /// 所属分类
    var game_name: String = ""
    var game_icon_url: String = ""
    /// 头像
    var owner_avatar: String = ""
    /// 主播地址
//    var anchor_city: String = ""
    /// 粉丝
    var fans: String = ""
    var owner_weight: String = ""
    /// 直播地址
    var hls_url: String = ""
    /// 直播公告
    var show_details: String = ""
    var data: [RoomModel] = []
    
//    init(dict : [String : AnyObject]) {
//        super.init()
//        
//        setValuesForKeysWithDictionary(dict)
//    }
//    
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }
}
