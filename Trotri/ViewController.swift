//
//  ViewController.swift
//  Trotri
//
//  Created by songhuan on 2017/7/27.
//  Copyright © 2017年 songhuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toBrowser(_ sender: UIButton) {
        let viewController = BrowserViewController()
        self.present(viewController, animated: true, completion: nil)
    }
    
}
