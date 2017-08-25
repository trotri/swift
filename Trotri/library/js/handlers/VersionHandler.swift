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
 * VersionHandler class file
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: VersionHandler.swift 1 2017-08-18 15:07:06Z huan.song $
 * @since 1.0
 */
class VersionHandler: JsHandlerDelegate {
    /**
     * Js方法名
     */
    public static let METHOD_NAME: String = "getVersion"
    
    public func run(bridge: Bridge, key: String, parameter: String) {
        let result: Result = Result(code: Version.getCode(), name: Version.getName())
        bridge.loadListen(key: key, data: result.toJson())
    }
    
    /**
     * 回调数据
     */
    class Result {
        /**
         * 版本号，从1开始
         */
        private let mCode: Int
        
        /**
         * 版本名
         */
        private let mName: String
        
        /**
         * 构造方法：初始化版本号、版本名
         *
         * @param code 版本号
         * @param name 版本名
         */
        public init(code: Int, name: String) {
            mCode = code
            mName = name
        }
        
        /**
         * 转Json格式
         *
         * @return a Json String
         */
        public func toJson() -> String {
            let data: Data = try! JSONSerialization.data(withJSONObject: ["code": mCode, "name": mName], options: JSONSerialization.WritingOptions.prettyPrinted)
            return String(data: data, encoding: String.Encoding.utf8)!
        }
        
    }
    
}
