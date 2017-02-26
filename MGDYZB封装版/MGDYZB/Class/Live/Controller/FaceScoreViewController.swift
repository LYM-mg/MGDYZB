//
//  FaceScoreViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit
import SafariServices

class FaceScoreViewController: BaseLiveViewController {
    fileprivate lazy var faceVM = FaceViewModel()
    override func loadData() {
        super.loadData()
        
        baseLiveVM = faceVM
        
        faceVM.loadFaceData { (err) in
            if err == nil {
                self.collectionView.reloadData()
            }else {
                debugPrint(err)
            }
            self.loadDataFinished()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell

        // 2.给cell设置数据
        cell.anchor = faceVM.liveModels[(indexPath as NSIndexPath).item]

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kNormalItemW, height: kPrettyItemH)
    }
}


//class FaceScoreViewController: BaseViewController {
//    fileprivate lazy var faceVM = FaceViewModel()
//    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
//        // 1.创建layout
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: kNormalItemW, height: kPrettyItemH)
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = kItemMargin
//        //        layout.headerReferenceSize = CGSizeMake(kScreenW, kHeaderViewH)
//        layout.sectionInset = UIEdgeInsets(top: kItemMargin, left: kItemMargin, bottom: 0, right: kItemMargin)
//        
//        // 2.创建UICollectionView
//        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.white
//        collectionView.scrollsToTop = false
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        // 3.注册
//        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
//        return collectionView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//    }
// }
//
//// MARK: - setUpUI
//extension FaceScoreViewController{
//    override func setUpMainView() {
//        // 0.给ContentView进行赋值
//        contentView = collectionView
//        view.addSubview(collectionView)
//        super.setUpMainView()
//        setUpRefresh()
//    }
//}
//
//// MARK: - setUpUI
//extension FaceScoreViewController{
//    fileprivate func setUpRefresh() {
//        // MARK: - 下拉
//        self.collectionView.header = MJRefreshGifHeader(refreshingBlock: { [weak self]() -> Void in
//            self!.faceVM.offset = 0
//            self?.loadData()
//            self!.collectionView.header.endRefreshing()
//            self?.collectionView.footer.endRefreshing()
//        })
//        // MARK: - 上拉
//        self.collectionView.footer = MJRefreshAutoGifFooter(refreshingBlock: {[weak self] () -> Void in
//            self!.faceVM.offset += 20
//            self?.loadData()
//            self!.collectionView.header.endRefreshing()
//            self?.collectionView.footer.endRefreshing()
//        })
//        self.collectionView.header.isAutoChangeAlpha = true
//        self.collectionView.header.beginRefreshing()
//        self.collectionView.footer.noticeNoMoreData()
//    }
//    
//    // 加载数据
//    fileprivate func loadData() {
//        faceVM.loadFaceData { (err) in
//            if err == nil {
//                self.collectionView.reloadData()
//            }else {
//                debugPrint(err)
//            }
//            self.loadDataFinished()
//        }
//    }
//}
//
//// MARK: - UICollectionViewDataSource
//extension FaceScoreViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return faceVM.faceModels.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // 1.取出Cell
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
//        
//        // 2.给cell设置数据
//        cell.anchor = faceVM.faceModels[(indexPath as NSIndexPath).item]
//        
//        return cell
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//extension FaceScoreViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let anchor = faceVM.faceModels[indexPath.item]
//        
//        anchor.isVertical == 0 ? pushNormalRoomVc(model: anchor) : presentShowRoomVc(model: anchor)
//    }
//    
//    fileprivate func pushNormalRoomVc(model: AnchorModel) {
//        let webViewVc = WKWebViewController(navigationTitle: model.room_name, urlStr: model.jumpUrl)
//        show(webViewVc, sender: nil)
//    }
//    
//    fileprivate func presentShowRoomVc(model: AnchorModel) {
//        if #available(iOS 9, *) {
//            if let url = URL(string: model.jumpUrl) {
//                let webViewVc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
//                present(webViewVc, animated: true, completion: nil)
//            }
//        } else {
//            let webViewVc = WKWebViewController(navigationTitle: model.room_name, urlStr: model.jumpUrl)
//            present(webViewVc, animated: true, completion: nil)
//        }
//    }
//}
//
