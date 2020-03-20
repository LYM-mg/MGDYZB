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
    var avatarMid : String!
    var avatarSmall : String!
    var cateId : Int!
    var childId : AnyObject!
    var gameName : String!
    var hn : Int!
    var isVertical : Int!
    var jumpUrl : String!
    var nickname : String!
    var nrt : Int!
    var online : Double?
    var pushIos : Int!
    var pushNearby : Int!
    var ranktype : String!
    var recomType : String!
    var rmf1 : Int!
    var rmf2 : Int!
    var rmf3 : Int!
    var rmf4 : Int!
    var rmf5 : Int!
    var roomId : Int!
    var roomName : String!
    var roomSrc : String!
    var rpos : String!
    var showStatus : Int!
    var showTime : AnyObject!
    var specificCatalog : AnyObject!
    var specificStatus : AnyObject!
    var subject : AnyObject!
    var verticalSrc : String!
    var vodQuality : AnyObject!


    /**
     * Instantiate the instance using the passed dict values to set the properties values
     */
    init(dict : [String : Any]){
        avatarMid = dict["avatar_mid"] as? String
        avatarSmall = dict["avatar_small"] as? String
        cateId = dict["cate_id"] as? Int
        childId = dict["child_id"] as? AnyObject
        gameName = dict["game_name"] as? String
        hn = dict["hn"] as? Int
        isVertical = dict["isVertical"] as? Int
        jumpUrl = dict["jumpUrl"] as? String
        nickname = dict["nickname"] as? String
        nrt = dict["nrt"] as? Int
        online = dict["online"] as? Double
        pushIos = dict["push_ios"] as? Int
        pushNearby = dict["push_nearby"] as? Int
        ranktype = dict["ranktype"] as? String
        recomType = dict["recomType"] as? String
        rmf1 = dict["rmf1"] as? Int
        rmf2 = dict["rmf2"] as? Int
        rmf3 = dict["rmf3"] as? Int
        rmf4 = dict["rmf4"] as? Int
        rmf5 = dict["rmf5"] as? Int
        roomId = dict["room_id"] as? Int
        roomName = dict["room_name"] as? String
        roomSrc = dict["room_src"] as? String
        rpos = dict["rpos"] as? String
        showStatus = dict["show_status"] as? Int
        showTime = dict["show_time"] as? AnyObject
        specificCatalog = dict["specific_catalog"] as? AnyObject
        specificStatus = dict["specific_status"] as? AnyObject
        subject = dict["subject"] as? AnyObject
        verticalSrc = dict["vertical_src"] as? String
        vodQuality = dict["vod_quality"] as? AnyObject
        
        jumpUrl = "http://www.douyu.com/\(room_id)"
    }
    /// 房间ID
    var room_id: NSNumber = 0 {
        didSet {
            jumpUrl = "http://www.douyu.com/\(room_id)"
        }
    }
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
//    var isVertical : NSNumber = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
//    var nickname : String = ""
    /// 观看人数
//    var online : NSNumber = 0
    /// 所在城市
    var anchor_city : String = ""

    /// 直播网址
//    var jumpUrl: String!
    //    var url: String?
    var game_url: String?
    var game_name: String?
//    var avatar: String?
    var avatar_small: String?
    var avatar_mid: String?
//
//    // MARK:- 自定义构造函数
//    override init() {
//
//    }
//
//    init(dict : [String : Any]) {
//        super.init()
//        self.setValuesForKeys(dict)
//        jumpUrl = "http://www.douyu.com/\(room_id)"
//    }
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
