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
 * TypeCast class file
 * 类型转换类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: TypeCast.swift 1 2017-07-27 16:05:06Z huan.song $
 * @since 1.0
 */
class TypeCast {
    /**
     * Convert Any to String
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toStr(value: Any?, defaultValue: String) -> String {
        if value != nil && value is String {
            return (value as! String)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Dictionary<String, Any> to String
     *
     * @param value        a Dictionary<String, Any>
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toStr(dict: Dictionary<String, Any>, defaultValue: String) -> String {
        if (JSONSerialization.isValidJSONObject(dict)) {
            let data: Data! = try? JSONSerialization.data(withJSONObject: dict, options: []) as Data
            let result = String(data: data!, encoding: String.Encoding.utf8)
            return (result == nil) ? defaultValue : result!
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Dictionary<String, Any>
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toDictionary(value: Any?, defaultValue: Dictionary<String, Any>) -> Dictionary<String, Any> {
        if value != nil && value is Dictionary<String, Any> {
            return value as! Dictionary<String, Any>
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Array<Dictionary<String, Any>>
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toArrayDictionary(value: Any?, defaultValue: Array<Dictionary<String, Any>>) -> Array<Dictionary<String, Any>> {
        if value != nil && value is Array<Dictionary<String, Any>> {
            return value as! Array<Dictionary<String, Any>>
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Int
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toInt(value: Any?, defaultValue: Int) -> Int {
        if value != nil && value is Int {
            return (value as! Int)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Int64
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toInt64(value: Any?, defaultValue: Int64) -> Int64 {
        if value != nil && value is Int64 {
            return (value as! Int64)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Int32
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toInt32(value: Any?, defaultValue: Int32) -> Int32 {
        if value != nil && value is Int32 {
            return (value as! Int32)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Int16
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toInt16(value: Any?, defaultValue: Int16) -> Int16 {
        if value != nil && value is Int16 {
            return (value as! Int16)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Int8
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toInt8(value: Any?, defaultValue: Int8) -> Int8 {
        if value != nil && value is Int8 {
            return (value as! Int8)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to UInt
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toUInt(value: Any?, defaultValue: UInt) -> UInt {
        if value != nil && value is UInt {
            return (value as! UInt)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to UInt64
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toUInt64(value: Any?, defaultValue: UInt64) -> UInt64 {
        if value != nil && value is UInt64 {
            return (value as! UInt64)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to UInt32
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toUInt32(value: Any?, defaultValue: UInt32) -> UInt32 {
        if value != nil && value is UInt32 {
            return (value as! UInt32)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to UInt16
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toUInt16(value: Any?, defaultValue: UInt16) -> UInt16 {
        if value != nil && value is UInt16 {
            return (value as! UInt16)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to UInt8
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toUInt8(value: Any?, defaultValue: UInt8) -> UInt8 {
        if value != nil && value is UInt8 {
            return (value as! UInt8)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Double
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toDouble(value: Any?, defaultValue: Double) -> Double {
        if value != nil && value is Double {
            return (value as! Double)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Float
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toFloat(value: Any?, defaultValue: Float) -> Float {
        if value != nil && value is Float {
            return (value as! Float)
        }
        
        return defaultValue
    }
    
    /**
     * Convert Any to Bool
     * false: 0、0.0、"0"、"0.0"、""、"false(忽略大小写)"、false
     *
     * @param value        Any
     * @param defaultValue Value to return if value is nil or convert failure.
     * @return Returns the converted value if it exists, or defaultValue.
     */
    public static func toBool(value: Any?, defaultValue: Bool) -> Bool {
        if value == nil {
            return defaultValue
        }
        
        if value is Bool {
            return value as! Bool
        }
        
        let v: String = String(describing: value!)
        if v.isEmpty {
            return false
        }
        
        if "0".compare(v).rawValue == 0 {
            return false
        }
        
        if "0.0".compare(v).rawValue == 0 {
            return false
        }
        
        if "false".caseInsensitiveCompare(v).rawValue == 0 {
            return false
        }
        
        return true
    }
    
}
