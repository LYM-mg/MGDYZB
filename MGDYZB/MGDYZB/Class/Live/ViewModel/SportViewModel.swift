//
//  SportViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class SportViewModel: NSObject {
    var offset: Int = 0
    
    lazy var sportModels = [SportModel]()
}

extension SportViewModel {
    func loadSportData(finished: @escaping (_ err: Error?)->()) {
        let parameters:[String : Any] = ["limit": 20, "client_sys": "ios","offset": offset]
        let urlStr = "http://capi.douyucdn.cn/api/v1/qie"
        NetWorkTools.requestData(type: .get, urlString: urlStr, parameters: parameters, succeed: { (result, err) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for model in dataArray {
                self.sportModels.append(SportModel(dict: model))
            }
            
            finished(nil)
        }) { (err) in
            finished(err)
        }
    }
}
