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
 * BookDelegate Delegate
 * Book回执线程的处理协议
 *
 * @since 1.0
 */
protocol BookDelegate {
    /**
     * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo = HttpErrNo.SUCCESS_NUM
     *
     * @param data Book实体类
     */
    func onSuccess(data: BookEntity)
    
    /**
     * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo = HttpErrNo.SUCCESS_NUM
     *
     * @param dataList Book列表数据结构
     */
    func onSuccess(dataList: BookEntity.BookList)
    
    /**
     * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo != HttpErrNo.SUCCESS_NUM
     *
     * @param errNo 错误码
     * @param errMsg 错误消息
     */
    func onFailure(errNo: Int, errMsg: String)
    
    /**
     * Http请求失败后回调方法，HTTP状态码 != SC_OK ( 200 )
     *
     * @param statusCode HTTP状态码
     * @param message HTTP消息
     */
    func onHttpFailure(statusCode: Int, message: String)
    
    /**
     * 打开URL链接失败后回调方法
     *
     * @param err a DataError 失败原因
     */
    func onError(err: DataError)
}

/**
 * BookService class file
 * Book 业务类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: BookService.swift 1 2017-07-31 10:00:06Z huan.song $
 * @since 1.0
 */
class BookService {
    /**
     * 数据列表
     */
    private var mData: Dictionary<String, Array<BookEntity>> = [String: Array<BookEntity>]()
    
    /**
     * 键集
     */
    private var mKeys: Array<String> = []
    
    /**
     * Book HTTP类
     */
    private let mHttp: BookHttp = BookHttp()
    
    /**
     * 通过id获取详情
     *
     * @param id       Id
     * @param delegate 回执线程的处理协议
     */
    public func getRow(id: UInt64, delegate: BookDelegate) {
        mHttp.getRow(id: id, delegate: delegate)
    }
    
    /**
     * 获取列表数据
     *
     * @param offset   查询起始位置 SELECT * FROM table LIMIT [offset], limit;
     * @param limit    查询记录数 SELECT * FROM table LIMIT offset, [limit];
     * @param delegate 回执线程的处理协议
     */
    public func findRows(offset: Int, limit: Int, delegate: BookDelegate) {
        /**
         * BookDelegate Delegate
         * Book回执线程的处理协议
         */
        class BookDelegateImpl: BookDelegate {
            /**
             * Book回执线程的处理协议
             */
            let mDelegateImpl: BookDelegate
            
            /**
             * Book业务类
             */
            let mService: BookService
            
            /**
             * 构造方法：初始化Book回执线程的处理协议
             */
            init(delegate: BookDelegate, service: BookService) {
                mDelegateImpl = delegate
                mService = service
            }
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo = HttpErrNo.SUCCESS_NUM
             *
             * @param data Book实体类
             */
            func onSuccess(data: BookEntity) {}
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo = HttpErrNo.SUCCESS_NUM
             *
             * @param dataList Book列表数据结构
             */
            func onSuccess(dataList: BookEntity.BookList) {
                let rows: Array<BookEntity> = dataList.getRows()
                for row in rows {
                    if mService.mData[row.getType()] == nil {
                        mService.mData[row.getType()] = [row]
                    } else {
                        mService.mData[row.getType()]!.append(row)
                    }
                }
                
                mService.mKeys = Array(mService.mData.keys)
                mDelegateImpl.onSuccess(dataList: dataList)
            }
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo != HttpErrNo.SUCCESS_NUM
             *
             * @param errNo 错误码
             * @param errMsg 错误消息
             */
            func onFailure(errNo: Int, errMsg: String) {
                mDelegateImpl.onFailure(errNo: errNo, errMsg: errMsg)
            }
            
            /**
             * Http请求失败后回调方法，HTTP状态码 != SC_OK ( 200 )
             *
             * @param statusCode HTTP状态码
             * @param message HTTP消息
             */
            func onHttpFailure(statusCode: Int, message: String) {
                mDelegateImpl.onHttpFailure(statusCode: statusCode, message: message)
            }
            
            /**
             * 打开URL链接失败后回调方法
             *
             * @param err a DataError 失败原因
             */
            func onError(err: DataError) {
                mDelegateImpl.onError(err: err)
            }
            
        }
        
        mHttp.findRows(offset: offset, limit: limit, delegate: BookDelegateImpl(delegate: delegate, service: self))
    }
    
    /**
     * 获取全部数据
     */
    public func getData() -> Dictionary<String, Array<BookEntity>> {
        return mData
    }
    
    /**
     * 通过section获取列表数据
     */
    public func getRows(section: Int) -> Array<BookEntity>? {
        let key = getKey(section: section)
        if key == nil {
            return nil
        }
        
        return getRows(key: key!)
    }
    
    /**
     * 通过key获取列表数据
     */
    public func getRows(key: String) -> Array<BookEntity>? {
        return mData[key]
    }
    
    /**
     * 通过位置获取详情
     *
     * @param indexPath IndexPath
     */
    public func getRow(indexPath: IndexPath) -> BookEntity? {
        let rows = getRows(section: indexPath.section)
        if rows == nil {
            return nil
        }
        
        return rows![indexPath.row]
    }
    
    /**
     * 通过id获取详情
     *
     * @param id Id
     */
    public func getRow(id: UInt64) -> BookEntity? {
        let data: Dictionary<String, Array<BookEntity>> = getData()
        
        for (_, rows) in data {
            for row in rows {
                if row.getId() == id {
                    return row
                }
            }
        }
        
        return nil
    }
    
    /**
     * 通过section获取Key
     *
     * @param section Int
     */
    public func getKey(section: Int) -> String? {
        let keys: Array<String> = getKeys()
        return keys[section]
    }
    
    /**
     * 获取所有的Key
     */
    public func getKeys() -> Array<String> {
        return mKeys
    }
    
    /**
     * 获取section数
     */
    public func getSectionCount() -> Int {
        return getKeys().count
    }
    
    /**
     * 获取section中数据量
     */
    public func getRowCount(section: Int) -> Int {
        let rows = getRows(section: section)
        if rows == nil {
            return 0
        }
        
        return rows!.count
    }
    
}
