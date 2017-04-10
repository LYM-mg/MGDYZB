//
//  SearchViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/4/10.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class SearchViewModel: BaseViewModel {
    lazy var keyword: String = ""
    lazy var offset: Int = 0
    
    /*
     http://capi.douyucdn.cn/api/v1/searchNew/%E9%98%BF%E7%8B%B8/1?limit=20&client_sys=ios&offset=0
     http://capi.douyucdn.cn/api/v1/searchNew/666/1?limit=20&client_sys=ios&offset=0
     */
    func searchDataWithKeyword(_ finishCallback: @escaping () -> ()) {
        let urlStr = "http://capi.douyucdn.cn/api/v1/searchNew/\(keyword)/1"
        let parameters: [String: Any] = ["limit": 20,"client_sys": "ios","offset": offset]
        
        NetWorkTools.requestData1(.get, urlString: urlStr, parameters: parameters) { (result) in
            // 1.对界面进行处理
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataDict = resultDict["data"] as? [String: Any] else { return }
            guard let dataArray = dataDict["room"] as? [[String: Any]] else { return }
            
            // 2.判断是否分组数据
            // 2.1.创建组
            let group = AnchorGroup()
            
            // 2.2.遍历dataArray的所有的字典
            for dict in dataArray {
                group.anchors.append(AnchorModel(dict: dict))
            }
            
            // 2.3.将group,添加到anchorGroups
            self.anchorGroups.append(group)
            
            
            // 3.完成回调
            finishCallback()
        }
    }
}
