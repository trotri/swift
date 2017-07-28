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
 * DataListResult class file
 * 列表数据适配器
 * Json => {"errNo":0,"errMsg":"OK","data":{"total":24,"limit":8,"offset":0,"rows":[{"id":1,"title":"Java编程思想","isRecommend":false},{"id":2,"title":"C++编程思想","isRecommend":false},{"id":3,"title":"高性能MySQL","isRecommend":false}]}}
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: DataListResult.swift 1 2017-07-28 10:08:06Z huan.song $
 * @since 1.0
 */
class DataListResult: DataAdapter {
    /**
     * 默认的数据
     */
    public static let DEFAULT_DATA: DataList = DataList()
    
    /**
     * 数据
     */
    private var mData: DataList = DataListResult.DEFAULT_DATA
    
    /**
     * toString
     */
    override var description: String {
        return "\(super.description) -> [ \(getData().description) ]"
    }
    
    /**
     * 构造方法：初始化所有属性
     *
     * @param errNo  错误码
     * @param errMsg 错误消息
     * @param data   数据
     */
    public convenience init(errNo: Int, errMsg: String, data: DataList) {
        self.init()
        
        setErrNo(errNo: errNo)
        setErrMsg(errMsg: errMsg)
        setData(data: data)
    }
    
    /**
     * 获取数据
     */
    public func getData() -> DataList {
        return mData
    }
    
    /**
     * 设置数据
     *
     * @param data 数据
     */
    public func setData(data: DataList) {
        mData = data
    }
    
    /**
     * 通过HTTP返回数据新建实例
     *
     * @param data HTTP返回数据
     */
    public static func newObject(with data: Data) -> DataListResult {
        let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
        if dict == nil {
            return DataListResult()
        }
        
        return DataListResult.newObject(with: dict!)
    }
    
    /**
     * 通过字典新建实例
     *
     * @param dict 字典
     */
    public static func newObject(with dict: Dictionary<String, Any>) -> DataListResult {
        let errNo: Int = TypeCast.toInt(value: dict["errNo"], defaultValue: DataAdapter.DEFAULT_ERR_NO)
        let errMsg: String = TypeCast.toStr(value: dict["errMsg"], defaultValue: DataAdapter.DEFAULT_ERR_MSG)
        let data: DataList = DataList.newObject(with: TypeCast.toDictionary(value: dict["data"], defaultValue: [:]))
        
        return DataListResult(errNo: errNo, errMsg: errMsg, data: data)
    }
    
}
