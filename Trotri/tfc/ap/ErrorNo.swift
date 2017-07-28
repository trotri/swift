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
 * ErrorNo class file
 * 常用错误码类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: ErrorNo.swift 1 2017-07-27 16:05:06Z huan.song $
 * @since 1.0
 */
class ErrorNo {
    /**
     * OK
     */
    public static let SUCCESS_NUM: Int = 0
    
    /**
     * 请求错误
     */
    public static let ERROR_REQUEST: Int = 400
    
    /**
     * 用户没有访问权限
     */
    public static let ERROR_FORBIDDEN: Int = 403
    
    /**
     * 页面不存在
     */
    public static let ERROR_NOT_FOUND: Int = 404
    
    /**
     * 系统运行异常
     */
    public static let ERROR_SYSTEM_RUN_ERR: Int = 500
    
    /**
     * 脚本运行失败
     */
    public static let ERROR_SCRIPT_RUN_ERR: Int = 501
    
    /**
     * 参数错误
     */
    public static let ERROR_ARGS_ERR: Int = 1001
    
    /**
     * 结果为空
     */
    public static let ERROR_RESULT_EMPTY: Int = 1002
    
    /**
     * 结果错误
     */
    public static let ERROR_RESULT_ERR: Int = 1003
    
    /**
     * Json解析异常
     */
    public static let ERROR_RESULT_JSON_SYNTAX_ERR: Int = 1004
    
    /**
     * 未知错误
     */
    public static let ERROR_UNKNOWN: Int = 2008
    
}
