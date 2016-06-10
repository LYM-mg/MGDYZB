//
//  MGTitleBtn.swift
//  MGHuaTian
//
//  Created by ming on 16/6/10.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class MGTitleBtn: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("主题", forState: .Normal)
        setImage(UIImage(named: "hp_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "hp_arrow_up"), forState: .Selected)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(15)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView?.frame.origin.x < titleLabel?.frame.origin.x {
            titleLabel?.frame.origin.x = imageView!.frame.origin.x
            imageView?.frame.origin.x = CGRectGetMaxX(titleLabel!.frame) + 10
        }
        
    }


}
