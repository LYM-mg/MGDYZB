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
    /// 会话
    fileprivate lazy var session: AVCaptureSession = AVCaptureSession()
    /// 图层
    fileprivate lazy var preViewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    /// 画形状的layer
    fileprivate lazy var shapeLayer: CAShapeLayer = CAShapeLayer()
    /// 是否是指定扫描区域
    fileprivate lazy var isOpenInterestRect: Bool = false
    fileprivate lazy var device: AVCaptureDevice? = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    /// 会话输出
    fileprivate lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    fileprivate lazy var scanBottom: ScanBottomView = {
        let sb = ScanBottomView(frame: CGRect(x: 0, y: MGScreenH-100-MGNavHeight, width: MGScreenW, height: 100))
        return sb
    }()
    //识别码的类型
    var arrayCodeType:[String]?
    open var qRScanView: MGScanView?
    open var scanStyle: MGScanViewStyle? = MGScanViewStyle()
    var videoInput: AVCaptureDeviceInput?
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "扫一扫"
        setUpMainView()
        
        scanBottom.btnClickBlcok = { [unowned self](view, type) in
            switch type {
            case .flash:
                guard let device = self.device else {
                    self.showInfo(info: "没有输入设备")
                    return
                }
                //修改前必须先锁定
                try? self.device?.lockForConfiguration()
                
                //必须判定是否有闪光灯，否则如果没有闪光灯会崩溃
                if device.hasFlash {
                    if device.flashMode == .off {
                        device.flashMode = .on
                        device.torchMode = .on
                    }else {
                        device.flashMode = AVCaptureFlashMode.off
                        device.torchMode = AVCaptureTorchMode.off
                    }
                }
            case .photo:
                self.takePhotoFromAlbun()
                break
            case .myqrcode:
                self.show(QRCodeViewController(), sender: nil)
                break
            }
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(self.changeCamera))
    }
    
    @objc fileprivate func changeCamera() {
        // 0.执行动画
        let rotaionAnim = CATransition()
        rotaionAnim.type = "oglFlip"
        rotaionAnim.subtype = "fromLeft"
        rotaionAnim.duration = 0.5
        view.layer.add(rotaionAnim, forKey: nil)
        // 1.校验videoInput是否有值
        guard let videoInput = videoInput else { return }
        // 2.获取当前镜头
        let position : AVCaptureDevicePosition = videoInput.device.position == .front ? .back : .front
        // 3.创建新的input
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else { return }
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
    }
    
    //设置框内识别
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
        self.view.backgroundColor = UIColor.black
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        drawScanView()
        view.addSubview(scanBottom)
    }
    
    open func drawScanView() {
        if qRScanView == nil {
            qRScanView = MGScanView(frame: self.view.frame,vstyle:scanStyle! )
            self.view.addSubview(qRScanView!)
        }
        qRScanView?.deviceStartReadying(readyStr: "相机启动中...")
        
    }
    
    // 3.开始扫描
    open func startScanning() {
        // 1.创建会话
        // 2.设置会话输入
        //        let input = try ? AVCaptureDeviceInput(device: device)
        guard let input = try? AVCaptureDeviceInput(device: device) else {
             qRScanView?.deviceStopReadying()
            self.showInfo(info: "没有相机权限，请到设置->隐私中开启本程序相机权限")
            return
        }
        self.videoInput = input
        session.addInput(input)
        
        // 3.设置会话输出
        //识别各种码，
//        arrayCodeType = self.defaultMetaDataObjectTypes()
        //指定识别几种码
        if arrayCodeType == nil{
            arrayCodeType = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode128Code]
        }
        output.metadataObjectTypes = arrayCodeType
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        session.addOutput(output)
        if isOpenInterestRect {
            output.rectOfInterest = CGRect(x: (124)/MGScreenH, y: ((MGScreenW-220)/2)/MGScreenW, width: 220/MGScreenH, height: 220/MGScreenW)
        }
        
        // 4.设置图层
        preViewLayer.frame = view.frame
        view.layer.insertSublayer(preViewLayer, at: 0)
        
        // 5.开始扫描
        session.startRunning()
        //结束相机等待提示
        qRScanView?.deviceStopReadying()
        //开始扫描动画
        qRScanView?.startScanAnimation()
    }
    
    //MARK: ------获取系统默认支持的码的类型
    func defaultMetaDataObjectTypes() ->[String] {
        var types =
            [AVMetadataObjectTypeQRCode,
             AVMetadataObjectTypeUPCECode,
             AVMetadataObjectTypeCode39Code,
             AVMetadataObjectTypeCode39Mod43Code,
             AVMetadataObjectTypeEAN13Code,
             AVMetadataObjectTypeEAN8Code,
             AVMetadataObjectTypeCode93Code,
             AVMetadataObjectTypeCode128Code,
             AVMetadataObjectTypePDF417Code,
             AVMetadataObjectTypeAztecCode,
             ];
        if #available(iOS 8.0, *) {
            types.append(AVMetadataObjectTypeInterleaved2of5Code)
            types.append(AVMetadataObjectTypeITF14Code)
            types.append(AVMetadataObjectTypeDataMatrixCode)
            
            types.append(AVMetadataObjectTypeInterleaved2of5Code)
            types.append(AVMetadataObjectTypeITF14Code)
            types.append(AVMetadataObjectTypeDataMatrixCode)
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
        
        // 2.获取扫描结果并且显示出来
//        self.resultLabel.text = object.stringValue
        
        
        // 3.使用预览图层,将corners的点转成坐标系中的点
        guard let newObject = preViewLayer.transformedMetadataObject(for: object) as? AVMetadataMachineReadableCodeObject else{
            print("没有将corners的点转成坐标系中的点成功")
            return
        }
        
        // 4.画边框
        drawBorder(object: newObject)
    }
    
    /*
     *  画边框
     */
    private func drawBorder(object: AVMetadataMachineReadableCodeObject) {
        // 0.移除之前的图形
        self.shapeLayer.removeFromSuperlayer()
        
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
            if i == 1 {
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
        let photoAction = UIAlertAction(title: "从相册上传", style: .default) { (action) in
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
