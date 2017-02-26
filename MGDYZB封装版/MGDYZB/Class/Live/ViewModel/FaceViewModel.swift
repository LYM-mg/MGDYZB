//
//  FaceViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//    http://capi.douyucdn.cn/api/v1/getColumnRoom/8?limit=20&client_sys=ios&offset=0
//    http://capi.douyucdn.cn/api/v1/getColumnRoom/8?limit=20&client_sys=ios&offset=20

import UIKit

class FaceViewModel: BaseLiveViewModel {
    func loadFaceData(finished: @escaping (_ err: Error?)->()) {
        let urlStr = "http://capi.douyucdn.cn/api/v1/getColumnRoom/8"
        loadLiveData(urlStr: urlStr, finishedCallback: finished)
    }
}
