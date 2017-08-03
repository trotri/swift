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

import UIKit

/**
 * Toast final class file
 * A toast is a view containing a quick little message for the user.
 * The toast class helps you create and show those.
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: Toast.swift 1 2017-07-06 10:00:06Z huan.song $
 * @since 1.0
 */
class Toast {
    /**
     * Show the view or text notification for a short period of time 1500 milliseconds.
     */
    public static let LENGTH_SHORT: Int = 0
    
    /**
     * Show the view or text notification for a short period of time 3500 milliseconds.
     */
    public static let LENGTH_LONG: Int = 1
    
    private static let SHORT_DELAY: Int = 1500
    private static let LONG_DELAY: Int = 3500
    
    private let mViewController: UIViewController
    
    private var mText: String = ""
    
    private var mDuration: Int = Toast.LENGTH_SHORT
    
    private init(viewController: UIViewController) {
        self.mViewController = viewController
    }
    
    public static func makeText(viewController: UIViewController, text: String, duration: Int) -> Toast {
        let result: Toast = Toast(viewController: viewController)
        
        result.mText = text
        result.mDuration = duration
        
        return result
    }
    
    public func show() {
        let delayMS: Int = (self.mDuration == Toast.LENGTH_LONG) ? Toast.LONG_DELAY : Toast.SHORT_DELAY
        
        let vAlert: UIAlertController = UIAlertController(title: self.mText, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        self.mViewController.present(vAlert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(delayMS)) {
            self.mViewController.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
