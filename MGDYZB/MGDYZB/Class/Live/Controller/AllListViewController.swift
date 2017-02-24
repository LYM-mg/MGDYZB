//
//  AllListViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
// 

import UIKit
import JHPullToRefreshKit

class AllListViewController: BaseViewController {
    
    // MARK:- ViewModel
    fileprivate lazy var allListVM : AllListViewModel = AllListViewModel()

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
        setUpUI()
//        loadData()
        setUpRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - 初始化UI
extension AllListViewController {
    override func setUpUI()  {
        // 0.给ContentView进行赋值
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setUpUI()
    }
}

extension AllListViewController{
    fileprivate func loadData() {
        allListVM.loadAllListData { [unowned self]() -> () in
            self.collectionView.reloadData()
            
            self.loadDataFinished()
        }
    }
    
    
    fileprivate func setUpRefresh() {
        // MARK: - 下拉
        self.collectionView.header = MJRefreshGifHeader(refreshingBlock: { [weak self]() -> Void in
            self!.allListVM.currentPage = 0
            self?.loadData()
            self!.collectionView.header.endRefreshing()
            self?.collectionView.footer.endRefreshing()
        })
        // MARK: - 上拉
        self.collectionView.footer = MJRefreshAutoGifFooter(refreshingBlock: {[weak self] () -> Void in
            self!.allListVM.currentPage += 1
            self?.loadData()
            self!.collectionView.header.endRefreshing()
            self?.collectionView.footer.endRefreshing()
        })
//        self.collectionView.header.autoChangeAlpha = true
        self.collectionView.header.beginRefreshing()
        self.collectionView.footer.noticeNoMoreData()
    }
}

// MARK: - UICollectionViewDataSource
extension AllListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allListVM.rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        // 2.给cell设置数据
        cell.anchor = allListVM.rooms[(indexPath as NSIndexPath).item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AllListViewController: UICollectionViewDelegate {
    
}

