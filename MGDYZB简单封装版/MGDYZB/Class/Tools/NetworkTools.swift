//
//  NetworkTools.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

//import Foundation
import UIKit
import Alamofire

// MARK: - 请求枚举
enum MethodType: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

// MARK: - Swift 3.0封装 URLSession 的GET/SET方法代替 Alamofire
/// Swift 3.0封装 URLSession 的GET/SET方法代替 Alamofire
class NetWorkTools: NSObject {
    /// 请求时间
    var elapsedTime: TimeInterval?
    /// 请求单例工具类对象
    //    static let share = NetWorkTools()
    //    class func share() -> NetWorkTools {
    //        struct single {
    //            static let singleDefault = NetWorkTools()
    //        }
    //        return single.singleDefault
    //    }
    
    // MARK: 通用请求的Manager
    static let defManager: SessionManager = {
        var defHeaders = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]
        let defConf = URLSessionConfiguration.default
        defConf.timeoutIntervalForRequest = 8
        defConf.httpAdditionalHeaders = defHeaders
        return Alamofire.SessionManager(configuration: defConf)
    }()
    
    // MARK: 后台请求的Manager
    static let backgroundManager: SessionManager = {
        let defHeaders = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]
        let backgroundConf = URLSessionConfiguration.background(withIdentifier: "io.zhibo.api.backgroud")
        backgroundConf.httpAdditionalHeaders = defHeaders
        return Alamofire.SessionManager(configuration: backgroundConf)
    }()
    
    // MARK: 私有会话的Manager
    static let ephemeralManager: SessionManager = {
        let defHeaders = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]
        let ephemeralConf = URLSessionConfiguration.ephemeral
        ephemeralConf.timeoutIntervalForRequest = 8
        ephemeralConf.httpAdditionalHeaders = defHeaders
        return Alamofire.SessionManager(configuration: ephemeralConf)
    }()
}

// MARK: - 通用请求方法
extension NetWorkTools {
    /// 通用请求方法
    /**
     注册的请求
     - parameter type: 请求方式
     - parameter urlString: 请求网址
     - parameter parameters: 请求参数
     
     - parameter succeed: 请求成功回调
     - parameter failure: 请求失败回调
     - parameter error: 错误信息
     */
    static func registRequest(type: MethodType,urlString: String, parameters: [String : Any]? = nil ,succeed:@escaping ((_ result : Any?, _ error: Error?) -> Swift.Void), failure:@escaping ((_ error: Error?)  -> Swift.Void)) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "text/html",
            "application/x-www-form-urlencoded": "charset=utf-8",
            "Content-Type": "application/json",
            "Content-Length": "12130"
        ]
        
        let start = CACurrentMediaTime()
        // 2.发送网络数据请求 encoding: URLEncoding.default,
        NetWorkTools.defManager.request(urlString, method: method, parameters: parameters, headers: headers).responseJSON { (response) in
            
            let end = CACurrentMediaTime()
            let elapsedTime = end - start
            print("请求时间 = \(elapsedTime)")
            //            print("response.timeline = \(response.timeline)")
            
            // 请求失败
            if response.result.isFailure {
                print(response.result.error)
                failure(response.result.error)
                return
            }
            
            // 请求成功
            if response.result.isSuccess {
                // 3.获取结果
                guard let result = response.result.value else {
                    failure(response.result.error)
                    return
                }
                // 4.将结果回调出去
                succeed(result, nil)
            }
        }
    }
    
    /// 通用请求方法
    /**
     - parameter type: 请求方式
     - parameter urlString: 请求网址
     - parameter parameters: 请求参数
     
     - parameter succeed: 请求成功回调
     - parameter failure: 请求失败回调
     - parameter error: 错误信息
     */
    /// 备注：通用请求方法,增加失败回调，参考系统闭包
    static func requestData(type: MethodType,urlString: String, parameters: [String : Any]? = nil ,succeed:@escaping ((_ result : Any?, _ error: Error?) -> Swift.Void), failure: @escaping ((_ error: Error?)  -> Swift.Void)) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            //            "Accept": "text/html",
            //            "application/x-www-form-urlencoded": "charset=utf-8",
            "Content-Type": "application/json",
            //            "Content-Length": "12130"
        ]
        
        // 2.发送网络数据请求
        NetWorkTools.defManager.request(urlString, method: method, parameters: parameters, headers: headers).responseJSON { (response) in
            
            // 请求失败
            if response.result.isFailure {
                print(response.result.error)
                failure(response.result.error)
                return
            }
            
            // 请求成功
            if response.result.isSuccess {
                // 3.获取结果
                guard let result = response.result.value else {
                    succeed(nil, response.result.error)
                    return
                }
                // 4.将结果回调出去
                succeed(result, nil)
            }
        }
    }
    
    
    // 注册代码
    static func test(type: MethodType,urlString: String, parameters: [String : Any]? = nil ,succeed:@escaping ((_ result : Any?, _ error: Error?) -> Swift.Void), failure: @escaping ((_ error: Error?)  -> Swift.Void)) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        //用户参数
        
        // 2.发送网络数据请求
        NetWorkTools.defManager.request(urlString, method: method, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            
            // 请求失败
            if response.result.isFailure {
                print(response.result.error)
                failure(response.result.error)
                return
            }
            
            // 请求成功
            if response.result.isSuccess {
                // 3.获取结果
                guard let result = response.result.value else {
                    succeed(nil, response.result.error)
                    return
                }
                // 4.将结果回调出去
                let dict = try? JSONSerialization.jsonObject(with: result, options: JSONSerialization.ReadingOptions.allowFragments)
                
                succeed(dict, nil)
            }
        }
    }
}

extension NetWorkTools {
    /**
    *   请求方法
    */
    class func requestData1(_ type: MethodType,urlString: String,parameters: [String: Any]? = nil ,finishedCallback:@escaping ((_ result : Any) -> ())) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络数据请求
       NetWorkTools.defManager.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
//            print("request + \(request)")
//            print("response + \(response)")
//            print("data + \(result.data)")
//            print("value + \(result.value)")
            // 3.获取结果
            guard let resultArr = response.result.value else {
                print(response.result.error)
                return
            }

            // 4.将结果回调出去
            finishedCallback(resultArr)
        }
    }
    
    
}
