//
//  RecommendViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg

import UIKit
import SafariServices

private let kCycleViewH = kScreenW * 3 / 8          /** 轮播器的高度 */
let kGameViewH : CGFloat = 90               /** 游戏View的高度 */
let kItemMargin : CGFloat = 10              /** item之间的间距 */
let kHeaderViewH : CGFloat = 50             /** item之间的间距 */
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2 /** item的宽度 */
let kNormalItemH = kNormalItemW * 3 / 4             /** 普通item的高度 */
let kPrettyItemH = kNormalItemW * 4 / 3             /** 颜值的item的高度 */

let kNormalCellID = "kNormalCellID"         /** 普通item的循环利用标识符 */
let kPrettyCellID = "kPrettyCellID"         /** 颜值的item的循环利用标识符 */
let kHeaderViewID = "kHeaderViewID"                 /** 每一组头部（section）的循环利用标识符 */

class RecommendViewController: BaseViewController {
    var headerIndexPath: IndexPath?
    // MARK:- ViewModel
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    // MARK:- 懒加载属性
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView(frame: CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH))
        return cycleView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        gameView.backgroundColor = UIColor.red
        return gameView
    }()

    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
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
        automaticallyAdjustsScrollViewInsets = false
        setUpRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - 初始化UI
extension RecommendViewController {
     override func setUpMainView()  {
        // 0.给ContentView进行赋值
        contentView = collectionView
        
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        super.setUpMainView()
    }
}

// MARK: - 发送网络请求 loadData
extension RecommendViewController {
    fileprivate func setUpRefresh() {
        weak var weakSelf = self
        // 头部刷新
        self.collectionView.header = MJRefreshGifHeader(refreshingBlock: {
            let strongSelf = weakSelf
            strongSelf?.recommendVM.anchorGroups.removeAll()
            strongSelf?.recommendVM.bigDataGroup.anchors.removeAll()
            strongSelf?.recommendVM.prettyGroup.anchors.removeAll()
            strongSelf?.recommendVM.cycleModels.removeAll()
            strongSelf?.loadData()
        })
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        collectionView.header.ignoredScrollViewContentInsetTop = kCycleViewH + kGameViewH
        collectionView.header.isAutoChangeAlpha = true
        self.collectionView.header.beginRefreshing()
    }

    fileprivate func loadData() {
        // 1.请求轮播数据
        recommendVM.requestCycleData {_ in
            self.cycleView.cycleModels = self.recommendVM.cycleModels
            self.collectionView.header.endRefreshing()
        }
        
        // 2.请求推荐数据
        recommendVM.requestData { _ in 
            // 1.展示推荐数据
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            
            if groups.count > 2 {
                // 2.1.移除前两组数据
                groups.removeFirst()
                groups.removeFirst()
            }
            
            // 2.2.添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.icon_url = "home_more_btn"
            moreGroup.tag_name = "更多"
//            moreGroup.tag_id = 0
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            // 3.数据请求完成
            self.loadDataFinished()
            self.collectionView.header.endRefreshing()
        }
    }
}


// MARK: - UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath as NSIndexPath).section == 1 {  /// 颜值
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[(indexPath as NSIndexPath).section].anchors[(indexPath as NSIndexPath).item]
            
            return prettyCell
        } else {                    /// 其他组数据
            // 1.取出Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            
            // 2.给cell设置数据
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension RecommendViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出对应的主播信息
        let anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        // 2.判断是秀场房间&普通房间
        anchor.isVertical == 0 ? pushNormalRoomVc(anchor: anchor) : presentShowRoomVc(anchor: anchor)
    }
    
    fileprivate func presentShowRoomVc(anchor: AnchorModel) {
        // 1.创建SFSafariViewController
        if #available(iOS 9.0, *) {
            let safariVC = SFSafariViewController(url: URL(string: anchor.jumpUrl)!, entersReaderIfAvailable: true)
            // 2.以Modal方式弹出
            present(safariVC, animated: true, completion: nil)
        } else {
            let webVC = WebViewController(navigationTitle: anchor.room_name, urlStr: anchor.jumpUrl)
            // 2.以Modal方式弹出
            present(webVC, animated: true, completion: nil)
        }
    }
    
    fileprivate func pushNormalRoomVc(anchor: AnchorModel) {
        // 1.创建WebViewController
        let webVC = WebViewController(navigationTitle: anchor.room_name, urlStr: anchor.jumpUrl)
        webVC.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 2.以Push方式弹出
        navigationController?.pushViewController(webVC, animated: true)
    }

    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headerView.group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
        
        
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RecommendViewController.headerClick(_:))))
        headerIndexPath = indexPath

        return headerView
    }
    
    @objc fileprivate func headerClick(_ tap: UITapGestureRecognizer) {

        switch headerIndexPath!.section {
            case 0:
                let webVC = WebViewController(navigationTitle: "主机游戏", urlStr: "http://www.douyu.com/directory/game/TVgame")
                navigationController?.pushViewController(webVC, animated: true)
            case 1:
                let webVC = WebViewController(navigationTitle: "美颜", urlStr: "http://www.douyu.com/directory/game/yz")
                navigationController?.pushViewController(webVC, animated: true)
            default:
                let model = recommendVM.anchorGroups[headerIndexPath!.section]
                self.show(HeaderViewDetailController(model: model), sender: self)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        var itemSize = CGSize.zero
        if (indexPath as NSIndexPath).section == 1 {
            itemSize = CGSize(width: kNormalItemW, height: kPrettyItemH)
        } else  {
            itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        }
        return itemSize
    }
}


