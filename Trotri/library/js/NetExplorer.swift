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

import WebKit

/**
 * Bridge class file
 * Js请求和回调辅助类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: NetExplorer.swift 1 2017-08-18 15:07:06Z huan.song $
 * @since 1.0
 */
class Bridge: NSObject, WKScriptMessageHandler {
    
    public static let TAG: String = "Bridge"
    
    /**
     * Used to expose the object in JavaScript
     */
    public static let JS_FUNCTION_NAME: String = "Trotri"
    
    /**
     * JavaScript Bridge Object
     */
    public static let JS_BRIDGE_NAME: String = "javascript:TrotriJSBridge"
    
    /**
     * Callback JavaScript throwError
     */
    public static let JS_LOG_THROW_ERROR: String = Bridge.JS_BRIDGE_NAME + ".Log.throwError"
    
    /**
     * Callback JavaScript
     */
    public static let JS_ONLISTEN_NAME: String = Bridge.JS_BRIDGE_NAME + ".onListen"
    
    /**
     * 系统错误
     */
    public static let SYSTEM_ERROR_ERR_NO: Int = -1
    
    /**
     * 如果方法名不存在，没有找到Js处理器，错误码
     */
    public static let METHOD_NOT_FOUND_ERR_NO: Int = -3
    
    /**
     * 如果方法名不存在，没有找到Js处理器，错误消息
     */
    public static let METHOD_NOT_FOUND_ERR_MSG: String = "Js method not found exception"
    
    /**
     * 如果Json格式不正确，错误码
     */
    public static let JSON_SYNTAX_ERR_NO: Int = -4
    
    /**
     * 如果Json格式不正确，错误消息
     */
    public static let JSON_SYNTAX_ERR_MSG: String = "Js parameter json syntax exception"
    
    /**
     * a NetExplorer
     */
    private var mWebView: NetExplorer? = nil
    
    /**
     * 构造方法
     */
    fileprivate override init() {
    }
    
