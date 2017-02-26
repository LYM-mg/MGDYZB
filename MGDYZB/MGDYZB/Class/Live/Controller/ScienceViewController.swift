//
//  ScienceViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit
import SafariServices

class ScienceViewController: BaseViewController {
    fileprivate lazy var scienceVM = ScienceViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //        layout.headerReferenceSize = CGSizeMake(kScreenW, kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: kItemMargin, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 3.注册
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: - setUpUI
extension ScienceViewController {
    internal override func setUpMainView() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setUpMainView()
        setUpRefresh()
    }
}

// MARK: - setUpUI
extension ScienceViewController {
    fileprivate func setUpRefresh() {
        // MARK: - 下拉
        self.collectionView.header = MJRefreshGifHeader(refreshingBlock: { [weak self]() -> Void in
            self!.scienceVM.offset = 0
            self?.loadData()
            self!.collectionView.header.endRefreshing()
            self?.collectionView.footer.endRefreshing()
            })
        // MARK: - 上拉
        self.collectionView.footer = MJRefreshAutoGifFooter(refreshingBlock: {[weak self] () -> Void in
            self!.scienceVM.offset += 20
            self?.loadData()
            self!.collectionView.header.endRefreshing()
            self?.collectionView.footer.endRefreshing()
            })
        self.collectionView.header.isAutoChangeAlpha = true
        self.collectionView.header.beginRefreshing()
        self.collectionView.footer.noticeNoMoreData()
    }
    
    // 加载数据
    fileprivate func loadData() {
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

// MARK: - UICollectionViewDataSource
extension ScienceViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scienceVM.scienceModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        // 2.给cell设置数据
        let anchor = scienceVM.scienceModels[(indexPath as NSIndexPath).item]
        cell.anchor = anchor
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ScienceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = scienceVM.scienceModels[indexPath.item]
        
        anchor.isVertical == 0 ? pushNormalRoomVc(model: anchor) : presentShowRoomVc(model: anchor)
    }
    
    fileprivate func pushNormalRoomVc(model: AnchorModel) {
        let webViewVc = WKWebViewController(navigationTitle: model.room_name, urlStr: model.jumpUrl)
        show(webViewVc, sender: nil)
    }
    
    fileprivate func presentShowRoomVc(model: AnchorModel) {
        if #available(iOS 9, *) {
            if let url = URL(string: model.jumpUrl) {
                let webViewVc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                present(webViewVc, animated: true, completion: nil)
            }
        } else {
            let webViewVc = WKWebViewController(navigationTitle: model.room_name, urlStr: model.jumpUrl)
            present(webViewVc, animated: true, completion: nil)
        }
    }
}




