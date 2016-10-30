//
//  BaseSettingViewController.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class BaseSettingViewController: UITableViewController {

    
    lazy var groups = [GroupItem]()
    /** 缓存大小 */
    var total: UInt64 = 0

    override init(style: UITableViewStyle) {
        super.init(style: UITableViewStyle.Grouped)
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
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.groups.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 获取当前的组模型
        let group = self.groups[section];
        
        return group.items!.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 1.创建cell
       let cell = SettingCell.cellWithTbaleView(tableView, style: UITableViewCellStyle.Value1)
        
        // 获取对应的组模型
        let group = self.groups[indexPath.section];
        
        // 获取对应的行模型
        let item = group.items![indexPath.row]
        
        // 2.给cell传递模型
        cell.item = item
        
        if (indexPath.section == 2) {
            let str = getSize()
            cell.detailTextLabel!.text = str
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 获取组模型
        let group = self.groups[section];
        
        return group.headerTitle
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        // 获取组模型
        let group = self.groups[section];
        
        return group.footerTitle
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 取出对应的组模型
        let group = self.groups[indexPath.section];
        
        // 取出对应的行模型
        let item = group.items![indexPath.row];
        
        if ((item.operationBlock) != nil) {
            item.operationBlock!(indexPath: indexPath);
            return
        }
        
        // 判断下是否需要跳转
        if item.isKindOfClass(ArrowItem.classForCoder()) {
            
            // 箭头类型,才需要跳转
            let arrowItem = item as! ArrowItem
            
            if (arrowItem.descVcClass == nil) {return}
            
            if arrowItem.descVcClass!.isSubclassOfClass(UILabel.classForCoder()) {
                // 创建跳转控制器
//                HomeWebVC *vc = [[HomeWebVC alloc] initWithNavigationTitle:"联系客服" withUrlStr:"http://cs.9158.com/client_phone.aspx?type=button&uid=all&all&siteid=117&style=default&cid=&name=&sex=0&Random=1"];
//                vc.view.backgroundColor = MGRandomRGBColor;
//                [self.navigationController pushViewController:vc animated:YES];
            }else {  //  guard let vc = NSClassFromString(arrowItem.descVcClass)() as? UIViewController else { return }
                // 创建跳转控制器
                let vc = (arrowItem.descVcClass as! UIViewController.Type).init()
                vc.view.backgroundColor = UIColor.randomColor();
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}

extension BaseSettingViewController {
    
    // 计算size
    private func getSize() -> String {
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

