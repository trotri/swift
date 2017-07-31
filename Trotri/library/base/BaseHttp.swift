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
 * BaseHttp abstract class file
 * Http基类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: BaseHttp.swift 1 2017-07-31 10:00:06Z huan.song $
 * @since 1.0
 */
class BaseHttp {
    /**
     * Urls.plist资源名
     */
    public static let RESOURCE_URLS_PLIST: String = "Urls"
    
    /**
     * Base Url键名
     */
    public static let KEY_BASE_URL: String = "base_url"
    
    /**
     * Base Url
     */
    private var mBaseUrl: String = ""
    
    /**
     * Obtain Base Url
     *
     * @return Base Url
     */
    public func getBaseUrl() -> String {
        if mBaseUrl.isEmpty {
            let data: NSDictionary = PListReader.getInstance(forResource: BaseHttp.RESOURCE_URLS_PLIST).getData()
            if data[BaseHttp.KEY_BASE_URL] != nil {
                let baseUrl: String = data[BaseHttp.KEY_BASE_URL] as! String
                mBaseUrl = baseUrl.trimmingCharacters(in: CharacterSet.whitespaces)
            }
        }
        
        return mBaseUrl
    }
    
}
