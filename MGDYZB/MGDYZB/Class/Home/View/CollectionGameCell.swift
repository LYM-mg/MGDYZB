//
//  CollectionGameCell.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            
            if let iconURL = NSURL(string: baseGame?.icon_url ?? "") {
                if baseGame?.tag_name == "更多" {
                    iconImageView.image = UIImage(named: "home_more_btn")
                }else {
                    iconImageView.kf_setImageWithURL(iconURL)
                }
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = self.iconImageView.frame.size.height*0.5
        iconImageView.clipsToBounds = true
        frame = CGRectMake(0, 0, 80, 90)
//        backgroundColor = UIColor.orangeColor()
    }

}
