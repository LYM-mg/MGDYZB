//
//  FunnyViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit
import SafariServices

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseViewController {

    // MARK: 懒加载ViewModel对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()

    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize.zero
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)
        
        // 3.注册
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpMainView() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setUpMainView()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FunnyViewController {
     func loadData() {
        // 1.请求数据
        funnyVM.loadFunnyData {
            // 1.1.刷新表格
            self.collectionView.reloadData()
            
            // 1.2.数据请求完成
            self.loadDataFinished()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FunnyViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return funnyVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funnyVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// 其他组数据
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        // 2.给cell设置数据
        cell.anchor = funnyVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FunnyViewController: UICollectionViewDelegate {
    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headerView.group = funnyVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出对应的主播信息
        let anchor = funnyVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        
        // 2.判断是秀场房间&普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc(anchor: anchor) : presentShowRoomVc(anchor: anchor)
    }
    
    fileprivate func presentShowRoomVc(anchor: AnchorModel) {
        if #available(iOS 9.0, *) {
            // 1.创建SFSafariViewController
            let safariVC = SFSafariViewController(url: URL(string: anchor.jumpUrl)!, entersReaderIfAvailable: true)
            // 2.以Modal方式弹出
            present(safariVC, animated: true, completion: nil)
        } else {
            let webVC = WKWebViewController(navigationTitle: anchor.room_name, urlStr: anchor.jumpUrl)
            present(webVC, animated: true, completion: nil)
        }
    }
    
    fileprivate func pushNormalRoomVc(anchor: AnchorModel) {
        // 1.创建WebViewController
        let webVC = WKWebViewController(navigationTitle: anchor.room_name, urlStr: anchor.jumpUrl)
        webVC.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 2.以Push方式弹出
        navigationController?.pushViewController(webVC, animated: true)
    }
}




