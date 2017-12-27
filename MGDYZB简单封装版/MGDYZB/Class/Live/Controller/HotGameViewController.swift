//
//  HotGameViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class HotGameViewController: BaseLiveViewController {
    fileprivate lazy var hotgameVM = HotGameViewModel()
    override func loadData() {
        super.loadData()
        
        baseLiveVM = hotgameVM
        
        hotgameVM.loadHotGameData { (err) in
            if err == nil {
                self.collectionView.reloadData()
            }else {
                debugPrint(err)
            }
            self.loadDataFinished()
        }
    }
}
