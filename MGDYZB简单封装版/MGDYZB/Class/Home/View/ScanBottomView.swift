//
//  ScanBottomView.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/4/11.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

enum MGButtonType: Int {
    case photo, flash, myqrcode
}

class ScanBottomView: UIView {
    fileprivate lazy var myButtons: [UIButton] = [UIButton]()
    var btnClickBlcok: ((_ view: ScanBottomView, _ type: MGButtonType)->())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI
extension ScanBottomView {
    func setUpUI() {
        // 设置UI
        setUpBtn(image: UIImage(named: "MGCodeScan.bundle/qrcode_scan_btn_flash_nor.png")!, highlightedImage: UIImage(named: "MGCodeScan.bundle/qrcode_scan_btn_flash_down.png")!, title: "",type: .flash)
        setUpBtn(image: UIImage(named: "MGCodeScan.bundle/qrcode_scan_btn_photo_nor.png")!, highlightedImage: UIImage(named: "MGCodeScan.bundle/qrcode_scan_btn_photo_down.png")!, title: "",type: .photo)
        setUpBtn(image: UIImage(named: "MGCodeScan.bundle/qrcode_scan_btn_myqrcode_nor.png")!, highlightedImage: UIImage(named: "MGCodeScan.bundle/qrcode_scan_btn_myqrcode_down.png")!, title: "",type: .myqrcode)
        
        // 布局UI
        let margin: CGFloat = 10
        let count: CGFloat = CGFloat(myButtons.count)
        let width = (self.frame.width - margin*CGFloat(count+1))/count
        let height = self.frame.height - margin*2.5
        let y = margin
        for (i,btn) in myButtons.enumerated() {
            let x = CGFloat(i)*width + margin
            btn.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func setUpBtn(image: UIImage,highlightedImage: UIImage,title: String,type: MGButtonType) {
        let btn = ScanButton(image: image, highlightedImage: highlightedImage,title: title, target: self, action: #selector(self.btnClick(btn:)))
        btn.tag = type.rawValue
        self.addSubview(btn)
        myButtons.append(btn)
    }
    
    @objc func btnClick(btn: UIButton) {
        switch btn.tag {
            case 0:
                btn.isSelected = !btn.isSelected
            case 1:
                btn.isSelected = !btn.isSelected
            case 2:
                btn.isSelected = !btn.isSelected
            default: break
        }
       
        if self.btnClickBlcok != nil {
            btnClickBlcok!(self,MGButtonType(rawValue: btn.tag)!)
        }
    }
}
