//
//  WatchHistoryViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/4/11.
//  Copyright © 2017年 ming. All rights reserved.
//

// 这里继承Live那边的BaseLiveViewController，为了省写代码   需要登录才能做这个功能
import UIKit

class WatchHistoryViewController: BaseLiveViewController {

    fileprivate lazy var watchVM = WatchHistoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "观看历史记录"
    }
    
    override func loadData() {
        super.loadData()
        
        baseLiveVM = watchVM
        
        watchVM.loadWatchHistoryData { (err) in
            if err == nil {
                self.collectionView.reloadData()
            }else {
                debugPrint(err)
            }
            self.loadDataFinished()

        }
    }
}
