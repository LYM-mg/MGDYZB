//
//  ProfileModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class ProfileModel: NSObject {
    // MARK:- 定义属性
    var title : String = ""
    var icon : String = ""
    var detailTitle: String = ""
    
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    init(icon: String, title: String, detailTitle: String = "") {
        self.icon = icon
        self.title = title
        if detailTitle != "" {
           self.detailTitle = detailTitle
        }
    }
    
    init(dict: [String : AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }

}
