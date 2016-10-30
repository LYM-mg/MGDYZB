//
//  GuardScrollView.swift
//  MGDYZB
//
//  Created by ming on 16/10/28.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class GuardScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.bounces = false
        self.pagingEnabled = true
        self.contentSize = CGSizeMake(kScreenW*3, kScreenH)
        
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GuardScrollView {
    private func setUpUI() {
        for var i = 0; i<=3; i++ {
            let imageV = UIImageView(frame: CGRectMake(kScreenW*CGFloat(i), 0, kScreenW, kScreenH))
            var device = 0
            if kScreenH*2 == 960 {
               device = 100
            } else if (kScreenH*2 == 1136) {
                device = 200
            } else if (kScreenH*2 == 1334) {
                device = 300
            } else {
                device = 400
            }
            
            imageV.image = UIImage(named: String(format: "%i%i", arguments: [device,i+2]))
            self.addSubview(imageV)
            
            if(i == 2) {
                let deformationBtn  = DeformationButton(frame: CGRectMake(kScreenW/2-187/4+kScreenW*2, kScreenH/2+100, 187/2, 187/2))
                deformationBtn.contentColor  =  UIColor.clearColor()
                deformationBtn.progressColor  = UIColor(r: 126, g: 235, b: 251)
                deformationBtn.forDisplayButton.setImage(UIImage(named: "按前"), forState: .Normal)
                let bgImage  = UIImage(named: "按前")
                deformationBtn.forDisplayButton.setBackgroundImage(bgImage, forState: .Normal)
                deformationBtn.addTarget(self, action: Selector("EnterApp:"), forControlEvents: .TouchUpInside)
                self.addSubview(deformationBtn)
            }
        }
    }
    
    // 先进入App引导界面，通过点击按钮进入主界面
    @objc func EnterApp(sender: UIButton) {
        sender.userInteractionEnabled = false
        NSNotificationCenter.defaultCenter().postNotificationName(KEnterHomeViewNotification, object: nil, userInfo: ["sender": sender])
    }
}
