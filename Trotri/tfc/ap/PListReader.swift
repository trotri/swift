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
 * PListReader class file
 * 读取Bundle的.plist数据
 * 注：所有目录下的.plist文件不能同名（不区分大小写）
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: PListReader.swift 1 2017-07-28 18:53:06Z huan.song $
 * @since 1.0
 */
class PListReader: CustomStringConvertible {
    
    public static let TAG: String = "PListReader"
    
    /**
     * 资源后缀
     */
    public static let TYPE_EXT: String = "plist"
    
    /**
     * 列表数据
     */
    private let mData: NSDictionary
    
    /**
     * 资源路径
     */
    private let mFileName: String
    
    /**
     * 资源名
     */
    private let mResourceName: String
    
    /**
     * @var array instances of PListReader 资源名 => 数据
     */
    private static var sInstances: Dictionary<String, PListReader> = [:]
    
    /**
     * toString
     */
    var description: String {
        return "[ resourceName: \"\(getResourceName())\", fileName: \"\(getFileName())\", size: \(getSize()) ]"
    }
    
    /**
     * 构造方法：初始化资源名、资源路径和列表数据
     *
     * @param forResource name 资源名
     */
    private init(forResource name: String) {
        mResourceName = name
        
        let fileName = Bundle.main.path(forResource: name, ofType: PListReader.TYPE_EXT)
        if fileName == nil {
            mFileName = ""
            mData = [:]
            print("\(PListReader.TAG) init() Error, fileName is nil, resourceName: \(mResourceName)")
            return
        }
        
        mFileName = fileName!
        let tmpData = NSDictionary(contentsOfFile: mFileName)
        if tmpData == nil {
            mData = [:]
            print("\(PListReader.TAG) init() Error, data is nil, resourceName: \(mResourceName), fileName: \(mFileName)")
            return
        }
        
        mData = tmpData!
    }
    
    /**
     * 单例模式：获取本类的实例
     *
     * @param forResource name 资源名
     */
    public static func getInstance(forResource name: String) -> PListReader {
        let resourceName: String = name.trimmingCharacters(in: CharacterSet.whitespaces)
        if PListReader.sInstances[resourceName] == nil {
            PListReader.sInstances[resourceName] = PListReader(forResource: resourceName)
        }
        
        return PListReader.sInstances[resourceName]!
    }
    
    /**
     * 获取列表数据
     *
     * @return 列表数据
     */
    public func getData() -> NSDictionary {
        return mData
    }
    
    /**
     * 获取资源路径
     *
     * @return 资源路径
     */
    public func getFileName() -> String {
        return mFileName
    }
    
    /**
     * 获取资源名
     *
     * @return 资源名
     */
    public func getResourceName() -> String {
        return mResourceName
    }
    
    /**
     * 获取列表记录数
     *
     * @return 列表记录数
     */
    public func getSize() -> Int {
        return getData().count
    }
    
}
