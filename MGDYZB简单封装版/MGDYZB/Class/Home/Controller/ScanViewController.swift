//
//  ScanViewController.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/4/11.
//  Copyright © 2017年 ming. All rights reserved.
//  扫一扫控制器

import UIKit
import AVFoundation

class ScanViewController: UIViewController {
    
    // MARK: - 自定义属性
    // MARK: - lazy
    /// AVFoundation框架捕获类的中心枢纽，协调输入输出设备以获得数据
    fileprivate lazy var session: AVCaptureSession = AVCaptureSession()
    /// 图层
    fileprivate lazy var preViewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    /// 画形状的layer
    fileprivate var shapeLayer: CAShapeLayer?
    /// 是否是指定扫描区域
    fileprivate lazy var isOpenInterestRect: Bool = true
    /// 捕获设备，默认后置摄像头
    fileprivate lazy var device: AVCaptureDevice? = AVCaptureDevice.default(for: AVMediaType.video)
    /// 扫描界面底部工具栏
    fileprivate lazy var scanBottomToolBar: ScanBottomView = {
        let sb = ScanBottomView(frame: CGRect(x: 0, y: MGScreenH-100-MGNavHeight, width: MGScreenW, height: 100))
        
        sb.btnClickBlcok = { [unowned self](view, type) in
            switch type {
                case .flash:
                    guard let device = self.device else {
                        self.showInfo(info: "没有输入设备")
                        return
                    }
                    //修改前必须先锁定
                    try? self.device?.lockForConfiguration()
                    //必须判定是否有闪光灯，否则如果没有闪光灯会崩溃
                    if device.hasFlash && device.hasTorch {
                        if device.flashMode == .off {
                            device.flashMode = .on
                            device.torchMode = .on
                        }else {
                            device.flashMode = AVCaptureDevice.FlashMode.off
                            device.torchMode = AVCaptureDevice.TorchMode.off
                        }
                    }
                    device.unlockForConfiguration()
                case .photo:
                    self.takePhotoFromAlbun()
                    break
                case .myqrcode:
                    self.show(QRCodeViewController(), sender: nil)
                    break
            }
        }
        return sb
    }()
    //输入设备
    var videoInput: AVCaptureDeviceInput?
    /// 输出设备，需要指定他的输出类型及扫描范围
    fileprivate var output: AVCaptureMetadataOutput?
    var qRScanView: MGScanView?
    open var scanStyle: MGScanViewStyle? = MGScanViewStyle()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "扫一扫"
        setUpMainView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(ScanViewController.startScanning), with: nil, afterDelay: 0.3)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        qRScanView?.stopScanAnimation()
        session.stopRunning()
    }
    
    // 设置框内识别
    open func setOpenInterestRect(isOpen:Bool){
        isOpenInterestRect = isOpen
    }
    
    deinit {
        print("MGScanViewController deinit")
    }
}

