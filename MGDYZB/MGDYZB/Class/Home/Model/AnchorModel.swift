//
//  AnchorModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {    
    /// 直播网址
    var jumpUrl: String!

    /// 房间ID
    var roomId: NSNumber = 0 {
        didSet {
            jumpUrl = "http://www.douyu.com/\(roomId)"
        }
    }
    /// 房间图片对应的URLString
    var vertical_src: String = ""
    
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical : NSNumber = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 观看人数
    var online : NSNumber = 0
    /// 所在城市
    var anchor_city : String!
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        jumpUrl = "http://www.douyu.com/\(roomId)"
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }

}
