//
//  NetworkTools.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools: NSObject {
    /**
    *   请求方法
    */
    class func requestData(type: MethodType,urlString: String,parameters: [String: AnyObject]? = nil ,finishedCallback:((result : AnyObject) -> ())) {
        // 1.获取类型
        let method = type == .get ? Method.GET : Method.POST
        
        // 2.发送网络数据请求
        Alamofire.request(method, urlString, parameters: parameters).responseJSON { (request, response, result) -> Void in
//            print("request + \(request)")
//            print("response + \(response)")
//            print("data + \(result.data)")
//            print("value + \(result.value)")
            // 3.获取结果
            guard let resultArr = result.value else {
                print(result.error)
                return
            }

            // 4.将结果回调出去
            finishedCallback(result: resultArr)
        }
    }
}
