//
//  HotGameViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class HotGameViewModel: BaseLiveViewModel {
    func loadHotGameData(finished: @escaping (_ err: Error?)->()) {
        let urlStr = "http://capi.douyucdn.cn/api/v1/getColumnRoom/9"
        loadLiveData(urlStr: urlStr, finishedCallback: finished)
    }
}


