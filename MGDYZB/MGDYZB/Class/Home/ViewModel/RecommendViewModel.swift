//
//  RecommendViewModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    // MARK:- 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    // 请求推荐数据
    func requestData(finishCallback: () -> ()) {
        // 1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate()]
        
        // 2.创建Group
        let dGroup = dispatch_group_create()
        
        // 3.请求第一部分推荐数据
        dispatch_group_enter(dGroup)
        NetworkTools.requestData(.get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate()]) { (result) -> () in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            // 3.3.离开组
            dispatch_group_leave(dGroup)
        }
        
        // 4.请求第二部分颜值数据
        dispatch_group_enter(dGroup)
        NetworkTools.requestData(.get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) -> () in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3.离开组
            dispatch_group_leave(dGroup)
        }
        
        // 5.请求2-12部分游戏数据
        dispatch_group_enter(dGroup)
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1474252024
        loadAnchorData(isGroup: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { () -> () in
            dispatch_group_leave(dGroup)
        }
        
        // 6.所有的数据都请求到,之后进行排序
        dispatch_group_notify(dGroup, dispatch_get_main_queue()) { () -> Void in
            self.anchorGroups.insert(self.prettyGroup, atIndex: 0)
            self.anchorGroups.insert(self.bigDataGroup, atIndex: 0)
            
            finishCallback()
        }
    }
    // 请求无线轮播的数据
    func requestCycleData(finishedCallBack: () -> ()) {
        NetworkTools.requestData(.get, urlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) -> () in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String: AnyObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dictArr = resultDict["data"] as? [[String: NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dictArr {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishedCallBack()
        }
    }
}
