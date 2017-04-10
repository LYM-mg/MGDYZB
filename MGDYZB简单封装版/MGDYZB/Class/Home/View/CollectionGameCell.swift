//
//  CollectionGameCell.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    
    // MARK: 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
//            iconImageView.image = UIImage(named: "home_more_btn")
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }

//            titleLabel.text = baseGame?.tag_name
//            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
//                if baseGame?.tag_name == "更多" {
//                    iconImageView.image = #imageLiteral(resourceName: "home_more_btn")
//                }else {
//                    iconImageView.kf.setImage(with: (with: iconURL), placeholder: #imageLiteral(resourceName: "placehoderImage"))
////                    iconImageView.kf.setImage(with: iconURL, placeholder: #imageLiteral(resourceName: "placehoderImage"))
////                    iconImageView.kf.setImage(with: iconURL)
//                }
//            } else {
//                iconImageView.image = UIImage(named: "home_more_btn")
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = self.iconImageView.frame.size.height*0.5
        iconImageView.clipsToBounds = true
//        frame = CGRect(x: 0, y: 0, width: 80, height: 90)
        lineView.isHidden = true
//        backgroundColor = UIColor.orangeColor()
    }

}
