//
//  HotGameViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class HotGameViewModel: BaseLiveViewModel {
    func loadHotGameData(finished: @escaping (_ err: Error?)->()) {
        let urlStr = "http://capi.douyucdn.cn/api/v1/getColumnRoom/9"
        loadLiveData(urlStr: urlStr, finishedCallback: finished)
    }
}


