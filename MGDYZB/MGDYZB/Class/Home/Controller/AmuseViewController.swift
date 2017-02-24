//
//  AmuseViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class AmuseViewController: BaseViewController {

    // MARK: 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: kItemMargin, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        // 3.注册
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- 设置UI界面
extension AmuseViewController {
    override func setUpUI() {
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setUpUI()
        
    }
}

// MARK:- 请求数据
extension AmuseViewController {
     func loadData() {
        // 1.请求数据
        amuseVM.loadAmuseData {
            // 1.1.刷新表格
            self.collectionView.reloadData()
            
            // 2.数据请求完成
            self.loadDataFinished()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension AmuseViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// 其他组数据
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        // 2.给cell设置数据
        cell.anchor = amuseVM.anchorGroups[(indexPath as NSIndexPath).section].anchors[(indexPath as NSIndexPath).item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension AmuseViewController: UICollectionViewDelegate {
    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headerView.group = amuseVM.anchorGroups[(indexPath as NSIndexPath).section]
        
        return headerView
    }
}