// MARK: - 扫一扫
extension ScanViewController {
    fileprivate func setUpMainView() {
        view.addSubview(scanBottomToolBar)
        self.view.backgroundColor = UIColor.clear
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        drawScanView()
        view.bringSubviewToFront(scanBottomToolBar)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(self.changeCamera))
    }
    
    /// 切换摄像头
    @objc fileprivate func changeCamera() {
        // 0.执行动画
        let rotaionAnim = CATransition()
        rotaionAnim.type = CATransitionType(rawValue: "oglFlip")
        rotaionAnim.subtype = CATransitionSubtype(rawValue: "fromLeft")
        rotaionAnim.duration = 0.5
        view.layer.add(rotaionAnim, forKey: nil)
        // 1.校验videoInput是否有值
        guard let videoInput = videoInput else { return }
        // 2.获取当前镜头
        let position : AVCaptureDevice.Position = videoInput.device.position == .front ? .back : .front
        // 3.创建新的input
        guard let devices = AVCaptureDevice.devices(for: AVMediaType.video) as? [AVCaptureDevice] else { return }
        guard let newDevice = devices.filter({$0.position == position}).first else { return }
        guard let newVideoInput = try? AVCaptureDeviceInput(device: newDevice) else { return }
        // 4.移除旧输入，添加新输入
        session.beginConfiguration()
        session.removeInput(videoInput)
        session.addInput(newVideoInput)
        session.commitConfiguration()
        // 5.保存新输入
        self.videoInput = newVideoInput
    }

    
    open func drawScanView() {
        if qRScanView == nil {
            qRScanView = MGScanView(frame: self.view.frame,vstyle:scanStyle! )
            self.view.addSubview(qRScanView!)
        }
        qRScanView?.deviceStartReadying(readyStr: "相机启动中...")
    }
    
    // 3.开始扫描
    @objc open func startScanning() {
        // 1.创建会话 //高质量采集率
        session.sessionPreset = AVCaptureSession.Preset.high
        
        
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if(authStatus == .restricted || authStatus == .denied) {
            self.showInfo(info: "请在iPhone的“设置”-“隐私”-“相机”功能中，找到“XXXX”打开相机访问权限")
            return
        }
        
        // 2.判断输入能否添加到会话中
        if self.videoInput == nil {
            guard let input = try? AVCaptureDeviceInput(device: device!) else {
                qRScanView?.deviceStopReadying()
                self.showInfo(info: "没有相输入设备")
                return
            }
            self.videoInput = input
            if session.canAddInput(self.videoInput!) {
                session.addInput(self.videoInput!)
            }
        }
        
        // 3.判断输出能够添加到会话中
        if self.output == nil {
            self.output = AVCaptureMetadataOutput()
            if session.canAddOutput(output!) {
                session.addOutput(output!)
            }
            if isOpenInterestRect {
                output?.rectOfInterest = CGRect(x: (124)/MGScreenH, y: ((MGScreenW-220)/2)/MGScreenW, width: 220/MGScreenH, height: 220/MGScreenW)
            }
            // 设置监听监听输出解析到的数据
            output?.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            // 3.1.设置输出能够解析的数据类型
            // 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
            //设置availableMetadataObjectTypes为二维码、条形码等均可扫描，如果想只扫描二维码可设置为
            output?.metadataObjectTypes = self.defaultMetaDataObjectTypes()
//                Array(arrayLiteral: AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code)
        }
        
        // 4.设置图层
        preViewLayer.frame = view.bounds
        preViewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.insertSublayer(preViewLayer, at: 0)
        
        // 5.开始扫描
        session.startRunning()
        //结束相机等待提示
        qRScanView?.deviceStopReadying()
        
        //开始扫描动画
        qRScanView?.startScanAnimation()
        
        // 6.拉近镜头，改善条形码读取效果
        //修改前必须先锁定
        do {
            try self.device?.lockForConfiguration()
        } catch _ {
            NSLog("Error: lockForConfiguration.");
        }
        // 拉近镜头 放大
        self.device?.videoZoomFactor = 1.5
        self.device?.unlockForConfiguration()

    }
    
    //MARK: ------获取系统默认支持的码的类型
    func defaultMetaDataObjectTypes() ->[AVMetadataObject.ObjectType] {
        var types =
            [AVMetadataObject.ObjectType.qr,
             AVMetadataObject.ObjectType.upce,
             AVMetadataObject.ObjectType.code39,
             AVMetadataObject.ObjectType.code39Mod43,
             AVMetadataObject.ObjectType.ean13,
             AVMetadataObject.ObjectType.ean8,
             AVMetadataObject.ObjectType.code93,
             AVMetadataObject.ObjectType.code128,
             AVMetadataObject.ObjectType.pdf417,
             AVMetadataObject.ObjectType.aztec,
             ];
        if #available(iOS 8.0, *) {
            types.append(AVMetadataObject.ObjectType.interleaved2of5)
            types.append(AVMetadataObject.ObjectType.itf14)
            types.append(AVMetadataObject.ObjectType.dataMatrix)
            
            types.append(AVMetadataObject.ObjectType.interleaved2of5)
            types.append(AVMetadataObject.ObjectType.itf14)
            types.append(AVMetadataObject.ObjectType.dataMatrix)
        }
        
        return types;
    }

}

