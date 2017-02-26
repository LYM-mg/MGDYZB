//
//  SettingCell.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
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
        swithView.tintColor = UIColor.green
        return swithView
    }()
    
    
    class func cellWithTbaleView(_ tableView: UITableView , style: UITableViewCellStyle) -> SettingCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: KSettingCellID) as? SettingCell
        if (cell == nil) {
            cell = SettingCell(style: style, reuseIdentifier: KSettingCellID)
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension SettingCell {
    fileprivate func setUpData() {
        self.textLabel!.text = item!.title
        self.imageView!.image = UIImage(named: item!.icon)
        self.detailTextLabel!.text = item!.subTitle
    }
    
    fileprivate func setUpAccessoryView() {
        if item!.isKind(of: ArrowItem.classForCoder()) { // 箭头
            self.accessoryType = .disclosureIndicator
        }else if item!.isKind(of: SwitchItem.classForCoder()){ // 开头
            self.accessoryView = self.swithView
        }else{
            self.accessoryView = nil
            self.accessoryType = .none
        }
    }

}
