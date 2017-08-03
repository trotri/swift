//
//  BookListTableViewController.swift
//  Trotri
//
//  Created by songhuan on 2017/7/31.
//  Copyright © 2017年 songhuan. All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController {
    
    @IBOutlet weak var mTvBookList: UITableView!
    
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
            
            let mTvCtrlBookList: BookListTableViewController
            
            init(tvCtrlBookList: BookListTableViewController) {
                mTvCtrlBookList = tvCtrlBookList
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
                mTvCtrlBookList.mTvBookList.reloadData()
            }
            
            /**
             * Http请求成功后回调方法，HTTP状态码 = SC_OK ( 200 )，errNo != HttpErrNo.SUCCESS_NUM
             *
             * @param errNo 错误码
             * @param errMsg 错误消息
             */
            func onFailure(errNo: Int, errMsg: String) {
                Toast.makeText(viewController: mTvCtrlBookList, text: errMsg, duration: Toast.LENGTH_LONG).show()
            }
            
            /**
             * Http请求失败后回调方法，HTTP状态码 != SC_OK ( 200 )
             *
             * @param statusCode HTTP状态码
             * @param message HTTP消息
             */
            func onHttpFailure(statusCode: Int, message: String) {
                Toast.makeText(viewController: mTvCtrlBookList, text: message, duration: Toast.LENGTH_LONG).show()
            }
            
            /**
             * 打开URL链接失败后回调方法
             *
             * @param err a DataError 失败原因
             */
            func onError(err: DataError) {
                Toast.makeText(viewController: mTvCtrlBookList, text: err.description, duration: Toast.LENGTH_LONG).show()
            }
        }
        
        mService.findRows(offset: 0, limit: 8, delegate: BookDelegateImpl(tvCtrlBookList: self))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return mService.getSectionCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mService.getRowCount(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entity = mService.getRow(indexPath: indexPath)
        
        let tvCell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "tv_book_list_cell")
        tvCell.textLabel?.text = entity?.getTitle()
        tvCell.detailTextLabel?.text = entity?.getDtCreated()
        
        return tvCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity = mService.getRow(indexPath: indexPath)
        
        performSegue(withIdentifier: BookDetailViewController.SEGUE_IDENTIFIER, sender: entity?.getId())
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mService.getKey(section: section)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == BookDetailViewController.SEGUE_IDENTIFIER {
            let viewController: BookDetailViewController = segue.destination as! BookDetailViewController
            viewController.mBookId = sender as! UInt64
        }
    }
    
}
