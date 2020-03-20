//
//  CollectionPrettyCell.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK:- 定义模型
    var anchor : AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if let online = anchor.online {
                if online >= 10000.0 {
                    onlineStr = "\(String(describing: online/10000))万人在线"
                } else {
                    onlineStr = "\(String(describing: online))人在线"
                }
            }else {
                onlineStr = "无人在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControl.State())
            onlineBtn.sizeToFit()
            
            // 2.昵称的显示
            nickNameBtn.setTitle(anchor.nickname, for: UIControl.State())
            
            // 3.设置位置(所在的城市)
            cityBtn.setTitle(anchor.anchor_city, for: UIControl.State())

            // 4.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL, placeholder: #imageLiteral(resourceName: "placehoderImage"))
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 6
        iconImageView.clipsToBounds = true
    }
}
