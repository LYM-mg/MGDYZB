//
//  TaskRuleModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/27.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class TaskRuleModel: NSObject {
    var gold : String!
    var level : String!
    var name : String!
    var silver : String!
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }

}
