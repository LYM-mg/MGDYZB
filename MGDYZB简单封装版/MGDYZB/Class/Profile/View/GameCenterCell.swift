//
//  GameCenterCell.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/27.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit
import SnapKit

class GameCenterCell: UICollectionViewCell {
    fileprivate lazy var leftView = UIView()
    fileprivate lazy var rightView = UIView()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placehoderImage")
        imageView.cornerRadius = CGFloat(10)
        return imageView
    }()

    
    fileprivate lazy var titleLable: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.textColor = UIColor.black
        lb.text = "王者荣耀"
        return lb
    }()

    fileprivate lazy var subTitleLable: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.gray
        lb.text = "dsadsadsadsadas,你好啊"
        lb.numberOfLines = 2
        return lb
    }()
    fileprivate lazy var downloadLable: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.red
        lb.text = "下载：93万"
        return lb
    }()

    fileprivate lazy var downloadBtn = { () -> UIButton in 
        let btn = UIButton()
        btn.setTitle("下载", for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.cornerRadius = CGFloat(6)
        btn.setTitleColor(UIColor.blue, for: .selected)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(leftView)
        addSubview(rightView)
        
        leftView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(rightView.snp.left)
            make.width.equalTo(rightView.snp.width).multipliedBy(0.8)
        }
        rightView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
        }
        
        setUpUI()
    }
    
    var model: GameCenterModel? {
        didSet {
//             "title": "全民神将", "depict": "打造五星上将，领6千鱼丸送鱼翅"  "show_count": 200000,
//            "down_ios_url": "https: //itunes.apple.com/cn/app/chui-zi-san-guo-50ren-tong/id1007891923?l=zh&ls=1&mt=8"
//            "gift_icon": "585e89bbe15ab36454a0d18d14d2ebb6.png",
//            "icon": "68777219db88e8c132e7f51cf554184f.jpg",
//            "icon_small": "843759872552df94a533e65b29a7bc63.png",
            
            
//            imageView.kf.setImage(with: <#T##Resource?#>, placeholder: #imageLiteral(resourceName: "placehoderImage"))
            titleLable.text = model?.title ?? "MG明明"
            subTitleLable.text = model?.depict ?? "欢迎关注我，黑恶嘿嘿"
            downloadLable.text = "下载：\(model!.show_count!)万"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameCenterCell {
    fileprivate func setUpUI() {
        // 左边👈
        leftView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
        }
        
        // 右边👉
        rightView.addSubview(downloadBtn)
        rightView.addSubview(titleLable)
        rightView.addSubview(subTitleLable)
        rightView.addSubview(downloadLable)
        downloadBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(35)
            make.width.equalTo(60)
        }
        titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalTo(imageView)
        }
        subTitleLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable)
            make.top.equalTo(titleLable.snp.bottom).offset(2)
            make.right.equalTo(downloadBtn.snp.left)
        }
        downloadLable.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable)
            make.bottom.equalTo(imageView)
            make.right.equalToSuperview()
        }
    }
}
