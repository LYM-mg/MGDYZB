//
//  BaseViewModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroup isGroupData : Bool, urlString : String, parameters : [String : AnyObject]? = nil, finishedCallback: () -> ()) {
        NetworkTools.requestData(.get, urlString: urlString, parameters: parameters) { (result) -> () in
            print("dada + \(result)")
            // 1.对界面进行处理
            guard let resultDict = result as? [String : AnyObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : AnyObject]] else { return }
            
            // 2.判断是否分组数据
            if isGroupData {
                // 2.1.遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }
            else  {
                // 2.1.创建组
                let group = AnchorGroup()
                
                // 2.2.遍历dataArray的所有的字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                
                // 2.3.将group,添加到anchorGroups
                self.anchorGroups.append(group)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
