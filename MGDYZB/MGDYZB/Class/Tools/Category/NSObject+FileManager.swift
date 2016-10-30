//
//  NSObject+FileManager.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit


extension NSObject {
    class func getFileSizeWithFileName(path: String,completionBlock:(totalSize: UInt64) -> () ) {
        // 在子线程中计算文件大小
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            // 1.文件总大小
            var totalSize: UInt64 = 0;
            
            // 2.创建文件管理者
            let fileManager = NSFileManager.defaultManager()
            
            // 3.判断文件存不存在以及是否是文件夹
            var isDirectory: ObjCBool = ObjCBool(false)
            let isFileExist = fileManager.fileExistsAtPath(path , isDirectory: &isDirectory)
            
            if (!isFileExist) {return} // 文件不存在
            
            if (isDirectory) { // 是文件夹
                guard let subPaths = fileManager.subpathsAtPath(path)  else { return }
                for subPath in subPaths {
                    let filePath = path.stringByAppendingFormat("/%@", subPath)
                    var isDirectory: ObjCBool = ObjCBool(false)
                    let isExistFile = fileManager.fileExistsAtPath(filePath, isDirectory: &isDirectory)
                    if (!isDirectory && isExistFile && !filePath.containsString("DS")) {
                        if let attr: NSDictionary = try? fileManager.attributesOfItemAtPath(path) {
                            totalSize += attr.fileSize()
                        }
                    }
                }
            }else{ // 不是文件夹
                if let attr: NSDictionary = try? fileManager.attributesOfItemAtPath(path) {
                    totalSize += attr.fileSize()
                }
            }
            
            // 回到主线程
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    completionBlock(totalSize: totalSize)
            }
        }
    }
    
    func getFileSizeWithFileName(path: String, completionBlock:(totalSize: UInt64) -> ()) {
        NSObject.getFileSizeWithFileName(path, completionBlock:completionBlock)
    }
}


extension NSObject {
    /** 获取路径 */
    class func cachesPath() -> String {
         return NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
    }
    func cachesPath() -> String {
         return NSObject.cachesPath()
    }
}


extension NSObject {
    /** 获取路径 */
    class func removeCachesWithCompletion(completionBlock: ()->())  {
        NSOperationQueue().addOperationWithBlock { () -> Void in
            // 创建文件管理者
            let fileManager = NSFileManager.defaultManager()
            
            // 删除文件
            let path = self.cachesPath() as String
            
            var isDirectory: ObjCBool = ObjCBool(false)
            let isFileExist = fileManager.fileExistsAtPath(path , isDirectory: &isDirectory)
            
            if (!isFileExist) {return} // 文件不存在
            
            if (isDirectory) {
                guard let enumerator = fileManager.enumeratorAtPath(path) else { return }
                for subPath in enumerator {
                    let subPath = subPath as? String
                    let filePath = path.stringByAppendingFormat("/%@", subPath!)
                    // 移除文件Or文件夹
                    try! fileManager.removeItemAtPath(filePath)
                }
            }
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completionBlock()
            })
        }
    }
    
    func removeCachesWithCompletion(completionBlock: ()->()) {
        NSObject.removeCachesWithCompletion(completionBlock)
    }
}


