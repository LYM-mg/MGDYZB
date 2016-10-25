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
    private lazy var titlesView: TitlesView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitlesViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let tsView = TitlesView(frame: titleFrame, titles: titles)
        return tsView
    }()
}

// MARK: - 初始化UI
extension HomeViewController {
    private func setUpMainView() {
        view.addSubview(titlesView)
    }
}