    /**
     * 初始化Js请求
     */
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if Bridge.isJsFunction(funcName: message.name) {
            let data: String = "\(message.body)"
            if data.isEmpty {
                print("\(Bridge.TAG) userContentController() Error, JS_FUNCTION_NAME: \(Bridge.JS_FUNCTION_NAME), JsFunction: \"\(message.name)\", message.body: \"\(message.body)\", Data is Empty")
                loadSystemException(errMsg: "Args is Empty")
                return
            }
            
            let args = parseArgs(message: data)
            if args.key.isEmpty || args.method.isEmpty || args.parameter.isEmpty {
                print("\(Bridge.TAG) userContentController() Error, JS_FUNCTION_NAME: \(Bridge.JS_FUNCTION_NAME), JsFunction: \"\(message.name)\", message.body: \"\(message.body)\", Data: \"\(data)\", Args: \"\(args)\" is wrong")
                loadSystemException(errMsg: "Args: \"\(args)\" is wrong")
                return
            }
            
            exec(key: args.key, method: args.method, parameter: args.parameter)
        } else {
            loadSystemException(errMsg: "JsFunction: \"\(message.name)\" is wrong")
            print("\(Bridge.TAG) userContentController() Error, JS_FUNCTION_NAME: \(Bridge.JS_FUNCTION_NAME), JsFunction: \"\(message.name)\" is wrong")
        }
    }
    
    /**
     * 执行操作
     *
     * @param key       寄存回调函数的Key
     * @param method    请求方法名
     * @param parameter 请求参数，a Json String
     */
    public func exec(key: String, method: String, parameter: String) {
        let handler: JsHandlerDelegate? = JsHandlerFactory.getHandler(method: method)
        if handler == nil {
            loadMethodNotFoundException(key: key)
            return
        }
        
        handler!.run(bridge: self, key: key, parameter: parameter)
    }
    
    /**
     * 回调Js报告系统异常
     *
     * @param errMsg 错误消息
     */
    public func loadSystemException(errMsg: String) {
        print("\(Bridge.TAG) loadJsonSyntaxException(), errNo: \(Bridge.SYSTEM_ERROR_ERR_NO), errMsg: \"\(errMsg)\"")
        let code: String = "\(Bridge.JS_LOG_THROW_ERROR)('\"\"', \(convertThrowable(errNo: Bridge.SYSTEM_ERROR_ERR_NO, errMsg: errMsg)))"
        loadJs(code: code)
    }
    
    /**
     * 请求方法名不存在，回调Js报告异常
     *
     * @param key 寄存回调函数的Key
     */
    public func loadMethodNotFoundException(key: String) {
        print("\(Bridge.TAG) loadMethodNotFoundException(), errNo: \(Bridge.METHOD_NOT_FOUND_ERR_NO), errMsg: \"\(Bridge.METHOD_NOT_FOUND_ERR_MSG)\"")
        loadListen(key: key, data: nil, errNo: Bridge.METHOD_NOT_FOUND_ERR_NO, errMsg: Bridge.METHOD_NOT_FOUND_ERR_MSG)
    }
    
    /**
     * 请求参数Json字符串格式错误，转Entity失败，回调Js报告异常
     *
     * @param key 寄存回调函数的Key
     */
    public func loadJsonSyntaxException(key: String) {
        print("\(Bridge.TAG) loadJsonSyntaxException(), errNo: \(Bridge.JSON_SYNTAX_ERR_NO), errMsg: \"\(Bridge.JSON_SYNTAX_ERR_MSG)\"")
        loadListen(key: key, data: nil, errNo: Bridge.JSON_SYNTAX_ERR_NO, errMsg: Bridge.JSON_SYNTAX_ERR_MSG)
    }
    
    /**
     * 回调Js代码：TrotriJSBridge.onListen
     *
     * @param key  寄存回调函数的Key
     * @param data listener.success(data); data参数
     */
    public func loadListen(key: String, data: String?) {
        loadListen(key: key, data: data, errNo: 0, errMsg: "")
    }
    
    /**
     * 回调Js代码：TrotriJSBridge.onListen
     *
     * @param key    寄存回调函数的Key
     * @param data   listener.success(data); data参数
     * @param errNo  listener.error(throwable); throwable的错误码
     * @param errMsg listener.error(throwable); throwable的错误消息
     */
    public func loadListen(key: String, data: String?, errNo: Int, errMsg: String) {
        let code: String = "\(Bridge.JS_ONLISTEN_NAME)('\(key)', \((data == nil) ? "''" : data!), \(convertThrowable(errNo: errNo, errMsg: errMsg)))"
        loadJs(code: code)
    }
    
    /**
     * 回调Js代码
     *
     * @param code Js代码
     */
    public func loadJs(code: String) {
        mWebView!.evaluateJavaScript(code) { (_, _) -> Void in
            print("\(Bridge.TAG) loadJs \(code)")
        }
    }
    
    /**
     * 错误码和错误消息转Json字符串
     *
     * @param errNo  错误码
     * @param errMsg 错误消息
     * @return a Json String
     */
    public func convertThrowable(errNo: Int, errMsg: String) -> String {
        let data: Data = try! JSONSerialization.data(withJSONObject: ["errNo": errNo, "errMsg": errMsg], options: JSONSerialization.WritingOptions.prettyPrinted)
        return String(data: data, encoding: String.Encoding.utf8)!
    }
    
    /**
     * 分析ScriptMessage
     *
     * @param message ScriptMessage
     * @return Returns 寄存回调函数的Key, 请求方法名, 请求参数
     */
    private func parseArgs(message: String) -> (key: String, method: String, parameter: String) {
        if message.isEmpty {
            return ("", "", "")
        }
        
        var tmpMessage: String = message.trimmingCharacters(in: CharacterSet(charactersIn: " \n{};"))
        
        var tmpRange = tmpMessage.range(of: ";")
        if tmpRange == nil {
            return ("", "", "")
        }
        
        let key: String = tmpMessage.substring(to: tmpRange!.lowerBound).replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "key=", with: "")
        
        tmpMessage = tmpMessage.substring(from: tmpRange!.upperBound).trimmingCharacters(in: CharacterSet.whitespaces)
        if tmpMessage.isEmpty {
            return (key, "", "")
        }
        
        tmpRange = tmpMessage.range(of: ";")
        if tmpRange == nil {
            return (key, "", "")
        }
        
        let method: String = tmpMessage.substring(to: tmpRange!.lowerBound).replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "method=", with: "")
        
        tmpMessage = tmpMessage.substring(from: tmpRange!.upperBound).trimmingCharacters(in: CharacterSet.whitespaces)
        if tmpMessage.isEmpty {
            return (key, method, "")
        }
        
        let parameter: String = tmpMessage.trimmingCharacters(in: CharacterSet(charactersIn: "\n parameter=\""))
        return (key, method, parameter)
    }
    
    /**
     * 获取WebView
     *
     * @return a NetExplorer
     */
    public func getWebView() -> NetExplorer {
        return mWebView!
    }
    
    /**
     * 设置WebView
     *
     * @param wv a NetExplorer
     */
    fileprivate func setWebView(wv: NetExplorer) {
        mWebView = wv
    }
    
    /**
     * 判断是否是正确的Js方法
     *
     * @param funcName Js方式
     * @return Returns True, or False
     */
    public static func isJsFunction(funcName: String) -> Bool {
        return Bridge.JS_FUNCTION_NAME.caseInsensitiveCompare(funcName).rawValue == 0
    }
    
}

