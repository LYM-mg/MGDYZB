//
//  DetailGameViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/4/8.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class DetailGameViewModel: BaseViewModel {
    
    var tag_id: String = "1"
    lazy var offset: NSInteger = 0
//    http://capi.douyucdn.cn/api/v1/live/1?limit=20&client_sys=ios&offset=0
//    http://capi.douyucdn.cn/api/v1/live/2?limit=20&client_sys=ios&offset=0
    
    func loadDetailGameData(_ finishedCallback: @escaping () -> ()) {
        let urlStr = "http://capi.douyucdn.cn/api/v1/live/\(tag_id)"
        let parameters: [String: Any] = ["limit": 20,"client_sys": "ios","offset": offset]
        loadAnchorData(isGroup: false, urlString: urlStr, parameters: parameters, finishedCallback: finishedCallback)
    }
}
