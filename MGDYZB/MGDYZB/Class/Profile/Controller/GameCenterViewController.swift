//
//  GameCenterViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/27.
//  Copyright © 2017年 ming. All rights reserved.
//  http://capi.douyucdn.cn/api/app_api/get_app_list?devid=EF79C6C6-AB14-4A3C-830B-A55728C89073&sign=d1ca2dcf1a1521515ce4d201db20b12f&time=1488155520&type=ios 

import UIKit

private let KGameCenterCellID = "KGameCenterCellID"

class GameCenterViewController: BaseViewController {
    fileprivate lazy var gameCenterVM = GameCenterViewModel()
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: MGScreenW, height: 95)
        flowLayout.minimumLineSpacing = MGGloabalMargin*0.5
        flowLayout.minimumInteritemSpacing = MGGloabalMargin
        flowLayout.sectionInset = UIEdgeInsets(top: MGGloabalMargin, left: MGGloabalMargin, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: self!.view.bounds, collectionViewLayout: flowLayout)
        cv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.dataSource = self
        cv.delegate = self
        cv.register(GameCenterCell.self, forCellWithReuseIdentifier: KGameCenterCellID)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "游戏中心"
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UI
extension GameCenterViewController {
    override func setUpMainView() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setUpMainView()
    }
}

// MARK: - 数据
extension GameCenterViewController {
    fileprivate func loadData() {
        gameCenterVM.loadGameCenterData { (err) in
            if err == nil {
                self.collectionView.reloadData()
            }else {
                debugPrint(err)
            }
            self.loadDataFinished()
        }
    }
    
    fileprivate func setUpRefresh() {
        // MARK: - 下拉
        self.collectionView.header = MJRefreshGifHeader(refreshingBlock: { [weak self]() -> Void in
            self!.gameCenterVM.gameCenterMmodels.removeAll()
            self?.loadData()
            self!.collectionView.header.endRefreshing()
            self?.collectionView.footer.endRefreshing()
        })
        self.collectionView.header.isAutoChangeAlpha = true
        self.collectionView.header.beginRefreshing()
    }
}


// MARK: - UICollectionViewDataSource
extension GameCenterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameCenterVM.gameCenterMmodels.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCenterCellID, for: indexPath) as! GameCenterCell
        cell.model = gameCenterVM.gameCenterMmodels[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameCenterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = gameCenterVM.gameCenterMmodels[indexPath.item]
        if UIApplication.shared.canOpenURL(URL(string: model.down_ios_url)!) {
            UIApplication.shared.openURL(URL(string: model.down_ios_url)!)
        }
    }
}
