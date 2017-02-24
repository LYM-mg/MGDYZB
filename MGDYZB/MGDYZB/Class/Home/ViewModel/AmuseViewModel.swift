//
//  AmuseViewModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
}

extension AmuseViewModel {
    func loadAmuseData(_ finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroup: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
