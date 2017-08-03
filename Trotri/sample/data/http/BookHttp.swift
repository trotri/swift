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
 * BookHttp class file
 * Book HTTP类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: BookHttp.swift 1 2017-07-31 10:00:06Z huan.song $
 * @since 1.0
 */
class BookHttp: BaseHttp {
    /**
     * 通过id获取详情
     *
     * @param id       Id
     * @param delegate 回执线程的处理协议
     */
    public func getRow(id: UInt64, delegate: BookDelegate) {
        /**
         * DataHttp Delegate
         * 回执线程的处理协议
         */
        class DataHttpDelegateImpl: DataHttpDelegate {
            /**
             * Book回执线程的处理协议
             */
            let mBookDelegateImpl: BookDelegate
            
            /**
             * 构造方法：初始化Book回执线程的处理协议
             */
            init(delegate: BookDelegate) {
                mBookDelegateImpl = delegate
            }
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )
             *
             * @param result 数据适配器
             */
            func onSuccess(result: DataResult) {
                if result.isSuccess() {
                    let data = BookEntity.newObject(with: result.getData())
                    if data != nil {
                        mBookDelegateImpl.onSuccess(data: data!)
                    } else {
                        mBookDelegateImpl.onFailure(errNo: ErrorNo.ERROR_RESULT_ERR, errMsg: ErrorMsg.ERROR_RESULT_ERR)
                    }
                } else {
                    mBookDelegateImpl.onFailure(errNo: result.getErrNo(), errMsg: result.getErrMsg())
                }
            }
            
            /**
             * Http请求失败后回调方法，HTTP状态码 != SC_OK ( 200 )
             *
             * @param statusCode HTTP状态码
             * @param message HTTP消息
             */
            func onFailure(statusCode: Int, message: String) {
                mBookDelegateImpl.onHttpFailure(statusCode: statusCode, message: message)
            }
            
            /**
             * 打开URL链接失败后回调方法
             *
             * @param err a DataError 失败原因
             */
            func onError(err: DataError) {
                mBookDelegateImpl.onError(err: err)
            }
        }
        
        DataHttp.post(url: getBookDetailUrl(), params: ["id": "\(id)"], delegate: DataHttpDelegateImpl(delegate: delegate))
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
         * DataListHttp Delegate
         * 回执线程的处理协议
         */
        class DataListHttpDelegateImpl: DataListHttpDelegate {
            /**
             * Book回执线程的处理协议
             */
            let mBookDelegateImpl: BookDelegate
            
            /**
             * 构造方法：初始化Book回执线程的处理协议
             */
            init(delegate: BookDelegate) {
                mBookDelegateImpl = delegate
            }
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )
             *
             * @param result 数据适配器
             */
            func onSuccess(result: DataListResult) {
                if result.isSuccess() {
                    let data: DataList = result.getData()
                    mBookDelegateImpl.onSuccess(dataList: BookEntity.BookList.newObject(with: data))
                } else {
                    mBookDelegateImpl.onFailure(errNo: result.getErrNo(), errMsg: result.getErrMsg())
                }
            }
            
            /**
             * Http请求失败后回调方法，HTTP状态码 != SC_OK ( 200 )
             *
             * @param statusCode HTTP状态码
             * @param message HTTP消息
             */
            func onFailure(statusCode: Int, message: String) {
                mBookDelegateImpl.onHttpFailure(statusCode: statusCode, message: message)
            }
            
            /**
             * 打开URL链接失败后回调方法
             *
             * @param err a DataError 失败原因
             */
            func onError(err: DataError) {
                mBookDelegateImpl.onError(err: err)
            }
        }
        
        DataListHttp.post(url: getBookListUrl(), params: ["offset": "\(offset)", "limit": "\(limit)"], delegate: DataListHttpDelegateImpl(delegate: delegate))
    }
    
    /**
     * 获取详情链接
     */
    public func getBookDetailUrl() -> String {
        return getBaseUrl() + "action/book_detail"
    }
    
    /**
     * 获取列表链接
     */
    public func getBookListUrl() -> String {
        return getBaseUrl() + "action/book_list"
    }
    
}
