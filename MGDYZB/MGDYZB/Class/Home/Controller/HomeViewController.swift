//
//  HomeViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/25.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

private let kTitlesViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        automaticallyAdjustsScrollViewInsets = false

        // 1.创建UI
        setUpMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    // MARK: - lazy
    private lazy var homeTitlesView: HomeTitlesView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitlesViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let tsView = HomeTitlesView(frame: titleFrame, titles: titles)
        tsView.deledate = self
        return tsView
    }()
    private lazy var homeContentView: HomeContentView = { [weak self] in
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitlesViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH+kTitlesViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        let contentView = HomeContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
}

// MARK: - 初始化UI
extension HomeViewController {
    private func setUpMainView() {
        view.addSubview(homeTitlesView)
        view.addSubview(homeContentView)
    }
}

// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : HomeTitlesViewDelegate {
    func HomeTitlesViewDidSetlected(homeTitlesView: HomeTitlesView, selectedIndex: Int) {
        homeContentView.setCurrentIndex(selectedIndex)
    }
}


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : HomeContentViewDelegate {
    func HomeContentViewDidScroll(contentView: HomeContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        homeTitlesView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

