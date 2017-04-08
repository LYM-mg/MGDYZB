//
//  BaseGameModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class BaseGameModel: NSObject {
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    var tag_id : String = ""
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

/*
    tag_id": "1",
    "short_name": "LOL",
    "tag_name": "\u82f1\u96c4\u8054\u76df",
    "pic_name": "c543faae97189c529c37b7741906d5a1.jpg",
    "pic_name2": "19e443be45873d57b5a9a9a5bd0658f4.jpg",
    "icon_name": "d3e0073bfb714186ab0c818744601963.jpg",
    "small_icon_name": "",
    "orderdisplay": "5",
    "rank_score": "0",
    "night_rank_score": "0",
    "nums": "20346",
    "push_ios": "1",
    "push_home": "1",
    "is_game_cate": "1",
    "cate_id": "1",
    "is_del": "0",
    "is_relate": "1",
    "push_vertical_screen": "0",
    "push_nearby": "0",
    "push_qqapp": "1",
    "broadcast_limit": "3",
    "vodd_cateids": "5,41",
    "open_full_screen": "0",
    "pic_url": "https:\/\/staticlive.douyucdn.cn\/upload\/game_cate\/c543faae97189c529c37b7741906d5a1.jpg",
    "url": "\/directory\/game\/LOL",
    "icon_url": "https:\/\/staticlive.douyucdn.cn\/upload\/game_cate\/d3e0073bfb714186ab0c818744601963.jpg",
    "small_icon_url": "",
    "count": 1858,
    "count_ios": 1071,
    "is_childs": 7
 */
