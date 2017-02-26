//
//  BaseLiveViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/26.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class BaseLiveViewModel: NSObject {
    var offset: Int = 0
    
    lazy var liveModels = [AnchorModel]()
}

extension BaseLiveViewModel {
    func loadLiveData(urlStr: String, finishedCallback: @escaping (_ err: Error?) -> ()) {
        let parameters:[String : Any] = ["limit": 20, "client_sys": "ios","offset": offset]
        NetWorkTools.requestData(type: .get, urlString: urlStr, parameters: parameters, succeed: { (result, err) in
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