// MARK:- <AVCaptureMetadataOutputObjectsDelegate>的代理方法
extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        guard let object = metadataObjects.last as? AVMetadataMachineReadableCodeObject else{
            print("没有获取到扫描结果")
            return
        }
        
        // 2.使用预览图层,将corners的点转成坐标系中的点
        guard let newObject = preViewLayer.transformedMetadataObject(for: object) as? AVMetadataMachineReadableCodeObject else{
            print("没有将corners的点转成坐标系中的点成功")
            return
        }
        
        // 3.画边框
        drawBorder(object: newObject)
    
        // 4.获取扫描结果并且显示出来
        if object.stringValue != nil && !object.stringValue!.isEmpty {
            qRScanView?.stopScanAnimation()
            session.stopRunning()
            UIView.animate(withDuration: 0.3, animations: { 
                // 0.移除之前的图形
                self.shapeLayer?.removeFromSuperlayer()
            })
            
            // 如果是网址就跳转
            if object.stringValue!.contains("http://") || object.stringValue!.contains("https://") {
                let url = URL(string: object.stringValue!)
                if  UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.openURL(url!)
                }
            } else {  // 其他信息 弹框显示
                if self.isKind(of: UIViewController.self) || self.isKind(of: UIView.self) {
                    let alertVc = UIAlertController(title: object.stringValue, message: nil, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "好的", style: .cancel, handler: { (action) in
                        self.startScanning()
                    })
                    alertVc.addAction(cancelAction)
                    UIApplication.shared.keyWindow?.rootViewController?.present(alertVc, animated: true, completion: nil)
                }
            }
        }
    }
    
    /*
     *  画边框
     */
    private func drawBorder(object: AVMetadataMachineReadableCodeObject) {
        // 0.移除之前的图形
        self.shapeLayer?.removeFromSuperlayer()
        
        // 1.创建CAShapeLayer(形状类型:专门用于画图)
        let shapeLayer = CAShapeLayer()
        
        // 2.设置layer属性
        shapeLayer.borderColor = UIColor.orange.cgColor
        shapeLayer.borderWidth = 5;
        shapeLayer.fillColor = UIColor.red.cgColor
        
        // 3.创建贝塞尔曲线
        let path = UIBezierPath()
        
        // 4.给贝塞尔曲线添加对应的点
        for i in 0..<object.corners.count {
            // 4.1获取每一个点对应的字典
            let dict = object.corners[i] as! CFDictionary
            let point = CGPoint(dictionaryRepresentation: dict)
            
            // 4.2如果是第一个点,移动到第一个点
            if i == 0 {
                path.move(to: point!)
                continue
            }
            
            // 4.3如果是其他的点,则添加线
            path.addLine(to: point!)
        }
        
        // 5闭合path路径
        path.close()
        
        // 6.给shapeLayer添加路径
        shapeLayer.path = path.cgPath
        
        // 7.将shapeLayer添加到其他视图上
        preViewLayer.addSublayer(shapeLayer)
        
        // 8.保存shapeLayer
        self.shapeLayer = shapeLayer
    }
}

// MARK: - 扫描系统相片中二维码和录制视频
extension ScanViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
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
    func openCamera(_ type: UIImagePickerController.SourceType,title: String? = "") {
        if !UIImagePickerController.isSourceTypeAvailable(type) {
            self.showInfo(info: "Camera不可用")
            return
        }
        let ipc = UIImagePickerController()
        ipc.sourceType = type
        ipc.delegate = self
        present(ipc, animated: true,  completion: nil)
    }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
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
                debugPrint(feature.messageString ?? "")
            }
        }
    }
}



///// 定位扫描框在哪个位置 定位扫描框在屏幕正中央，并且宽高为200的正方形
//fileprivate lazy var scanView: UIView = {
//    let v = UIView(frame: CGRect(x: (MGScreenW-200)/2, y: (self.view.frame.size.height-200)/2, width: 200, height: 200))
//    return v
//}()
///// 设置扫描界面（包括扫描界面之外的部分置灰，扫描边框等的设置）,后面设置
//fileprivate lazy var clearView: UIView = { [unowned self] in
//    //定位扫描框在屏幕正中央，并且宽高为200的正方形
//    let v = UIView(frame: self.view.frame)
//    return v
//}()
