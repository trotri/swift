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
 * DataResult class file
 * 数据适配器
 * Json => {"errNo":0,"errMsg":"OK","data":{"id":1,"title":"Java编程思想","isRecommend":false}}
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: DataResult.swift 1 2017-07-28 10:08:06Z huan.song $
 * @since 1.0
 */
class DataResult: DataAdapter {
    /**
     * 默认的数据
     */
    public static let DEFAULT_DATA: Dictionary<String, Any> = [:]
    
    /**
     * 数据
     */
    private var mData: Dictionary<String, Any> = DataResult.DEFAULT_DATA
    
    /**
     * toString
     */
    override var description: String {
        let data: String = TypeCast.toStr(dict: getData(), defaultValue: "[:]")
        return "\(super.description) -> [ \(data) ]"
    }
    
    /**
     * 构造方法：初始化所有属性
     *
     * @param errNo  错误码
     * @param errMsg 错误消息
     * @param data   数据
     */
    public convenience init(errNo: Int, errMsg: String, data: Dictionary<String, Any>) {
        self.init()
        
        setErrNo(errNo: errNo)
        setErrMsg(errMsg: errMsg)
        setData(data: data)
    }
    
    /**
     * 获取数据
     */
    public func getData() -> Dictionary<String, Any> {
        return mData
    }
    
    /**
     * 设置数据
     *
     * @param data 数据
     */
    public func setData(data: Dictionary<String, Any>) {
        mData = data
    }
    
    /**
     * 通过HTTP返回数据新建实例
     *
     * @param data HTTP返回数据
     */
    public static func newObject(with data: Data) -> DataResult {
        let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
        if dict == nil {
            return DataResult()
        }
        
        return DataResult.newObject(with: dict!)
    }
    
    /**
     * 通过字典新建实例
     *
     * @param dict 字典
     */
    public static func newObject(with dict: Dictionary<String, Any>) -> DataResult {
        let errNo: Int = TypeCast.toInt(value: dict["errNo"], defaultValue: DataAdapter.DEFAULT_ERR_NO)
        let errMsg: String = TypeCast.toStr(value: dict["errMsg"], defaultValue: DataAdapter.DEFAULT_ERR_MSG)
        let data: Dictionary<String, Any> = TypeCast.toDictionary(value: dict["data"], defaultValue: DataResult.DEFAULT_DATA)
        
        return DataResult(errNo: errNo, errMsg: errMsg, data: data)
    }
    
}
