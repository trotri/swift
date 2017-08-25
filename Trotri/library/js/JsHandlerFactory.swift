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
 * JsHandler Delegate
 * Js处理协议
 *
 * @since 1.0
 */
protocol JsHandlerDelegate {
    /**
     * 执行处理
     *
     * @param bridge    a Bridge
     * @param key       回调函数Key
     * @param parameter a Json, or ""
     */
    func run(bridge: Bridge, key: String, parameter: String)
}

/**
 * HandlerFactory class file
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: HandlerFactory.swift 1 2017-08-18 15:07:06Z huan.song $
 * @since 1.0
 */
class JsHandlerFactory: NSObject {
    /**
     * Js处理器寄存器
     */
    private static var sHandlers: Dictionary<String, JsHandlerDelegate> = [:]
    
    /**
     * 获取Js处理器
     *
     * @param method Js方法名
     * @return Js处理器, or nil
     */
    public static func getHandler(method: String) -> JsHandlerDelegate? {
        var handler = sHandlers[method]
        if handler != nil {
            return handler
        }
        
        handler = newHandler(method: method)
        if handler != nil {
            sHandlers[method] = handler
        }
        
        return handler
    }
    
    /**
     * 实例化一个Js处理器
     *
     * @param method Js方法名
     * @return Js处理器, or nil
     */
    public static func newHandler(method: String) -> JsHandlerDelegate? {
        var handler: JsHandlerDelegate? = nil
        
        if ToastHandler.METHOD_NAME.caseInsensitiveCompare(method).rawValue == 0 {
            handler = ToastHandler()
        } else if VersionHandler.METHOD_NAME.caseInsensitiveCompare(method).rawValue == 0 {
            handler = VersionHandler()
        }
        
        return handler
    }
    
}
