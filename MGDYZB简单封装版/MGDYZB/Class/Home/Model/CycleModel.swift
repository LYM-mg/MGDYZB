//
//  CycleModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class CycleModel: NSObject {
    // 标题
    var title: String = ""
    // 展示的图片地址
    var pic_url: String = ""
    
    var id : Int!
    var mainId : Int!
    var oaSource : Int!
    var source : Int!
    var tvPicUrl : String!
    
    // 主播信息对应的字典
    var room: [String: Any]? {
        didSet {
            guard let room = room else  { return }
            anchor = AnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor: AnchorModel?
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    
    // MARK:- 自定义构造函数
    init(dict:[String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
        id = dict["id"] as? Int
        mainId = dict["main_id"] as? Int
        oaSource = dict["oa_source"] as? Int
        pic_url = dict["pic_url"] as? String ?? ""
        if let roomData = dict["room"] as? [String:Any]{
            anchor = AnchorModel(dict: roomData)
        }
        source = dict["source"] as? Int
        title = dict["title"] as? String ?? ""
        tvPicUrl = dict["tv_pic_url"] as? String
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
