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
    var room_list: [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 组显示的图标
    var icon_name: String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()
}
