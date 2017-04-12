//
//  ProfileViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit


private let KProfileViewCellID = "KProfileViewCellID"

class ProfileViewController: BaseViewController {
    // MARK: - lazy
    fileprivate lazy var headerView: ProfileHeaderView = {
        let hdView = ProfileHeaderView.profileHeaderView()
        hdView.delegate = self
        return hdView
    }()

    
    fileprivate lazy var tableView: UITableView = {
        let tbView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tbView.dataSource = self
        tbView.delegate = self
//        tbView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: KProfileViewCellID)
        return tbView
    }()
    
    fileprivate lazy var dataArr = [ProfileModel]()   // 数据源
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: -
extension ProfileViewController {
    override func setUpMainView() {
        // 0.给ContentView进行赋值
        contentView = tableView
        tableView.frame = CGRect(x: 0, y: -20, width: kScreenW, height: self.view.height)
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        loadData()
        
        super.setUpMainView()
    }
    
    func loadData() {
        DispatchQueue.global().async {  
            let row1Data = ProfileModel(icon: "order_yellowMark", title: "开播提示")
            let row2Data = ProfileModel(icon: "order_yellowMark", title: "票务查询")
            let row3Data = ProfileModel(icon: "order_yellowMark", title: "设置选项")
            let row4Data = ProfileModel(icon: "order_yellowMark", title: "手游中心", detailTitle: "玩游戏领鱼丸")
            self.dataArr.append(row1Data)
            self.dataArr.append(row2Data)
            self.dataArr.append(row3Data)
            self.dataArr.append(row4Data)

            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
                self.loadDataFinished()
            })
        }
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return dataArr.count
        }else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: KProfileViewCellID)
        if cell == nil {
             cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: KProfileViewCellID)
             cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        
        let model = dataArr[(indexPath as NSIndexPath).row]
        cell!.textLabel?.text = model.title
        cell!.imageView?.image = UIImage(named: model.icon)
        cell!.detailTextLabel?.text = model.detailTitle
        
        return cell!
    }
    }

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
                case 0: // 开播提示
                    break
                case 1: // 票务查询
                    let webviewVc = WKWebViewController(navigationTitle: "票务中心", urlStr: "http://www.douyu.com/h5mobile/eticket/dealLog")
                    show(webviewVc, sender: nil)
                case 2: //
                    break
                case 3: // 手游中心
                    let gameCenterVc = GameCenterViewController()
                    show(gameCenterVc, sender: nil)
                default:
                    break
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: ProfileHeaderViewDelegate {
    func ProfileHeaderViewSettingBtnClicked() {
        let settingVC = SettingViewController(style: UITableViewStyle.grouped)
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    func ProfileHeaderViewLetterBtnClicked() {
        self.show(UIViewController(), sender: nil)
    }
    
    func ProfileHeaderViewLoginBtnClicked() {
        self.show(UIViewController(), sender: nil)
    
    }
    
    func ProfileHeaderViewRegistBtnClicked() {
        self.show(UIViewController(), sender: nil)
    }
    
    func ProfileHeaderViewMenuDidClicked(_ view: UIView) {
        let tag = view.tag as Int
        switch (tag) {
            case 101:
                show(WKWebViewController(navigationTitle: "排行榜", urlStr: "https://www.douyu.com/directory/rank_list/game"), sender: self)
            case 102:
                show(WKWebViewController(navigationTitle: "我的关注", urlStr: "https://www.douyu.com/room/my_follow"), sender: self)
            case 103:
                print("103")
            case 104:
                show(WKWebViewController(navigationTitle: "鱼翅充值", urlStr: "https://cz.douyu.com/"), sender: self)
                print("104")
        default:
                print("default")
        }
    }
    
}
