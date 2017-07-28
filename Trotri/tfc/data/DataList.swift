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
 * DataList class file
 * 列表数据结构
 * Json => {"total":24,"limit":8,"offset":0,"rows":[{"id":1,"title":"Java编程思想","isRecommend":false},{"id":2,"title":"C++编程思想","isRecommend":false},{"id":3,"title":"高性能MySQL","isRecommend":false}]}
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: DataList.swift 1 2017-07-27 16:05:06Z huan.song $
 * @since 1.0
 */
class DataList: CustomStringConvertible {
    /**
     * 默认的总记录数、查询记录数和数据
     */
    public static let DEFAULT_TOTAL: UInt64 = 0
    public static let DEFAULT_LIMIT: Int = 0
    public static let DEFAULT_OFFSET: Int = 0
    public static let DEFAULT_ROWS: Array<Dictionary<String, Any>> = []
    
    /**
     * 总记录数
     */
    private var mTotal: UInt64 = DataList.DEFAULT_TOTAL
    
    /**
     * 查询记录数 SELECT * FROM table LIMIT offset, [limit];
     */
    private var mLimit: Int = DataList.DEFAULT_LIMIT
    
    /**
     * 查询起始位置 SELECT * FROM table LIMIT [offset], limit;
     */
    private var mOffset: Int = DataList.DEFAULT_OFFSET
    
    /**
     * 数据
     */
    private var mRows: Array<Dictionary<String, Any>> = DataList.DEFAULT_ROWS
    
    /**
     * toString
     */
    var description: String {
        return "[ total: \(getTotal()), limit: \(getLimit()), offset: \(getOffset()), size: \(getSize()) ]"
    }
    
    /**
     * 构造方法：初始化所有属性
     *
     * @param total  总记录数
     * @param limit  查询记录数
     * @param offset 查询起始位置
     * @param rows   数据
     */
    public convenience init(total: UInt64, limit: Int, offset: Int, rows: Array<Dictionary<String, Any>>) {
        self.init()
        
        setTotal(total: total)
        setLimit(limit: limit)
        setOffset(offset: offset)
        setRows(rows: rows)
    }
    
    /**
     * 获取总记录数
     *
     * @return 总记录数
     */
    public func getTotal() -> UInt64 {
        return mTotal
    }
    
    /**
     * 设置总记录数
     *
     * @param total 总记录数
     */
    public func setTotal(total: UInt64) {
        mTotal = total
    }
    
    /**
     * 获取查询记录数
     *
     * @return 查询记录数
     */
    public func getLimit() -> Int {
        return mLimit
    }
    
    /**
     * 设置查询记录数
     *
     * @param limit 查询记录数
     */
    public func setLimit(limit: Int) {
        mLimit = limit
    }
    
    /**
     * 获取查询起始位置
     *
     * @return 查询起始位置
     */
    public func getOffset() -> Int {
        return mOffset
    }
    
    /**
     * 设置查询起始位置
     *
     * @param offset 查询起始位置
     */
    public func setOffset(offset: Int) {
        mOffset = offset
    }
    
    /**
     * 获取列表记录数
     *
     * @return 列表记录数
     */
    public func getSize() -> Int {
        return getRows().count
    }
    
    /**
     * 获取列表
     *
     * @return 列表
     */
    public func getRows() -> Array<Dictionary<String, Any>> {
        return mRows
    }
    
    /**
     * 设置列表
     *
     * @param rows 列表
     */
    public func setRows(rows: Array<Dictionary<String, Any>>) {
        mRows = rows
    }
    
    /**
     * 通过字典新建实例
     *
     * @param dict 字典
     */
    public static func newObject(with dict: Dictionary<String, Any>) -> DataList {
        let total: UInt64 = TypeCast.toUInt64(value: dict["total"], defaultValue: DataList.DEFAULT_TOTAL)
        let limit: Int = TypeCast.toInt(value: dict["limit"], defaultValue: DataList.DEFAULT_LIMIT)
        let offset: Int = TypeCast.toInt(value: dict["offset"], defaultValue: DataList.DEFAULT_OFFSET)
        let rows: Array<Dictionary<String, Any>> = TypeCast.toArrayDictionary(value: dict["rows"], defaultValue: DataList.DEFAULT_ROWS)
        
        return DataList(total: total, limit: limit, offset: offset, rows: rows)
    }
    
}
