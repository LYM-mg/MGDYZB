//
//  ProfileHeaderView.swift
//  MGDYZB
//
//  Created by ming on 16/10/30.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mgKProfileHeaderViewID

import UIKit

// MARK:- 定义协议
@objc
protocol ProfileHeaderViewDelegate: NSObjectProtocol {
    @objc optional func ProfileHeaderViewMenuDidClicked(_ view: UIView)
    @objc optional func ProfileHeaderViewSettingBtnClicked()
    @objc optional func ProfileHeaderViewLetterBtnClicked()
    @objc optional func ProfileHeaderViewLoginBtnClicked()
    @objc optional func ProfileHeaderViewRegistBtnClicked()
}


class ProfileHeaderView: UIView {
    @IBOutlet weak var topCon: NSLayoutConstraint!
    var delegate: ProfileHeaderViewDelegate?
    
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    // 快速从XIB创建ProfileHeaderView
    class func profileHeaderView() -> ProfileHeaderView {
        return Bundle.main.loadNibNamed("ProfileHeaderView", owner: nil, options: nil)!.first as! ProfileHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topCon.constant = (kScreenH==812.0) ? 35 : 20
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.white.cgColor
        registBtn.layer.borderWidth = 1
        registBtn.layer.borderColor = UIColor.white.cgColor
    }
}

// MARK: - action
extension ProfileHeaderView {
    
    @IBAction func settingBtnClick(_ sender: UIButton) {
        delegate?.ProfileHeaderViewSettingBtnClicked!()
    }

    @IBAction func letterBtnClick(_ sender: UIButton) {
        delegate?.ProfileHeaderViewLetterBtnClicked!()
    }

    @IBAction func loginBtnClick(_ sender: UIButton) {
        delegate?.ProfileHeaderViewLoginBtnClicked!()
    }
    
    @IBAction func registBtnClick(_ sender: UIButton) {
        delegate?.ProfileHeaderViewRegistBtnClicked!()
    }

    @IBAction func menuClick(_ tap: UITapGestureRecognizer) {
        delegate?.ProfileHeaderViewMenuDidClicked!(tap.view!)
    }
}
