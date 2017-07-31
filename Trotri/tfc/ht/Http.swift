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
 * Http Delegate
 * 回执线程的处理协议
 *
 * @since 1.0
 */
protocol HttpDelegate {
    /**
     * Http请求完成后回调方法
     *
     * @param data HTTP返回数据
     * @param response HTTP响应，StatusCode、HTTP Header、MIMEType
     */
    func onComplete(data: Data?, response: HTTPURLResponse?)
    
    /**
     * 打开URL链接失败后回调方法
     *
     * @param err a Error 失败原因
     */
    func onError(err: Error)
}

/**
 * Http class file
 * HTTP类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: Http.swift 1 2017-07-27 13:52:06Z huan.song $
 * @since 1.0
 */
class Http {
    /**
     * 访问协议
     */
    public static let SCHEME_HTTP: String = "http"
    public static let SCHEME_HTTPS: String = "https"
    
    /**
     * 访问方式
     */
    public static let METHOD_GET: String = "GET"
    public static let METHOD_POST: String = "POST"
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调HttpDelegate协议
     *
     * @param url      a URL
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, delegate: HttpDelegate) {
        Http.get(url: url, params: "", delegate: delegate)
    }
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调HttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询字典，Key => String, Value => String
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, params: Dictionary<String, String>, delegate: HttpDelegate) {
        Http.request(method: Http.METHOD_GET, url: url, params: params, delegate: delegate)
    }
    
    /**
     * 后台线程中发送GET请求消息，主线程中回调HttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询串，a String
     * @param delegate 回执线程的处理协议
     */
    public static func get(url: String, params: String, delegate: HttpDelegate) {
        Http.request(method: Http.METHOD_GET, url: url, params: params, delegate: delegate)
    }
    
    /**
     * 后台线程中发送POST请求消息，主线程中回调HttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询字典，Key => String, Value => String
     * @param delegate 回执线程的处理协议
     */
    public static func post(url: String, params: Dictionary<String, String>, delegate: HttpDelegate) {
        Http.request(method: Http.METHOD_POST, url: url, params: params, delegate: delegate)
    }
    
    /**
     * 后台线程中发送POST请求消息，主线程中回调HttpDelegate协议
     *
     * @param url      a URL
     * @param params   查询串，a String
     * @param delegate 回执线程的处理协议
     */
    public static func post(url: String, params: String, delegate: HttpDelegate) {
        Http.request(method: Http.METHOD_POST, url: url, params: params, delegate: delegate)
    }
    
    /**
     * 后台线程中发送HTTP请求消息，主线程中回调HttpDelegate协议
     *
     * @param method   访问方式，{@link #METHOD_GET}、{@link #METHOD_POST}
     * @param url      a URL
     * @param params   查询字典，Key => String, Value => String
     * @param delegate 回执线程的处理协议
     */
    public static func request(method: String, url: String, params: Dictionary<String, String>, delegate: HttpDelegate) {
        Http.request(method: method, url: url, params: Http.joinString(params: params), delegate: delegate)
    }
    
    /**
     * 后台线程中发送HTTP请求消息，主线程中回调HttpDelegate协议
     *
     * @param method   访问方式，{@link #METHOD_GET}、{@link #METHOD_POST}
     * @param url      a URL
     * @param params   查询串，a String
     * @param delegate 回执线程的处理协议
     */
    public static func request(method: String, url: String, params: String, delegate: HttpDelegate) {
        var sUrl: String = url
        let sMethod: String = Http.isPost(method: method) ? Http.METHOD_POST : Http.METHOD_GET
        
        if Http.isGet(method: sMethod) {
            if !params.isEmpty {
                sUrl += (sUrl.contains("?") ? "&" : "?")
                sUrl += params
            }
        }
        
        var request = URLRequest.init(url: URL(string: Http.urlEncode(url: sUrl))!)
        if Http.isPost(method: sMethod) {
            request.httpMethod = Http.METHOD_POST
            request.httpBody = params.data(using: String.Encoding.utf8)
        }
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        let dataTask = session.dataTask(with: request, completionHandler: {(data, response, err) in
            DispatchQueue.main.async(execute: {
                if err != nil {
                    delegate.onError(err: err!)
                } else {
                    delegate.onComplete(data: data, response: (response as? HTTPURLResponse))
                }
            })
        })
        
        dataTask.resume()
    }
    
    /**
     * 判断提交方式是否是GET
     *
     * @param method 提交方式
     * @return Returns True, or False
     */
    public static func isGet(method: String) -> Bool {
        return Http.METHOD_GET.caseInsensitiveCompare(method).rawValue == 0
    }
    
    /**
     * 判断提交方式是否是POST
     *
     * @param method 提交方式
     * @return Returns True, or False
     */
    public static func isPost(method: String) -> Bool {
        return Http.METHOD_POST.caseInsensitiveCompare(method).rawValue == 0
    }
    
    /**
     * 将字典拼接成字符串
     *
     * @param params 字典，Key => String, Value => String
     * @return a String
     */
    public static func joinString(params: Dictionary<String, String>) -> String {
        var result: String = ""
        
        var joinStr: String = ""
        for (key, value) in params {
            result += joinStr + key + "=" + value
            joinStr = "&"
        }
        
        return result
    }
    
    /**
     * Encode URL
     *
     * @param url a URL
     * @return a Encoded URL
     */
    public static func urlEncode(url: String) -> String {
        return url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
}
