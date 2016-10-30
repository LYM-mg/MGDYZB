//
//  ProfileViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

private let KProfileViewCellID = "KProfileViewCellID"

class ProfileViewController: BaseViewController {
    // MARK: - lazy
    private lazy var headerView: ProfileHeaderView = {
        let hdView = ProfileHeaderView.profileHeaderView()
        hdView.delegate = self
        return hdView
    }()

    
    private lazy var tableView: UITableView = {
        let tbView = UITableView(frame: self.view.bounds, style: UITableViewStyle.Grouped)
        tbView.dataSource = self
        tbView.delegate = self
//        tbView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: KProfileViewCellID)
        return tbView
    }()
    
    private lazy var dataArr = [ProfileModel]()   // 数据源
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

// MARK: -
extension ProfileViewController {
    override func setUpUI() {
        // 0.给ContentView进行赋值
        contentView = tableView
        tableView.frame = CGRectMake(0, -20, kScreenW, self.view.height)
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        loadData()
        
        super.setUpUI()
    }
    
    func loadData() {
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            let row1Data = ProfileModel(icon: "order_yellowMark", title: "开播提示")
            let row2Data = ProfileModel(icon: "order_yellowMark", title: "票务查询")
            let row3Data = ProfileModel(icon: "order_yellowMark", title: "设置选项")
            let row4Data = ProfileModel(icon: "order_yellowMark", title: "手游中心", detailTitle: "玩游戏领鱼丸")
            self.dataArr.append(row1Data)
            self.dataArr.append(row2Data)
            self.dataArr.append(row3Data)
            self.dataArr.append(row4Data)

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.loadDataFinished()
            })
        }
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return dataArr.count
        }else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(KProfileViewCellID)
        if cell == nil {
             cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: KProfileViewCellID)
             cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        let model = dataArr[indexPath.row]
        cell!.textLabel?.text = model.title
        cell!.imageView?.image = UIImage(named: model.icon)
        if model.detailTitle == "" {
            
        }else {
            cell!.detailTextLabel?.text = model.detailTitle
        }
        
        return cell!
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    
}

// MARK: - UITableViewDelegate
extension ProfileViewController: ProfileHeaderViewDelegate {
    func ProfileHeaderViewSettingBtnClicked() {
        let settingVC = SettingViewController(style: UITableViewStyle.Grouped)
        self.showViewController(settingVC, sender: nil)
    }
    
    func ProfileHeaderViewLetterBtnClicked() {
        self.showViewController(UIViewController(), sender: nil)
    }
    
    func ProfileHeaderViewLoginBtnClicked() {
        self.showViewController(UIViewController(), sender: nil)
    
    }
    
    func ProfileHeaderViewRegistBtnClicked() {
        self.showViewController(UIViewController(), sender: nil)
    }
    
    func ProfileHeaderViewMenuDidClicked(view: UIView) {
        let tag = view.tag as Int
        switch (tag) {
            case 101:
                print("101")
            case 102:
                print("102")
            case 103:
                print("103")
            case 104:
                print("104")
        default:
                print("default")
        }
    }
    
}