//
//  BookDetailViewController.swift
//  Trotri
//
//  Created by songhuan on 2017/8/3.
//  Copyright © 2017年 songhuan. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    public static let SEGUE_IDENTIFIER: String = "segue_book_detail"
    
    var mBookId: UInt64 = 0
    
    @IBOutlet weak var mLbTitle: UILabel!
    
    @IBOutlet weak var mLbDtCreated: UILabel!
    
    @IBOutlet weak var mTvDescription: UITextView!
    
    private let mService: BookService = BookService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /**
         * BookDelegate Delegate
         * Book回执线程的处理协议
         */
        class BookDelegateImpl: BookDelegate {
            
            let mVCtrlBookDetail: BookDetailViewController
            
            init(vCtrlBookDetail: BookDetailViewController) {
                mVCtrlBookDetail = vCtrlBookDetail
            }
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo = HttpErrNo.SUCCESS_NUM
             *
             * @param data Book实体类
             */
            func onSuccess(data: BookEntity) {
                mVCtrlBookDetail.mLbTitle.text = data.getTitle()
                mVCtrlBookDetail.mLbDtCreated.text = data.getDtCreated()
                mVCtrlBookDetail.mTvDescription.text = data.getDescription()
            }
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo = HttpErrNo.SUCCESS_NUM
             *
             * @param dataList Book列表数据结构
             */
            func onSuccess(dataList: BookEntity.BookList) {}
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo != HttpErrNo.SUCCESS_NUM
             *
             * @param errNo 错误码
             * @param errMsg 错误消息
             */
            func onFailure(errNo: Int, errMsg: String) {
                Toast.makeText(viewController: mVCtrlBookDetail, text: errMsg, duration: Toast.LENGTH_LONG).show()
            }
            
            /**
             * Http请求失败后回调方法，HTTP状态码 != SC_OK ( 200 )
             *
             * @param statusCode HTTP状态码
             * @param message HTTP消息
             */
            func onHttpFailure(statusCode: Int, message: String) {
                Toast.makeText(viewController: mVCtrlBookDetail, text: message, duration: Toast.LENGTH_LONG).show()
            }
            
            /**
             * 打开URL链接失败后回调方法
             *
             * @param err a DataError 失败原因
             */
            func onError(err: DataError) {
                Toast.makeText(viewController: mVCtrlBookDetail, text: err.description, duration: Toast.LENGTH_LONG).show()
            }
        }
        
        mService.getRow(id: mBookId, delegate: BookDelegateImpl(vCtrlBookDetail: self))
    }
    
}