/**
 * NetExplorer class file
 * 网页浏览器
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: NetExplorer.swift 1 2017-08-18 12:12:06Z huan.song $
 * @since 1.0
 */
class NetExplorer: WKWebView {
    
    public static let TAG: String = "NetExplorer"
    
    /**
     * Navigation代理
     */
    private var mNavigationDelegate: NENavigationDelegate? = nil
    
    /**
     * UI代理
     */
    private var mUIDelegate: NEUIDelegate? = nil
    
    /**
     * Js请求和回调辅助类
     */
    private let mJsBridge: Bridge = Bridge()
    
    /**
     * 视图控制器
     */
    private let mViewController: UIViewController
    
    /**
     * 构造方法：初始化视图控制器
     *
     * @param viewController a UIViewController
     */
    public init(viewController: UIViewController) {
        mViewController = viewController
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = false
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController.add(mJsBridge, name: Bridge.JS_FUNCTION_NAME)
        
        super.init(frame: mViewController.view.bounds, configuration: configuration)
        
        mJsBridge.setWebView(wv: self)
        mViewController.view.addSubview(self)
        
        onInitialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * 初始化WebView
     */
    internal func onInitialize() {
        setNavigationDelegate(delegate: NENavigationDelegate(wv: self))
        setUIDelegate(delegate: NEUIDelegate(wv: self))
    }
    
    /**
     * 加载URL
     *
     * @param urlStr a url String
     */
    public func loadUrl(urlStr: String) {
        let url = URL(string: Http.urlEncode(url: urlStr))
        if url != nil {
            if url!.scheme == "" || url!.host == nil {
                loadUrl(urlStr: "http://\(urlStr)")
            } else {
                loadUrl(url: url!)
            }
        } else {
            print("\(NetExplorer.TAG) loadUrl() Error, urlStr: \"\(urlStr)\", urlEncode: \"\(Http.urlEncode(url: urlStr))\"")
        }
    }
    
    /**
     * 加载URL
     *
     * @param url a URL
     */
    public func loadUrl(url: URL) {
        load(URLRequest(url: url))
    }
    
    /**
     * 获取Navigation代理
     *
     * @return Navigation代理
     */
    public func getNavigationDelegate() -> NENavigationDelegate {
        return mNavigationDelegate!
    }
    
    /**
     * 设置Navigation代理
     *
     * @param delegate a NENavigationDelegate
     */
    public func setNavigationDelegate(delegate: NENavigationDelegate) {
        mNavigationDelegate = delegate
        self.navigationDelegate = mNavigationDelegate
    }
    
    /**
     * 获取UI代理
     *
     * @return UI代理
     */
    public func getUIDelegate() -> NEUIDelegate {
        return mUIDelegate!
    }
    
    /**
     * 设置UI代理
     *
     * @param delegate a NEUIDelegate
     */
    public func setUIDelegate(delegate: NEUIDelegate) {
        mUIDelegate = delegate
        self.uiDelegate = mUIDelegate
    }
    
    /**
     * 获取视图控制器
     *
     * @return 视图控制器
     */
    public func getViewController() -> UIViewController {
        return mViewController
    }
    
    /**
     * 获取Js请求和回调辅助类
     *
     * @return Js请求和回调辅助类
     */
    public func getJsBridge() -> Bridge {
        return mJsBridge
    }
    
}
