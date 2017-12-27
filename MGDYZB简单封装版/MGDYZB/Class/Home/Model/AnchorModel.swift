//
//  AnchorModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class AnchorModel: NSObject {    
    /// 直播网址
    var jumpUrl: String!

    /// 房间ID
    var room_id: NSNumber = 0 {
        didSet {
            jumpUrl = "http://www.douyu.com/\(room_id)"
        }
    }
    /// 房间图片对应的URLString
    var vertical_src: String = ""
    
    /// 判断是手机直播还是电脑直播
    // 0: 电脑直播(普通房间) 1: 手机直播(秀场房间)
    var isVertical: NSNumber = 0
    /// 房间名称
    var room_name: String = ""
    /// 主播昵称
    var nickname: String = ""
    /// 观看人数
    var online: NSNumber = 0
    /// 所在城市
    var anchor_city: String!
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
        jumpUrl = "http://www.douyu.com/\(room_id)"
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
/*
    var avatar: String!
    var avatarMid: String!
    var avatarSmall: String!
    var cate1Id: String!
    var cate2Id: String!
    var cate3Id: String!
    
    var cateId: NSNumber!
    var child_id: NSNumber!
    var cid1: NSNumber!
    var isNobleRec : NSNumber!
    
    
    var ranktype: NSNumber!
    var is_noble_rec: NSNumber!
    var showType: NSNumber!
    
    var gameName: String!
    var game_url: String!
    var iconEndTime: Bool!
    var iconId: String!
    var iconStartTime: Bool!
    var show_status: String!
    var showTime: String!
    var specific_catalog: String!
    var specific_status: String!
    var url: String!
    var verticalSrc: String!
    var vod_quality: String!
*/    
    var room_src: String! {
        didSet {
            self.vertical_src = room_src
        }
    }
}
