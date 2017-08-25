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
 * Version class file
 * 版本信息类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: Version.swift 1 2017-07-27 16:05:06Z huan.song $
 * @since 1.0
 */
final class Version {
    /**
     * 版本号，从1开始 [Identity -> Build]
     * 设置时用Int类型
     */
    private static var mCode: Int = 0
    
    /**
     * 版本名 [Identity -> Version]
     */
    private static var mName: String = ""
    
    /**
     * 是否已经初始化
     */
    private static var mIsInitialized: Bool = false
    
    /**
     * 初始化WebView
     */
    private static func onInitialize() {
        mIsInitialized = true
        
        let infoDict = Bundle.main.infoDictionary!
        
        let tmpCode: String = TypeCast.toStr(value: infoDict["CFBundleVersion"], defaultValue: "0").replacingOccurrences(of: ".", with: "")
        mCode = Int(tmpCode)!
        
        mName = TypeCast.toStr(value: infoDict["CFBundleShortVersionString"], defaultValue: "")
    }
    
    /**
     * 获取版本号
     *
     * @return 如果获取成功返回 > 0，否则返回0
     */
    public static func getCode() -> Int {
        if !mIsInitialized {
            onInitialize()
        }
        
        return mCode
    }
    
    /**
     * 获取版本名
     *
     * @return 如果获取成功返回非空字符串，否则返回空字符串
     */
    public static func getName() -> String {
        if !mIsInitialized {
            onInitialize()
        }
        
        return mName
    }
    
}
