//
//  RecommendViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit


private let kItemMargin : CGFloat = 10              /** item之间的间距 */
private let kHeaderViewH : CGFloat = 50             /** item之间的间距 */
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2 /** item的宽度 */
let kNormalItemH = kNormalItemW * 3 / 4             /** 普通item的高度 */
let kPrettyItemH = kNormalItemW * 4 / 3             /** 颜值的item的高度 */

private let kNormalCellID = "kNormalCellID"         /** 普通item的循环利用标识符 */
let kPrettyCellID = "kPrettyCellID"         /** 颜值的item的循环利用标识符 */
private let kHeaderViewID = "kHeaderViewID"                 /** 每一组头部（section）的循环利用标识符 */

class RecommendViewController: UIViewController {

    
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(kNormalItemW, kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSizeMake(kScreenW, kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // 3.注册
        collectionView.registerNib(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.registerNib(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 初始化UI
extension RecommendViewController {
    private func setUpUI()  {
        view.addSubview(collectionView)
        loadData()
    }
}

// MARK: - 发送网络请求 loadData
extension RecommendViewController {
    private func loadData() {
        // 1.请求推荐数据
        recommendVM.requestData { () -> () in
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
        }
    }
}


// MARK: - UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {  /// 颜值
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCellWithReuseIdentifier(kPrettyCellID, forIndexPath: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {                    /// 其他组数据
            // 1.取出Cell
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath) as! CollectionNormalCell
            
            // 2.给cell设置数据
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return cell
        }
    }
}


// MARK: - UICollectionViewDelegate
extension RecommendViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeaderViewID, forIndexPath: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}

func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: NSIndexPath) -> CGSize {
    if indexPath.section == 1 {
        return CGSize(width: kNormalItemW, height: kPrettyItemH)
    }
    
    return CGSize(width: kNormalItemW, height: kNormalItemH)
}

