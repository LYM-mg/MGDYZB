//
//  ScienceViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class ScienceViewController: BaseLiveViewController {
    fileprivate lazy var scienceVM = ScienceViewModel()
    override func loadData() {
        super.loadData()
        
        baseLiveVM = scienceVM
        
        scienceVM.loadScienceData { (err) in
            if err == nil {
                self.collectionView.reloadData()
            }else {
                debugPrint(err)
            }
            self.loadDataFinished()
        }
    }
}
