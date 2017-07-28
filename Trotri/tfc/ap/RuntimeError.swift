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
 * RuntimeError class file
 * 程序运行时发生的错误
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: RuntimeError.swift 1 2017-07-28 14:05:06Z huan.song $
 * @since 1.0
 */
class RuntimeError: CustomStringConvertible, LocalizedError {
    /**
     * 默认的错误码、错误消息
     */
    public static let DEFAULT_CODE: Int = 0
    public static let DEFAULT_MESSAGE: String = ""
    
    /**
     * 错误码
     */
    private var mCode: Int = RuntimeError.DEFAULT_CODE
    
    /**
     * 错误消息
     */
    private var mMessage: String = RuntimeError.DEFAULT_MESSAGE
    
    /**
     * toString
     */
    var description: String {
        return "[ code: \(getCode()), message: \"\(getMessage())\" ]"
    }
    
    /**
     * toString localizedDescription
     */
    var errorDescription: String? {
        return self.description
    }
    
    /**
     * 构造方法：初始化所有属性
     *
     * @param code    错误码
     * @param message 错误消息
     */
    public init(code: Int, message: String) {
        mCode = code
        mMessage = message
    }
    
    /**
     * 获取错误码
     *
     * @return 错误码
     */
    public func getCode() -> Int {
        return mCode
    }
    
    /**
     * 获取错误消息
     *
     * @return 错误消息
     */
    public func getMessage() -> String {
        return mMessage
    }
    
}
