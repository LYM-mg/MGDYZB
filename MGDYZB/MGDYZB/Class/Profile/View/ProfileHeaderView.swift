//
//  ProfileHeaderView.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.
// KProfileHeaderViewID

import UIKit

// MARK:- 定义协议
@objc
protocol ProfileHeaderViewDelegate: NSObjectProtocol {
    optional func ProfileHeaderViewMenuDidClicked(view: UIView)
    optional func ProfileHeaderViewSettingBtnClicked()
    optional func ProfileHeaderViewLetterBtnClicked()
    optional func ProfileHeaderViewLoginBtnClicked()
    optional func ProfileHeaderViewRegistBtnClicked()
}


class ProfileHeaderView: UIView {
    var delegate: ProfileHeaderViewDelegate?
    
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    // 快速从XIB创建ProfileHeaderView
    class func profileHeaderView() -> ProfileHeaderView {
        return NSBundle.mainBundle().loadNibNamed("ProfileHeaderView", owner: nil, options: nil).first as! ProfileHeaderView
    }
}

// MARK: - action
extension ProfileHeaderView {
    
    @IBAction func settingBtnClick(sender: UIButton) {
        delegate?.ProfileHeaderViewSettingBtnClicked!()
    }

    @IBAction func letterBtnClick(sender: UIButton) {
        delegate?.ProfileHeaderViewLetterBtnClicked!()
    }

    @IBAction func loginBtnClick(sender: UIButton) {
        delegate?.ProfileHeaderViewLoginBtnClicked!()
    }
    
    @IBAction func registBtnClick(sender: UIButton) {
        delegate?.ProfileHeaderViewRegistBtnClicked!()
    }

    @IBAction func menuClick(tap: UITapGestureRecognizer) {
        delegate?.ProfileHeaderViewMenuDidClicked!(tap.view!)
    }

    
}