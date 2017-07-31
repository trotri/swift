/*
 * Copyright (C) 2017 The Swift Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

/**
 * DataHttp Delegate
 * 回执线程的处理协议
 *
 * @since 1.0
 */
protocol DataHttpDelegate {
    /**
     * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )
     *
     * @param result 数据适配器
     */
    func onSuccess(result: DataResult)
    
    /**
     * Http请求失败后回调方法，HTTP状态码 != SC_OK ( 200 )
     *
     * @param statusCode HTTP状态码
     * @param message HTTP消息
     */
    func onFailure(statusCode: Int, message: String)
    
    /**
     * 打开URL链接失败后回调方法
     *
     * @param err a DataError 失败原因
     */
    func onError(err: DataError)
}

/**
 * DataHttp class file
 * HTTP请求数据
 * Json => {"errNo":0,"errMsg":"OK","data":{"id":1,"title":"Java编程思想","isRecommend":false}}
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: DataHttp.swift 1 2017-07-28 10:08:06Z huan.song $
 * @since 1.0
 */
class DataHttp {
    
    public static let TAG: String = "DataHttp"
    
    /**
     * Http Delegate Implement
     * Http回执线程的实现类
     *
     * @since 1.0
     */
    class HttpDelegateImpl: HttpDelegate {
        /**
         * HTTP请求协议的实现类
         */
        let mDataHttpDelegateImpl: DataHttpDelegate
        
        /**
         * 构造方法，初始化HTTP请求协议的实现类
         */
        init(delegate: DataHttpDelegate) {
            mDataHttpDelegateImpl = delegate
        }
        
        /**
         * Http请求完成后回调方法
         *
         * @param data HTTP返回数据
         * @param response HTTP响应，StatusCode、HTTP Header、MIMEType
         */
        func onComplete(data: Data?, response: HTTPURLResponse?) {
            if response == nil || data == nil {
                print("\(DataHttp.TAG) onComplete() Error, data is nil or response is nil")
                mDataHttpDelegateImpl.onError(err: DataError(code: ErrorNo.ERROR_UNKNOWN, message: ErrorMsg.ERROR_UNKNOWN))
                return
            }
            
            let statusCode: Int = response!.statusCode
            if statusCode != HttpStatus.SC_OK {
                print("\(DataHttp.TAG) onComplete() Error, statusCode: \(statusCode), message: \(response!.description)")
                mDataHttpDelegateImpl.onFailure(statusCode: statusCode, message: response!.description)
                return
            }
            
            let result: DataResult = DataResult.newObject(with: data!)
            let tag: String = result.isSuccess() ? "Success" : "Error"
            print("\(DataHttp.TAG) onComplete() \(tag), message: \(response!.description), \(result)")
            
            mDataHttpDelegateImpl.onSuccess(result: result)
        }
        
        /**
         * 打开URL链接失败后回调方法
         *
         * @param err a Error 失败原因
         */
        func onError(err: Error) {
            print("\(DataHttp.TAG) onError() err: \(err.localizedDescription)")
            mDataHttpDelegateImpl.onError(err: DataError(code: ErrorNo.ERROR_UNKNOWN, message: err.localizedDescription))
        }
        
    }
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调DataHttpDelegate协议
     *
     * @param url      a URL
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, delegate: DataHttpDelegate) {
        Http.get(url: url, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调DataHttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询字典，Key => String, Value => String
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, params: Dictionary<String, String>, delegate: DataHttpDelegate) {
        Http.get(url: url, params: params, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调DataHttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询串，a String
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, params: String, delegate: DataHttpDelegate) {
        Http.get(url: url, params: params, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 后台线程中发送POST请求消息，主线程中回调DataHttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询字典，Key => String, Value => String
     * @param delegate 回执线程的处理协议
     */
    public static func post(url: String, params: Dictionary<String, String>, delegate: DataHttpDelegate) {
        Http.post(url: url, params: params, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 后台线程中发送POST请求消息，主线程中回调DataHttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询串，a String
     * @param delegate 回执线程的处理协议
     */
    public static func post(url: String, params: String, delegate: DataHttpDelegate) {
        Http.post(url: url, params: params, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
}
