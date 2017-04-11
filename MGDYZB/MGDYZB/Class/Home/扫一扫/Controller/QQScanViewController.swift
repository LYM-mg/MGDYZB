//
//  QQScanViewController.swift
//  swiftScan
//
//  Created by xialibing on 15/12/10.
//  Copyright © 2015年 xialibing. All rights reserved.
//

import UIKit

class QQScanViewController: LBXScanViewController {

    /**
     @brief  闪关灯开启状态
     */
    var isOpenedFlash:Bool = false
    
// MARK: - 底部几个功能：开启闪光灯、相册、我的二维码
    fileprivate lazy var scanBottom: ScanBottomView = {
        let sb = ScanBottomView(frame: CGRect(x: 0, y: MGScreenH-100-MGNavHeight, width: MGScreenW, height: 100))
        return sb
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //需要识别后的图像
        setNeedCodeImage(needCodeImg: true)
        
        //框向上移动10个像素
        scanStyle?.centerUpOffset += 10
        
        view.addSubview(scanBottom)
        scanBottom.btnClickBlcok = { [unowned self](view,btn, type) in
            switch type {
            case .flash:
                self.scanObj?.changeTorch();
                
                self.isOpenedFlash = !self.isOpenedFlash
                
                if self.isOpenedFlash {
                    btn.setImage(UIImage(named: "MGCodeScan.bundle/qrcode_scan_btn_flash_down"), for:UIControlState.normal)
                } else {
                    btn.setImage(UIImage(named: "MGCodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
                }
            case .photo:
                self.takePhotoFromAlbun()
                break
            case .myqrcode:
                self.show(QRCodeViewController(), sender: nil)
                break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubview(toFront: scanBottom)
    }
    
    
  
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        for result:LBXScanResult in arrayResult {
            if let str = result.strScanned {
                print(str)
            }
        }
        
        let result:LBXScanResult = arrayResult[0]
        if result.strScanned!.contains("http://") || result.strScanned!.contains("https://") {
            let url = URL(string: result.strScanned!)
            if  UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!)
            }
        } else {  // 其他信息 弹框显示
            debugPrint(result.strScanned!)
        }
    }
}

// MARK: - 扫描系统相片中二维码和录制视频
extension QQScanViewController {
    @objc fileprivate func takePhotoFromAlbun() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in }
        let photoAction = UIAlertAction(title: "相册", style: .default) { (action) in
            print(action)
            self.openCamera(.photoLibrary)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(photoAction)
        
        // 判断是否为pad 弹出样式
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     *  打开照相机/打开相册
     */
    func openCamera(_ type: UIImagePickerControllerSourceType,title: String? = "") {
        if !UIImagePickerController.isSourceTypeAvailable(type) {
            self.showInfo(info: "Camera不可用")
            return
        }
        let ipc = UIImagePickerController()
        ipc.sourceType = type
        ipc.delegate = self
        present(ipc, animated: true,  completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        getQRCodeInfo(image: image!)
        picker.dismiss(animated: true, completion: nil)
    }
    
    /// 取得图片中的信息
    fileprivate func getQRCodeInfo(image: UIImage) {
        // 1.创建扫描器
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: nil)  else { return }
        
        // 2.扫描结果
        guard let ciImage = CIImage(image: image) else { return }
        let features = detector.features(in: ciImage)
        
        // 3.遍历扫描结果
        for f in features {
            guard let feature = f as? CIQRCodeFeature else { return }
            if (feature.messageString?.isEmpty)! {
                return
            }
            // 如果是网址就跳转
            if feature.messageString!.contains("http://") || feature.messageString!.contains("https://") {
                let url = URL(string: feature.messageString!)
                if  UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.openURL(url!)
                }
            } else {  // 其他信息 弹框显示
                debugPrint(feature.messageString)
            }
        }
    }
}
