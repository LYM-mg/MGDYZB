//
//  AllListViewModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class AllListViewModel: NSObject {
    // 用于上下拉刷新
    var currentPage = 0
    var rooms: [RoomModel] = []
    private let tagID: String = "0"
//    init(tagID: String) {
//        _tagID = tagID
//        super.init()
//    }
}

extension AllListViewModel {
    func loadAllListData(finishedCallback: () -> ()) {
        let parameters:[String : AnyObject] = ["offset": 20*currentPage, "limit": 20, "time": String(format: "%.0f", NSDate().timeIntervalSince1970)]
        let url = "http://capi.douyucdn.cn/api/v1/live/" + "\(tagID)?"
        NetworkTools.requestData(.get, urlString:  url, parameters: parameters) { (result) -> () in
            // 1.获取到数据
            guard let resultDict = result as? [String : AnyObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : AnyObject]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.rooms.append(RoomModel(dict: dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }

}
