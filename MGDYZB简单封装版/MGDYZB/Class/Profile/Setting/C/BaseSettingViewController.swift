//
//  BaseSettingViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg

import UIKit

class BaseSettingViewController: UITableViewController {

    
    lazy var groups = [GroupItem]()
    /** 缓存大小 */
    var total: UInt64 = 0

    override init(style: UITableView.Style) {
        super.init(style: UITableView.Style.grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 获取cachePath文件缓存
        self.getFileSizeWithFileName(self.cachesPath()) { [weak self] (totalSize) -> () in
             self!.total = totalSize;
            // 计算完成就会调用
             self!.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.groups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 获取当前的组模型
        let group = self.groups[section];
        
        return group.items!.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.创建cell
       let cell = SettingCell.cellWithTbaleView(tableView, style: UITableViewCell.CellStyle.value1)
        
        // 获取对应的组模型
        let group = self.groups[(indexPath as NSIndexPath).section];
        
        // 获取对应的行模型
        let item = group.items![(indexPath as NSIndexPath).row]
        
        // 2.给cell传递模型
        cell.item = item
        
        if ((indexPath as NSIndexPath).section == 2) {
            let str = getSize()
            cell.detailTextLabel!.text = str
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 获取组模型
        let group = self.groups[section];
        
        return group.headerTitle
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        // 获取组模型
        let group = self.groups[section];
        
        return group.footerTitle
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取出对应的组模型
        let group = self.groups[(indexPath as NSIndexPath).section];
        
        // 取出对应的行模型
        let item = group.items![(indexPath as NSIndexPath).row];
        
        if ((item.operationBlock) != nil) {
            item.operationBlock!(indexPath);
            return
        }
        
        // 判断下是否需要跳转
        if item.isKind(of: ArrowItem.classForCoder()) {
            
            // 箭头类型,才需要跳转
            let arrowItem = item as! ArrowItem
            
            if (arrowItem.descVcClass == nil)  { return }
            
            if arrowItem.descVcClass!.isSubclass(of: UIWebView.classForCoder()) || arrowItem.descVcClass!.isSubclass(of: WKWebViewController.classForCoder()) {
                // 创建跳转控制器
                let vc = WKWebViewController(navigationTitle: "在线客服", urlStr: "http://webchat.b.qq.com/webchat.htm?sid=2188z8p8p8p8p8p8q8R8K")
                vc.view.backgroundColor = UIColor.randomColor()
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                // 创建跳转控制器
                let vc = (arrowItem.descVcClass as! UIViewController.Type).init()
                vc.view.backgroundColor = UIColor.randomColor()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}

extension BaseSettingViewController {
    
    // 计算size
    fileprivate func getSize() -> String {
        let unit = 1000.0
        let text = "缓存大小";
        var str: String = "";
        if (Double(total) > unit * unit * unit) {
            str = NSString(format: "%.1fGB", Double(total)/unit / unit / unit) as String
        }else if (Double(total) > unit * unit){
            str = NSString(format: "%.1fMB", Double(total)/unit / unit) as String
        }else if (Double(total) > unit){
            str = NSString(format: "%.1fKB", Double(total)/unit) as String
        }else{
            str = NSString(format: "%.1zdB", total) as String
        }
        return String(format: "%@:%@", arguments: [text,str])
    }
}

