//
//  RoomModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class RoomModel: AnchorModel {

    /// 房间图片url
    var room_src: String = ""
//    var cate_id: String = ""
    var cate_id: NSNumber!
    var url: String = ""
    var game_url: String = ""
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
    
//    init(dict : [String : AnyObject]) {
//        super.init()
//        setValuesForKeys(dict)
//    }
//    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

//   https://www.douyu.com/976537
// ["specific_status": 0, "room_id": 976537, "ranktype": 8, "nickname": 小小小萧蔷, "room_src": https://rpic.douyucdn.cn/a1702/25/08/976537_170225082525.jpg, "show_status": 1, "subject": , "isVertical": 0, "cate_id": 174, "online": 7595, "jumpUrl": , "game_url": /directory/game/ecy, "vod_quality": 0, "url": /976537, "specific_catalog": , "room_name": 早上好唱歌！, "anchor_city": , "avatar_mid": https://apic.douyucdn.cn/upload/avatar/face/201608/25/d996f36b1686328fb9245293817cb7fb_middle.jpg, "child_id": 258, "game_name": 二次元, "fans": 40463, "avatar_small": https://apic.douyucdn.cn/upload/avatar/face/201608/25/d996f36b1686328fb9245293817cb7fb_small.jpg, "owner_uid": 65467347, "avatar": https://apic.douyucdn.cn/upload/avatar/face/201608/25/d996f36b1686328fb9245293817cb7fb_big.jpg, "show_time": 1487982155, "vertical_src": https://rpic.douyucdn.cn/a1702/25/08/976537_170225082525.jpg]
