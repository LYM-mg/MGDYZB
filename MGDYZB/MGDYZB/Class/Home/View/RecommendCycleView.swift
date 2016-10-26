//
//  RecommendCycleView.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit

class RecommendCycleView: UIView {
    
    // MARK: - lazy属性
    private lazy var carouselView: XRCarouselView = { [weak self] in
        let carouselView = XRCarouselView()
        carouselView.time = 2.0
        carouselView.pagePosition = PositionBottomRight
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
        
        setUpUI()
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
    private func setUpUI() {
        addSubview(carouselView)
    }
}


// MARK: - XRCarouselViewDelegate
extension RecommendCycleView: XRCarouselViewDelegate {
    func carouselView(carouselView: XRCarouselView!, didClickImage index: Int) {
        
    }
}