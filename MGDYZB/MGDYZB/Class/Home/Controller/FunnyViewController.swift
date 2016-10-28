//
//  FunnyViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit
private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseViewController {

    // MARK: 懒加载ViewModel对象
    private lazy var funnyVM : FunnyViewModel = FunnyViewModel()

    private lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(kNormalItemW, kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize.zero
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)
        
        // 3.注册
        collectionView.registerNib(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.registerNib(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        super.setUpUI()
        
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
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return funnyVM.anchorGroups.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funnyVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /// 其他组数据
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath) as! CollectionNormalCell
        
        // 2.给cell设置数据
        cell.anchor = funnyVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FunnyViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeaderViewID, forIndexPath: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headerView.group = funnyVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}




