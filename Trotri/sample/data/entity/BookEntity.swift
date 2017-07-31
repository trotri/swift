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
 * BookEntity class file
 * Book实体类
 *
 * @author 宋欢 <trotri@yeah.net>
 * @version $Id: BookEntity.swift 1 2017-07-31 10:00:06Z huan.song $
 * @since 1.0
 */
class BookEntity: CustomStringConvertible {
    /**
     * 默认值
     */
    public static let DEFAULT_ID: UInt64 = 0
    public static let DEFAULT_TITLE: String = ""
    public static let DEFAULT_TYPE: String = ""
    public static let DEFAULT_DESCRIPTION: String = ""
    public static let DEFAULT_PICTURE: String = ""
    public static let DEFAULT_IS_RECOMMEND: Bool = false
    public static let DEFAULT_DT_CREATED: String = "00-00 00:00"
    
    /**
     * Id
     */
    private var mId: UInt64 = BookEntity.DEFAULT_ID
    
    /**
     * 标题
     */
    private var mTitle: String = BookEntity.DEFAULT_TITLE
    
    /**
     * 分类
     */
    private var mType: String = BookEntity.DEFAULT_TYPE
    
    /**
     * 描述
     */
    private var mDescription: String = BookEntity.DEFAULT_DESCRIPTION
    
    /**
     * 图片
     */
    private var mPicture: String = BookEntity.DEFAULT_PICTURE
    
    /**
     * 是否推荐
     */
    private var mIsRecommend: Bool = BookEntity.DEFAULT_IS_RECOMMEND
    
    /**
     * 创建时间, 默认: "00-00 00:00"
     */
    private var mDtCreated: String = BookEntity.DEFAULT_DT_CREATED
    
    /**
     * toString
     */
    var description: String {
        return "[ id: \(getId()), title: \"\(getTitle())\", type: \"\(getType())\", description: \"\(getDescription())\", picture: \"\(getPicture())\", isRecommend: \(isRecommend()), dtCreated: \"\(getDtCreated())\" ]"
    }
    
    /**
     * 默认构造方法
     */
    public init() {
    }
    
    /**
     * 构造方法：初始化所有属性
     *
     * @param id Id
     * @param title 标题
     * @param type 分类
     * @param description 描述
     * @param picture 图片
     * @param isRecommend 是否推荐
     * @param dtCreated 创建时间
     */
    public convenience init(id: UInt64, title: String, type: String, description: String, picture: String, isRecommend: Bool, dtCreated: String) {
        self.init()
        
        setId(id: id)
        setTitle(title: title)
        setType(type: type)
        setDescription(description: description)
        setPicture(picture: picture)
        setRecommend(isRecommend: isRecommend)
        setDtCreated(dtCreated: dtCreated)
    }
    
    /**
     * 获取Id
     *
     * @return Id
     */
    public func getId() -> UInt64 {
        return mId
    }
    
    /**
     * 设置Id
     *
     * @param id Id
     */
    public func setId(id: UInt64) {
        mId = id
    }
    
    /**
     * 获取标题
     *
     * @return 标题
     */
    public func getTitle() -> String {
        return mTitle
    }
    
    /**
     * 设置标题
     *
     * @param title 标题
     */
    public func setTitle(title: String) {
        mTitle = title
    }
    
    /**
     * 获取分类
     *
     * @return 分类
     */
    public func getType() -> String {
        return mType
    }
    
    /**
     * 设置分类
     *
     * @param type 分类
     */
    public func setType(type: String) {
        mType = type
    }
    
    /**
     * 获取描述
     *
     * @return 描述
     */
    public func getDescription() -> String {
        return mDescription
    }
    
    /**
     * 设置描述
     *
     * @param description 描述
     */
    public func setDescription(description: String) {
        mDescription = description
    }
    
    /**
     * 获取图片
     *
     * @return 图片
     */
    public func getPicture() -> String {
        return mPicture
    }
    
    /**
     * 设置图片
     *
     * @param picture 图片
     */
    public func setPicture(picture: String) {
        mPicture = picture
    }
    
    /**
     * 获取是否推荐
     *
     * @return 是否推荐
     */
    public func isRecommend() -> Bool {
        return mIsRecommend
    }
    
    /**
     * 设置是否推荐
     *
     * @param isRecommend 是否推荐
     */
    public func setRecommend(isRecommend: Bool) {
        mIsRecommend = isRecommend
    }
    
    /**
     * 获取创建时间
     *
     * @return 创建时间
     */
    public func getDtCreated() -> String {
        return mDtCreated
    }
    
    /**
     * 设置创建时间
     *
     * @param dtCreated 创建时间
     */
    public func setDtCreated(dtCreated: String) {
        mDtCreated = dtCreated
    }
    
    /**
     * 通过字典新建实例
     *
     * @param dict 字典
     */
    public static func newObject(with dict: Dictionary<String, Any>) -> BookEntity? {
        let id: UInt64 = TypeCast.toUInt64(value: dict["id"], defaultValue: BookEntity.DEFAULT_ID)
        let title: String = TypeCast.toStr(value: dict["title"], defaultValue: BookEntity.DEFAULT_TITLE)
        let type: String = TypeCast.toStr(value: dict["type"], defaultValue: BookEntity.DEFAULT_TYPE)
        let description: String = TypeCast.toStr(value: dict["description"], defaultValue: BookEntity.DEFAULT_DESCRIPTION)
        let picture: String = TypeCast.toStr(value: dict["picture"], defaultValue: BookEntity.DEFAULT_PICTURE)
        let isRecommend: Bool = TypeCast.toBool(value: dict["isRecommend"], defaultValue: BookEntity.DEFAULT_IS_RECOMMEND)
        let dtCreated: String = TypeCast.toStr(value: dict["dtCreated"], defaultValue: BookEntity.DEFAULT_DT_CREATED)
        
        if id == BookEntity.DEFAULT_ID || title == BookEntity.DEFAULT_TITLE {
            return nil
        }
        
        return BookEntity(id: id, title: title, type: type, description: description, picture: picture, isRecommend: isRecommend, dtCreated: dtCreated)
    }
    
    /**
     * BookList class file
     * 列表数据结构
     *
     * @since 1.0
     */
    class BookList: DataList {
        /**
         * 构造方法：初始化所有属性
         *
         * @param total  总记录数
         * @param limit  查询记录数
         * @param offset 查询起始位置
         * @param rows   数据
         */
        public convenience init(total: UInt64, limit: Int, offset: Int, rows: Array<BookEntity>) {
            self.init()
            
            setTotal(total: total)
            setLimit(limit: limit)
            setOffset(offset: offset)
            setRows(rows: rows)
        }
        
        /**
         * 数据
         */
        private var mRows: Array<BookEntity> = []
        
        /**
         * 获取列表
         *
         * @return 列表
         */
        public func getRows() -> Array<BookEntity> {
            return mRows
        }
        
        /**
         * 设置列表
         *
         * @param rows 列表
         */
        public func setRows(rows: Array<BookEntity>) {
            mRows = rows
        }
        
        /**
         * 通过DataList新建实例
         *
         * @param dataList DataList
         */
        public static func newObject(with dataList: DataList) -> BookList {
            var data: Array<BookEntity> = []
            
            let rows: Array<Dictionary<String, Any>> = dataList.getRows()
            for row in rows {
                let value = BookEntity.newObject(with: row)
                if value == nil {
                    continue
                }
                
                data.append(value!)
            }
            
            return BookList(total: dataList.getTotal(), limit: dataList.getLimit(), offset: dataList.getOffset(), rows: data)
        }
        
    }
    
}
