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
 * DataListHttp Delegate
 * 回执线程的处理协议
 *
 * @since 1.0
 */
protocol DataListHttpDelegate {
    /**
     * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )
     *
     * @param result 数据适配器
     */
    func onSuccess(result: DataListResult)
    
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
 * DataListHttp class file
 * HTTP请求列表数据
 * Json => {"errNo":0,"errMsg":"OK","data":{"total":24,"limit":8,"offset":0,"rows":[{"id":1,"title":"Java编程思想","isRecommend":false},{"id":2,"title":"C++编程思想","isRecommend":false},{"id":3,"title":"高性能MySQL","isRecommend":false}]}}
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: DataListHttp.swift 1 2017-07-28 10:08:06Z huan.song $
 * @since 1.0
 */
class DataListHttp {
    
    public static let TAG: String = "DataListHttp"
    
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
        let mDataListHttpDelegateImpl: DataListHttpDelegate
        
        /**
         * 构造方法，初始化HTTP请求协议的实现类
         */
        init(delegate: DataListHttpDelegate) {
            mDataListHttpDelegateImpl = delegate
        }
        
        /**
         * Http请求完成后回调方法
         *
         * @param data HTTP返回数据
         * @param response HTTP响应，StatusCode、HTTP Header、MIMEType
         */
        func onComplete(data: Data?, response: HTTPURLResponse?) {
            if response == nil || data == nil {
                print("\(DataListHttp.TAG) onComplete() Error, data is nil or response is nil")
                mDataListHttpDelegateImpl.onError(err: DataError(code: ErrorNo.ERROR_UNKNOWN, message: ErrorMsg.ERROR_UNKNOWN))
                return
            }
            
            let statusCode: Int = response!.statusCode
            if statusCode != HttpStatus.SC_OK {
                print("\(DataListHttp.TAG) onComplete() Error, statusCode: \(statusCode), message: \(response!.description)")
                mDataListHttpDelegateImpl.onFailure(statusCode: statusCode, message: response!.description)
                return
            }
            
            let result: DataListResult = DataListResult.newObject(with: data!)
            let tag: String = result.isSuccess() ? "Success" : "Error"
            print("\(DataListHttp.TAG) onComplete() \(tag), message: \(response!.description), \(result)")
            
            mDataListHttpDelegateImpl.onSuccess(result: result)
        }
        
        /**
         * 打开URL链接失败后回调方法
         *
         * @param err a Error 失败原因
         */
        func onError(err: Error) {
            print("\(DataListHttp.TAG) onError() Error, err: \(err.localizedDescription)")
            mDataListHttpDelegateImpl.onError(err: DataError(code: ErrorNo.ERROR_UNKNOWN, message: err.localizedDescription))
        }
        
    }
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调DataListHttpDelegate协议
     *
     * @param url      a URL
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, delegate: DataListHttpDelegate) {
        Http.get(url: url, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调DataListHttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询字典，Key => String, Value => String
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, params: Dictionary<String, String>, delegate: DataListHttpDelegate) {
        Http.get(url: url, params: params, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调DataListHttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询串，a String
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, params: String, delegate: DataListHttpDelegate) {
        Http.get(url: url, params: params, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 后台线程中发送POST请求消息，主线程中回调DataListHttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询字典，Key => String, Value => String
     * @param delegate 回执线程的处理协议
     */
    public static func post(url: String, params: Dictionary<String, String>, delegate: DataListHttpDelegate) {
        Http.post(url: url, params: params, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 后台线程中发送POST请求消息，主线程中回调DataListHttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询串，a String
     * @param delegate 回执线程的处理协议
     */
    public static func post(url: String, params: String, delegate: DataListHttpDelegate) {
        Http.post(url: url, params: params, delegate: HttpDelegateImpl(delegate: delegate))
    }
    
}
