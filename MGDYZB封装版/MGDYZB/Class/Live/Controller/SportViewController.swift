//
//  SportViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.

import UIKit
//import SafariServices

class SportViewController: BaseLiveViewController {
    fileprivate lazy var sportVM = SportViewModel()
    override func loadData() {
        super.loadData()
        
        baseLiveVM = sportVM
        
        sportVM.loadSportData { (err) in
            if err == nil {
                self.collectionView.reloadData()
            }else {
                debugPrint(err)
            }
            self.loadDataFinished()
        }
    }
}
