//
//  SportViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.

import UIKit
import SafariServices

class SportViewController: BaseViewController {
    fileprivate lazy var sportVM = SportViewModel()
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
        
        if #available(iOS 9, *) {
            if traitCollection.forceTouchCapability == .available {
                registerForPreviewing(with: self, sourceView: self.view)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: - setUpUI
extension SportViewController{
    internal override func setUpMainView() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setUpMainView()
        setUpRefresh()
    }
}

// MARK: - setUpUI
extension SportViewController{
    fileprivate func setUpRefresh() {
        // MARK: - 下拉
        self.collectionView.header = MJRefreshGifHeader(refreshingBlock: { [weak self]() -> Void in
            self!.sportVM.offset = 0
            self?.loadData()
            self!.collectionView.header.endRefreshing()
            self?.collectionView.footer.endRefreshing()
            })
        // MARK: - 上拉
        self.collectionView.footer = MJRefreshAutoGifFooter(refreshingBlock: {[weak self] () -> Void in
            self!.sportVM.offset += 20
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

// MARK: - UICollectionViewDataSource
extension SportViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportVM.sportModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        // 2.给cell设置数据
        let anchor = sportVM.sportModels[(indexPath as NSIndexPath).item]
        cell.anchor = anchor
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SportViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = sportVM.sportModels[indexPath.item]
        
        anchor.isVertical == 0 ? pushNormalRoomVc(model: anchor) : presentShowRoomVc(model: anchor)
    }
    
    fileprivate func presentShowRoomVc(model: AnchorModel) {
        if #available(iOS 9, *) {
            let webViewVc = SFSafariViewController(url: URL(string: model.jumpUrl)!, entersReaderIfAvailable: true)
            present(webViewVc, animated: true, completion: nil)
        } else {
            let webViewVc = WKWebViewController(navigationTitle: model.room_name, urlStr: model.jumpUrl!)
            present(webViewVc, animated: true, completion: nil)
        }
    }
    
    fileprivate func pushNormalRoomVc(model: AnchorModel) {
        let webViewVc = WebViewController(navigationTitle: model.room_name, urlStr: model.jumpUrl!)
        show(webViewVc, sender: nil)
    }
}

// MARK: - UIViewControllerPreviewingDelegate
extension SportViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return nil }
        guard let cell = collectionView.cellForItem(at: indexPath) else { return nil }
        
        if #available(iOS 9.0, *) {
            previewingContext.sourceRect = cell.frame
        }
        
        var vc = UIViewController()
        let anchor = sportVM.sportModels[indexPath.item]
        if anchor.isVertical == 0 {
            if #available(iOS 9, *) {
                vc = SFSafariViewController(url: URL(string: anchor.jumpUrl)!, entersReaderIfAvailable: true)
            } else {
                vc = WKWebViewController(navigationTitle: anchor.room_name, urlStr: anchor.jumpUrl)
            }
        }else {
           vc = WKWebViewController(navigationTitle: anchor.room_name, urlStr: anchor.jumpUrl)
        }
        
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: nil)
    }
}

