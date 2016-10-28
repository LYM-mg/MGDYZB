//
//  SaveTools.swift
//  MGDYZB
//
//  Created by ming on 16/10/28.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class SaveTools: NSObject {
    
    //写入读取userDefaults
    class func kSaveLocal(value: AnyObject,key: String) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
    }
    
    //写入读取userDefaults
    class func KGetLocalData(key: String) -> AnyObject? {
        return NSUserDefaults.standardUserDefaults().objectForKey(key)
    }
}
