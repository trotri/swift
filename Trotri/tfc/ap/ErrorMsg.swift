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
 * ErrorMsg class file
 * 常用错误信息类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: ErrorMsg.swift 1 2017-07-27 16:05:06Z huan.song $
 * @since 1.0
 */
class ErrorMsg {
    /**
     * OK
     */
    public static let SUCCESS_MSG: String = "OK"
    
    /**
     * 请求错误
     */
    public static let ERROR_REQUEST: String = "Bad Request"
    
    /**
     * 用户没有访问权限
     */
    public static let ERROR_FORBIDDEN: String = "Forbidden"
    
    /**
     * 页面不存在
     */
    public static let ERROR_NOT_FOUND: String = "Not Found"
    
    /**
     * 系统运行异常
     */
    public static let ERROR_SYSTEM_RUN_ERR: String = "Internal Server Error"
    
    /**
     * 脚本运行失败
     */
    public static let ERROR_SCRIPT_RUN_ERR: String = "Not Implemented"
    
    /**
     * 参数错误
     */
    public static let ERROR_ARGS_ERR: String = "Args Error"
    
    /**
     * 结果为空
     */
    public static let ERROR_RESULT_EMPTY: String = "Result Empty"
    
    /**
     * 结果错误
     */
    public static let ERROR_RESULT_ERR: String = "Result Error"
    
    /**
     * Json解析异常
     */
    public static let ERROR_RESULT_JSON_SYNTAX_ERR: String = "Json Syntax Exception"
    
    /**
     * 未知错误
     */
    public static let ERROR_UNKNOWN: String = "Unknown Error"
    
    /**
     * 寄存常用错误码和错误信息
     */
    private static var mRegistry: Dictionary<Int, String> = [:]
    
    /**
     * 通过错误码获取错误信息
     *
     * @param errNo 错误码
     * @return 错误信息
     */
    public static func getErrMsg(errNo: Int) -> String {
        if mRegistry.isEmpty {
            mRegistry[ErrorNo.SUCCESS_NUM] = ErrorMsg.SUCCESS_MSG
            mRegistry[ErrorNo.ERROR_REQUEST] = ErrorMsg.ERROR_REQUEST
            mRegistry[ErrorNo.ERROR_FORBIDDEN] = ErrorMsg.ERROR_FORBIDDEN
            mRegistry[ErrorNo.ERROR_NOT_FOUND] = ErrorMsg.ERROR_NOT_FOUND
            mRegistry[ErrorNo.ERROR_SYSTEM_RUN_ERR] = ErrorMsg.ERROR_SYSTEM_RUN_ERR
            mRegistry[ErrorNo.ERROR_SCRIPT_RUN_ERR] = ErrorMsg.ERROR_SCRIPT_RUN_ERR
            mRegistry[ErrorNo.ERROR_ARGS_ERR] = ErrorMsg.ERROR_ARGS_ERR
            mRegistry[ErrorNo.ERROR_RESULT_EMPTY] = ErrorMsg.ERROR_RESULT_EMPTY
            mRegistry[ErrorNo.ERROR_RESULT_ERR] = ErrorMsg.ERROR_RESULT_ERR
            mRegistry[ErrorNo.ERROR_RESULT_JSON_SYNTAX_ERR] = ErrorMsg.ERROR_RESULT_JSON_SYNTAX_ERR
            mRegistry[ErrorNo.ERROR_UNKNOWN] = ErrorMsg.ERROR_UNKNOWN
        }
        
        return mRegistry[errNo] == nil ? ErrorMsg.ERROR_UNKNOWN : mRegistry[errNo]!
    }
    
}
