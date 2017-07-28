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

/**
 * DataAdapter class file
 * 数据适配器基类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: DataAdapter.swift 1 2017-07-27 16:05:06Z huan.song $
 * @since 1.0
 */
class DataAdapter: CustomStringConvertible {
    /**
     * 默认的错误码、错误消息
     */
    public static let DEFAULT_ERR_NO: Int = ErrorNo.ERROR_UNKNOWN
    public static let DEFAULT_ERR_MSG: String = ErrorMsg.ERROR_UNKNOWN
    
    /**
     * 错误码
     */
    private var mErrNo: Int = DataAdapter.DEFAULT_ERR_NO
    
    /**
     * 错误消息
     */
    private var mErrMsg: String = DataAdapter.DEFAULT_ERR_MSG
    
    /**
     * toString
     */
    var description: String {
        return "[ errNo: \(getErrNo()), errMsg: \"\(getErrMsg())\" ]"
    }
    
    /**
     * 构造方法：初始化所有属性
     *
     * @param errNo  错误码
     * @param errMsg 错误消息
     */
    public convenience init(errNo: Int, errMsg: String) {
        self.init()
        
        self.setErrNo(errNo: errNo)
        self.setErrMsg(errMsg: errMsg)
    }
    
    /**
     * 获取请求是否成功
     */
    public func isSuccess() -> Bool {
        return getErrNo() == ErrorNo.SUCCESS_NUM
    }
    
    /**
     * 获取错误码
     *
     * @return 错误码
     */
    public func getErrNo() -> Int {
        return mErrNo
    }
    
    /**
     * 设置错误码
     *
     * @param errNo 错误码
     */
    public func setErrNo(errNo: Int) {
        mErrNo = errNo
    }
    
    /**
     * 获取错误消息
     *
     * @return 错误消息
     */
    public func getErrMsg() -> String {
        return mErrMsg
    }
    
    /**
     * 设置错误消息
     *
     * @param errMsg 错误消息
     */
    public func setErrMsg(errMsg: String) {
        mErrMsg = errMsg
    }
    
}
