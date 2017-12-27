//
//  RecommendCycleView.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class RecommendCycleView: UIView {
    
    // MARK: - lazy属性
    fileprivate lazy var carouselView: XRCarouselView = { [weak self] in
        let carouselView = XRCarouselView()
        carouselView.time = 2.0
        carouselView.pagePosition = PositionBottomCenter
        carouselView.setPageImage(UIImage(named: "other"), andCurrentImage: UIImage(named: "current"))
        carouselView.delegate = self
        return carouselView
    }()
    
    // MARK: - 模型数组
    var cycleModels:[CycleModel]? {
        didSet {
            guard let cycleModels = cycleModels else { return }
            
            var titlesArr = [String]()
            var picURLArr = [String]()
            for model in cycleModels {
                titlesArr.append(model.title)
                picURLArr.append(model.pic_url)
            }
            carouselView.imageArray = picURLArr
            carouselView.describeArray = titlesArr
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpMainView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        carouselView.frame = self.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 初始化UI
extension RecommendCycleView {
    fileprivate func setUpMainView() {
        addSubview(carouselView)
    }
}


// MARK: - XRCarouselViewDelegate
extension RecommendCycleView: XRCarouselViewDelegate {
    func carouselView(_ carouselView: XRCarouselView!, didClickImage index: Int) {
        let cycleModel = cycleModels![index]
        // 1.创建NormalRoomVc
        let webVC = WebViewController(navigationTitle: cycleModel.title, urlStr: cycleModel.anchor!.jumpUrl!)
        
        // 2.以Push方式弹出
        topViewController()!.navigationController?.pushViewController(webVC, animated: true)
    }
}
