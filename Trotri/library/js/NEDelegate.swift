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
 * NENavigationDelegate class file
 * 网页浏览器Navigation代理
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: NEDelegate.swift 1 2017-08-18 12:12:06Z huan.song $
 * @since 1.0
 */
class NENavigationDelegate: NSObject, WKNavigationDelegate {
    
    public static let TAG: String = "NENavigationDelegate"
    
    /**
     * a NetExplorer
     */
    private let mWebView: NetExplorer
    
    /**
     * 构造方法：初始化WebView
     *
     * @param wv a NetExplorer
     */
    public init(wv: NetExplorer) {
        mWebView = wv
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("\(NENavigationDelegate.TAG) Start Provisional Navigation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("\(NENavigationDelegate.TAG) Commit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("\(NENavigationDelegate.TAG) Finish")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(NENavigationDelegate.TAG) Failure")
    }
    
}

/**
 * NEUIDelegate class file
 * 网页浏览器UI代理
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: NEDelegate.swift 1 2017-08-18 12:12:06Z huan.song $
 * @since 1.0
 */
class NEUIDelegate: NSObject, WKUIDelegate {
    
    public static let TAG: String = "NEUIDelegate"
    
    /**
     * 提示框标题
     */
    public static let DIALOG_TITLE: String = "Tips"
    
    /**
     * 提示框按钮：确定
     */
    public static let DIALOG_OK: String = "OK"
    
    /**
     * 提示框按钮：取消
     */
    public static let DIALOG_CANCEL: String = "Cancel"
    
    /**
     * a NetExplorer
     */
    private let mWebView: NetExplorer
    
    /**
     * 构造方法：初始化WebView
     *
     * @param wv a NetExplorer
     */
    public init(wv: NetExplorer) {
        mWebView = wv
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: NEUIDelegate.DIALOG_TITLE, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: NEUIDelegate.DIALOG_OK, style: UIAlertActionStyle.default, handler: { (_) -> Void in
            completionHandler()
        }))
        
        mWebView.getViewController().present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: NEUIDelegate.DIALOG_TITLE, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: NEUIDelegate.DIALOG_OK, style: UIAlertActionStyle.default, handler: { (_) -> Void in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: NEUIDelegate.DIALOG_CANCEL, style: UIAlertActionStyle.cancel, handler: { (_) -> Void in
            completionHandler(false)
        }))
        
        mWebView.getViewController().present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: prompt, message: defaultText, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField: UITextField) -> Void in
            textField.textColor = UIColor.red
        }
        
        alertController.addAction(UIAlertAction(title: NEUIDelegate.DIALOG_OK, style: UIAlertActionStyle.default, handler: { (_) -> Void in
            completionHandler(alertController.textFields![0].text!)
        }))
        
        mWebView.getViewController().present(alertController, animated: true, completion: nil)
    }
    
}
