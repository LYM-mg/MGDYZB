//
//  SearchResultViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/4/10.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit
import SafariServices

class SearchResultViewController: UIViewController {
    // MARK: - 懒加载属性
    fileprivate lazy var searchVM: SearchViewModel = SearchViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin/2
        layout.sectionInset = UIEdgeInsets(top: 5, left: kItemMargin/2, bottom: 0, right: kItemMargin/2)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    fileprivate lazy var searchBar: UISearchBar =  {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 10, y: 22, width: MGScreenW * 0.9, height: 30)
        searchBar.placeholder = "请输入🔍关键字"
        searchBar.showsCancelButton = true //显示“取消”按钮
        searchBar.barTintColor = UIColor.white
        searchBar.keyboardType = UIKeyboardType.default
        searchBar.delegate = self
//        searchBar.setBackgroundImage(#imageLiteral(resourceName: "navigationBarBackgroundImage"), for: .any, barMetrics: .default)
        return searchBar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: - 设置UI
extension SearchResultViewController {
    func setUpMainView() {
        
        view.addSubview(collectionView)
        UIView.animate(withDuration: 0.8) {
            self.searchBar.frame = CGRect(x: 10, y: 22, width: MGScreenW-20, height: 30)
            self.navigationController?.view.addSubview(self.searchBar)
        }
        for view in searchBar.subviews {
            for subView in view.subviews {
                if NSStringFromClass(subView.classForCoder) == "UINavigationButton" {
                    let btn = subView as? UIButton
                    btn?.setTitleColor(UIColor.blue, for: .normal)
//                    btn?.backgroundColor = UIColor.orange
                    btn?.setTitle("取消" , for: .normal)
                }
                if NSStringFromClass(subView.classForCoder) == "UISearchBarTextField" {
                    let textField = subView as? UITextField
                    textField?.tintColor = UIColor.gray
                }
            }
        }
        
        
        if #available(iOS 9, *) {
            if traitCollection.forceTouchCapability == .available {
                registerForPreviewing(with: self, sourceView: self.view)
            }
        }
        self.navigationController!.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigationBarBackgroundImage"), for: .default)
        setUpRefresh()
    }
}

// MARK: - loadData
extension SearchResultViewController {
    fileprivate func loadData() {
        // 1.请求数据
        searchVM.searchDataWithKeyword { [weak self] in
            // 1.1.刷新表格
            self!.collectionView.header.endRefreshing()
            self!.collectionView.footer.endRefreshing()
            self?.collectionView.reloadData()
        }
    }
    
    
    fileprivate func setUpRefresh() {
        // MARK: - 下拉
        self.collectionView.header = MJRefreshGifHeader(refreshingBlock: { [weak self]() -> Void in
            self!.searchVM.anchorGroups.removeAll()
            self!.searchVM.offset = 0
            self!.loadData()
            })
        // MARK: - 上拉
        self.collectionView.footer = MJRefreshAutoGifFooter(refreshingBlock: {[weak self] () -> Void in
            self!.searchVM.offset += 20
            self!.loadData()
            })
        self.collectionView.header.isAutoChangeAlpha = true
        self.collectionView.footer.noticeNoMoreData()
    }
}

// MARK: - UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)  as! CollectionNormalCell
        if searchVM.anchorGroups.count > 0 {
            cell.anchor = searchVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SearchResultViewController: UICollectionViewDelegate {
    @objc(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
        headerView.group = searchVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出对应的主播信息
        let anchor = searchVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        
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

// MARK: - UIViewControllerPreviewingDelegate
extension SearchResultViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return nil }
        guard let cell = collectionView.cellForItem(at: indexPath) else { return nil }
        
        if #available(iOS 9.0, *) {
            previewingContext.sourceRect = cell.frame
        }
        
        var vc = UIViewController()
        let anchor = searchVM.anchorGroups[indexPath.section].anchors[indexPath.item]
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

extension SearchResultViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//        self.showHudInViewWithMode(view: self.view, hint: "正在搜索", mode: .indeterminate, imageName: nil)
        if var textToSearch = searchController.searchBar.text {
            //去除搜索字符串左右和中间的空格
            textToSearch = textToSearch.trimmingCharacters(in: CharacterSet.whitespaces)
            searchVM.keyword = textToSearch
            loadData()
            collectionView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchResultViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        let btn: UIButton = searchBar.value(forKeyPath: "_cancelButton") as! UIButton // 修改searchBar右侧按钮的文字
        btn.setTitle("取消", for: .normal)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.removeFromSuperview()
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        //去除搜索字符串左右和中间的空格
        let textToSearch = searchBar.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        searchVM.keyword = textToSearch
        loadData()
        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
