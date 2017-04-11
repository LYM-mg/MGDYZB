//
//  SearchViewModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/4/10.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class SearchViewModel: BaseViewModel {
    lazy var keyword: String = ""
    lazy var offset: Int = 0
    
    /*
     http://capi.douyucdn.cn/api/v1/searchNew/%E9%98%BF%E7%8B%B8/1?limit=20&client_sys=ios&offset=0
     http://capi.douyucdn.cn/api/v1/searchNew/666/1?limit=20&client_sys=ios&offset=0
     */
    func searchDataWithKeyword(_ finishCallback: @escaping () -> ()) {
        let urlStr = "http://capi.douyucdn.cn/api/v1/searchNew/\(keyword)/1"
        let parameters: [String: Any] = ["limit": 20,"client_sys": "ios","offset": offset]
        
        NetWorkTools.requestData1(.get, urlString: urlStr, parameters: parameters) { (result) in
            // 1.对界面进行处理
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataDict = resultDict["data"] as? [String: Any] else { return }
            guard let dataArray = dataDict["room"] as? [[String: Any]] else { return }
            
            // 2.判断是否分组数据
            // 2.1.创建组
            let group = AnchorGroup()
            
            // 2.2.遍历dataArray的所有的字典
            for dict in dataArray {
                group.anchors.append(AnchorModel(dict: dict))
            }
            
            // 2.3.将group,添加到anchorGroups
            self.anchorGroups.append(group)
            
            
            // 3.完成回调
            finishCallback()
        }
    }
}

//"room_id": "522424",
//"room_src": "https://rpic.douyucdn.cn/a1704/11/08/522424_170411082238.jpg",
//"vertical_src": "https://rpic.douyucdn.cn/a1704/11/08/522424_170411082238.jpg",
//"isVertical": 0,
//"cate_id": "1",
//"room_name": "LCS 季后赛4月10日赛事重播",
//"show_status": "1",
//"subject": "",
//"show_time": "1485141294",
//"owner_uid": "34223270",
//"specific_catalog": "lcs",
//"specific_status": "1",
//"vod_quality": "0",
//"nickname": "Riot丶LCS",
//"online": 4515,
//"child_id": "37",
//"avatar": "https://apic.douyucdn.cn/upload/avanew/face/201612/22/11/cd342c0703b2a9a6efa038eb51ef94ac_big.jpg",
//"avatar_mid": "https://apic.douyucdn.cn/upload/avanew/face/201612/22/11/cd342c0703b2a9a6efa038eb51ef94ac_middle.jpg",
//"avatar_small": "https://apic.douyucdn.cn/upload/avanew/face/201612/22/11/cd342c0703b2a9a6efa038eb51ef94ac_small.jpg",
//"jumpUrl": "",
//"icon_data": {
//    "status": 5,
//    "icon_url": "",
//    "icon_width": 0,
//    "icon_height": 0
//},
//"url": "/lcs",
//"game_url": "/directory/game/LOL",
//"game_name": "英雄联盟",
//"rid": "522424",
//"oid": "34223270",
//"n": "LCS 季后赛4月10日赛事重播",
//"lt": "1491821346",
//"uc": "4393",
//"ls": "1",
//"on": "Riot丶LCS",
//"fans": "106134",
//"ranktype": 0
//
//
//"room_id": "522424",
//"room_src": "https://rpic.douyucdn.cn/a1704/11/08/522424_170411082238.jpg",
//"vertical_src": "https://rpic.douyucdn.cn/a1704/11/08/522424_170411082238.jpg",
//"isVertical": 0,
//"cate_id": "1",
//"room_name": "LCS 季后赛4月10日赛事重播",
//"status": "1",
//"show_status": "1",
//"subject": "",
//"show_time": "1485141294",
//"owner_uid": "34223270",
//"specific_catalog": "lcs",
//"specific_status": "1",
//"vod_quality": "0",
//"nickname": "Riot丶LCS",
//"online": 4515,
//"url": "/lcs",
//"game_url": "/directory/game/LOL",
//"game_name": "英雄联盟",
//"jumpUrl": "",
//"fans": "106134",
//"ranktype": 0
