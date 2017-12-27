//
//  GameCenterViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/27.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class GameCenterViewModel: NSObject {
    lazy var gameCenterMmodels = [GameCenterModel]()
}

extension GameCenterViewModel {
    func loadGameCenterData(_ finishedCallback: @escaping (_ err: Error?) -> ()) {
//        let parameters:[String : Any] = ["limit": 20, "client_sys": "ios","offset": offset]
        NetWorkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/app_api/get_app_list?devid=EF79C6C6-AB14-4A3C-830B-A55728C89073&sign=d1ca2dcf1a1521515ce4d201db20b12f&time=1488155520&type=ios", parameters: nil, succeed: { (result, err) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataDict   = resultDict["data"] as? [String: Any] else { return }
            guard let dataArray  = dataDict["data"] as? [[String: Any]] else { return }
            
            for model in dataArray {
                self.gameCenterMmodels.append(GameCenterModel(dict: model))
            }
            
            finishedCallback(nil)
        }) { (err) in
            finishedCallback(err)
        }
    }
}
