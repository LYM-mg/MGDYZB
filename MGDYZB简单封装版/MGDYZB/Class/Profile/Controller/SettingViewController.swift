//
//  SettingViewController.swift
//  DYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class SettingViewController: BaseSettingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "设置"
        // 配置tableView的模型
        // tableView分组样式
        // tableView有多少组,由groups数组决定,记录tableView有多少组
        // tableView每一组对应组模型(GroupItem)
        // 组模型用来描述当前组的一些信息,头部标题,尾部标题,每一组有多少行,每一组有多少行,行模型数组(items)
        // 行模型数组中有多少个行模型,当前组就有多少个cell,每一个cell对应的行模型
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SettingViewController{
    fileprivate func loadData() {
        // 添加第0组模型
        setUpGroup0()
        // 添加第1组模型
        setUpGroup1()
        // 添加第2组模型
        setUpGroup2()
        // 添加第2组模型
        setUpGroup3()
    }
    
    // 第0组
    fileprivate func setUpGroup0() {
        // 创建组模型
        let group = GroupItem()
        group.footerTitle = "开启后，你关注的主播开播时你会收到通知"
        // 创建行模型
        let item = SwitchItem(title: "开播提醒", icon: "RedeemCode")
        
        // [weak self]
        item.operationBlock = { (indexPath)-> () in
            // 这边设置打开开关后的操作
        }
        
        // 创建行模型数组
        group.items = [item]
        
        // 把组模型保存到groups数组
        self.groups.append(group)
    }
    
    // 添加第1组
   fileprivate func setUpGroup1() {
        // 创建行模型
        let item1 = SwitchItem(title: "公聊消息过滤", icon: "MorePush")
        
        // 创建组模型
        let group = GroupItem()
        group.footerTitle = "开启后，显示你与挡圈主播和你的公聊消息"
        // 行模型数组
        group.items = [item1]
        self.groups.append(group)
    }
    
    // 添加第2组
    fileprivate func setUpGroup2() {
       let item1 = ArrowItem(title: "清理缓存", icon: "MoreUpdate")
        
        item1.operationBlock = { [unowned self] (indexPath)-> () in
            // 清空缓存,就是把Cache文件夹直接删掉
            // 删除比较耗时
            self.removeCachesWithCompletion({ [unowned self]  () -> () in
                self.total = 0
                self.tableView.reloadData()
            })
        }

        // 创建组模型
        let group = GroupItem()
        // 行模型数组
        group.items = [item1]
        self.groups.append(group)
    }
    
    // 添加第3组
    fileprivate func setUpGroup3() {
        // 创建行模型
        let item = ArrowItem(title: "赏个好评", icon: "MoreUpdate")
        // 保存跳转控制器类名字符串
        item.operationBlock = { (indexPath)-> () in
            UIApplication.shared.openURL(URL(string: "https://github.com/LYM-mg/MGDYZB")!)
        }
        
        let item1 = ArrowItem(title: "检查新版本", icon: "MoreUpdate")
        item1.operationBlock = { (indexPath)-> () in
            print("没有最新的版本")
        }
        
        let item2 = ArrowItem(title: "拨打电话联系客服", icon: "MoreUpdate")
        item2.operationBlock = { [unowned self] (indexPath)-> () in
            self.takePhone()
        }
        
        let item3 = ArrowItem(title: "在线联系客服", icon: "MoreUpdate")
        item3.descVcClass = WKWebViewController.classForCoder()
        
        let item4 = ArrowItem(title: "关于斗鱼", icon: "MoreUpdate")
        item4.descVcClass = QRCodeViewController.classForCoder()
        
        // 创建组模型数组
        let group = GroupItem()
        group.items = [item,item1,item2,item3,item4]
        group.headerTitle = "明明带你"
        self.groups.append(group)
    }

}

extension SettingViewController {
    fileprivate func takePhone() {
        
        let alertVC = UIAlertController(title: "确定要拨打电话", message: "1292043630", preferredStyle: UIAlertController.Style.actionSheet)
        let phoneAction = UIAlertAction(title: "拨打", style: UIAlertAction.Style.destructive) { (action) -> Void in
            /// 1.第一种打电话(拨打完电话回不到原来的应用，会停留在通讯录里，而且是直接拨打，不弹出提示)
//            UIApplication.sharedApplication().openURL(NSURL(string: String("tel:13750525922"))!)

        
            /// 2.第二种打电话(打完电话后还会回到原来的程序，也会弹出提示，推荐这种)
//            let callWebview = UIWebView()
//            callWebview.loadRequest(NSURLRequest(URL: NSURL(string: "tel:13750525922")!))
//            self.view.addSubview(callWebview)
        
            /// 3.第三种打电话(这种方法也会回去到原来的程序里（注意这里的telprompt），也会弹出提示)
            let str = "telprompt://13750525922"
            UIApplication.shared.openURL(URL(string: str)!)
        }

        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(phoneAction)
        alertVC.addAction(cancelAction)
        self.navigationController?.present(alertVC, animated: true, completion: nil)
    }
    
    fileprivate func clearCaches() {
        OperationQueue().addOperation { () -> Void in
            let documentFolderPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let files = try! FileManager.default.subpathsOfDirectory(atPath: documentFolderPath!)
            for file in files {
                guard let Path = documentFolderPath?.appendingFormat("/%@", file) else {return}
                if FileManager.default.fileExists(atPath: Path) {
                     try! FileManager.default.removeItem(atPath: Path)
                }
            }
            OperationQueue.main.addOperation({ () -> Void in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(UInt64(2.5) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: { () -> Void in
                    print("缓存已清除")
                })
            })
        }
    }
}

