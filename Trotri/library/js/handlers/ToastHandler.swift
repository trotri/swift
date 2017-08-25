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
 * ToastHandler class file
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: ToastHandler.swift 1 2017-08-18 15:07:06Z huan.song $
 * @since 1.0
 */
class ToastHandler: JsHandlerDelegate {
    /**
     * Js方法名
     */
    public static let METHOD_NAME: String = "toast"
    
    public func run(bridge: Bridge, key: String, parameter: String) {
        let p = Parameter.create(jsonStr: parameter)
        if p == nil {
            bridge.loadJsonSyntaxException(key: key)
            return
        }
        
        Toast.makeText(viewController: bridge.getWebView().getViewController(), text: p!.getText(), duration: p!.isLong() ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT).show()
        bridge.loadListen(key: key, data: "")
    }
    
    /**
     * Js参数
     */
    class Parameter {
        /**
         * 提示内容
         */
        private var mText: String = ""
        
        /**
         * 展示时长
         */
        private var mIsLong: Bool = false
        
        /**
         * toString
         */
        var description: String {
            return "[ text: \(getText()), isLong: \"\(isLong())\" ]"
        }
        
        /**
         * 构造方法：解析Json初始化所有属性
         *
         * @param text 提示内容
         * @param isLong 展示时长
         */
        public init(text: String, isLong: Bool) {
            mText = text
            mIsLong = isLong
        }
        
        /**
         * 通过解析Json字符串，创建参数类
         *
         * @param jsonStr 参数
         * @return a Parameter Object
         */
        public static func create(jsonStr: String) -> Parameter? {
            let data = jsonStr.replacingOccurrences(of: "\\", with: "").data(using: String.Encoding.utf8)
            if data == nil {
                return nil
            }
            
            let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
            if dict == nil {
                return nil
            }
            
            let text: String = TypeCast.toStr(value: dict!["text"], defaultValue: "")
            let isLong: Bool = TypeCast.toBool(value: dict!["isLong"], defaultValue: false)
            return Parameter(text: text, isLong: isLong)
        }
        
        /**
         * 获取提示内容
         *
         * @return 提示内容
         */
        public func getText() -> String {
            return mText
        }
        
        /**
         * 展示时长
         *
         * @return 是否长时间展示
         */
        public func isLong() -> Bool {
            return mIsLong
        }
        
    }
    
}
