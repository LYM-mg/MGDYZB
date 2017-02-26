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
        self.isPagingEnabled = true
        self.contentSize = CGSize(width: kScreenW*3, height: kScreenH)
        
        setUpMainView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GuardScrollView {
    fileprivate func setUpMainView() {
        for i in stride(from: 0, to: 3, by: 1) {
            let imageV = UIImageView(frame: CGRect(x: kScreenW*CGFloat(i), y: 0, width: kScreenW, height: kScreenH))
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
                let deformationBtn  = DeformationButton(frame: CGRect(x: kScreenW/2-44+kScreenW*2, y: kScreenH/2+100, width: 187/2, height: 187/2))
                deformationBtn.contentColor  =  UIColor.clear
                deformationBtn.progressColor  = UIColor(r: 126, g: 235, b: 251)
                deformationBtn.forDisplayButton.setImage(UIImage(named: "按前"), for: UIControlState())
                let bgImage  = UIImage(named: "按前")
                deformationBtn.forDisplayButton.setBackgroundImage(bgImage, for: UIControlState())
                deformationBtn.addTarget(self, action: #selector(GuardScrollView.EnterApp(_:)), for: .touchUpInside)
                self.addSubview(deformationBtn)
            }
        }
    }
    
    // 先进入App引导界面，通过点击按钮进入主界面
    @objc func EnterApp(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: KEnterHomeViewNotification), object: nil, userInfo: ["sender": sender])
    }
}
