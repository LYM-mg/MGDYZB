//
//  SettingCell.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

private let KSettingCellID = "KSettingCellID"

class SettingCell: UITableViewCell {

    /** 类型 */
    var item: SettingItem? {
        didSet {
            // 设置cell的内容,获取对应的行
            setUpData()
            
            // 设置辅助视图
            setUpAccessoryView()
        }
    }
    
    lazy var swithView: UISwitch = {
        let swithView = UISwitch()
        swithView.tintColor = UIColor.greenColor()
        return swithView
    }()
    
    
    class func cellWithTbaleView(tableView: UITableView , style: UITableViewCellStyle) -> SettingCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(KSettingCellID) as? SettingCell
        if (cell == nil) {
            cell = SettingCell(style: style, reuseIdentifier: KSettingCellID)
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension SettingCell {
    private func setUpData() {
        self.textLabel!.text = item!.title
        self.imageView!.image = UIImage(named: item!.icon)
        self.detailTextLabel!.text = item!.subTitle
    }
    
    private func setUpAccessoryView() {
        if item!.isKindOfClass(ArrowItem.classForCoder()) { // 箭头
            self.accessoryType = .DisclosureIndicator
        }else if item!.isKindOfClass(SwitchItem.classForCoder()){ // 开头
            self.accessoryView = self.swithView
        }else{
            self.accessoryView = nil
            self.accessoryType = .None
        }
    }

}
