//
//  AnchorGroup.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg

import UIKit

class AnchorGroup: BaseGameModel {
    /// 该组中对应的房间信息
    var room_list: [[String: Any]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
//    var icon_url : String?
    var pushNearby : String?
    var pushVerticalScreen : String?
    var roomList : [AnchorModel]?
    var smallIconUrl : String?
//    var tag_id : String?
//    var tag_name : String?
    
    /// 组显示的图标
    var icon_name: String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    override init() {
        super.init()
    }
    
    /**
     * Instantiate the instance using the passed dict values to set the properties values
     */
    override init(dict: [String:Any]){
        super.init()
        icon_url = dict["icon_url"] as? String ?? ""
        pushNearby = dict["push_nearby"] as? String
        pushVerticalScreen = dict["push_vertical_screen"] as? String
        room_list = dict["room_list"] as? [[String:Any]]
        guard let room_list = room_list else { return }
        for dict in room_list {
            anchors.append(AnchorModel(dict: dict))
        }
        
        smallIconUrl = dict["small_icon_url"] as? String
        tag_id = dict["tag_id"] as? NSNumber ?? 0
        tag_name = dict["tag_name"] as? String ?? ""
    }
}
