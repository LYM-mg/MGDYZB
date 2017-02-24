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
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
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
        cell.anchor = funnyVM.anchorGroups[(indexPath as NSIndexPath).section].anchors[(indexPath as NSIndexPath).item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FunnyViewController: UICollectionViewDelegate {
    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headerView.group = funnyVM.anchorGroups[(indexPath as NSIndexPath).section]
        
        return headerView
    }
}




