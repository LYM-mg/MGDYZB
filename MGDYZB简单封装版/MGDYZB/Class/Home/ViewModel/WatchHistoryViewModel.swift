//
//  WatchHistoryViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/4/11.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class WatchHistoryViewModel: BaseLiveViewModel {
    func loadWatchHistoryData(_ finishedCallback: @escaping (_ err: Error?) -> ()) {
        // POST请求： http://capi.douyucdn.cn/api/v1/room_batch?client_sys=ios

        NetWorkTools.requestData(type: .post, urlString: "http://capi.douyucdn.cn/api/v1/room_batch", parameters: ["client_sys": "ios"], succeed: { (result, err) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for model in dataArray {
                self.liveModels.append(AnchorModel(dict: model))
            }
            
            finishedCallback(nil)
        }) { (err) in
            finishedCallback(err)
        }
        
        // http://capi.douyucdn.cn/api/v1/history?aid=ios&client_sys=ios&time=1491870660&auth=65c964c9ccdfe37e60ba26f467dc920e
        
        let detaildate = Int(Date().timeIntervalSince1970)
//        String(detaildate).md5
//        print("mdlacar测试 = \(String(detaildate).md5)")
        let parameters: [String: Any] = ["aid": "ios","client_sys": "ios","time": String(detaildate),"auth": String(detaildate).md5]
        NetWorkTools.requestData(type: .post, urlString: "http://capi.douyucdn.cn/api/v1/history", parameters: parameters, succeed: { (result, err) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for model in dataArray {
                self.liveModels.append(AnchorModel(dict: model))
            }
            
            finishedCallback(nil)
        }) { (err) in
            finishedCallback(err)
        }


    }
}
