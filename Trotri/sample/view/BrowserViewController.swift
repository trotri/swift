//
//  BrowserViewController.swift
//  Trotri
//
//  Created by songhuan on 2017/8/22.
//  Copyright © 2017年 songhuan. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {
    
    private var mWebView: NetExplorer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mWebView = NetExplorer(viewController: self)
        
        let url = Bundle.main.url(forResource: "demo", withExtension: "html")
        mWebView.loadUrl(url: url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
