//
//  SportViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class SportViewModel: BaseLiveViewModel {
    func loadSportData(finished: @escaping (_ err: Error?)->()) {
        let urlStr = "http://capi.douyucdn.cn/api/v1/qie"
        loadLiveData(urlStr: urlStr, finishedCallback: finished)
    }
}
