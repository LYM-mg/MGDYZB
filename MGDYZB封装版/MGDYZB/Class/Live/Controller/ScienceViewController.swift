//
//  ScienceViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit
import SafariServices

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
