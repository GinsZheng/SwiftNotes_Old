//
//  SQLiteJoinTablesPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON

class CSProgressSearchPage: UIViewController, UITableViewDelegate, UITableViewDataSource, CSReloadDelegate {
    
    let table = CSProgressTable()
    
    var idArray = [Int]()
    var currentProgressArray = [Int]()
    var itemIdArray = [Int]()
    
    let tableView = UITableView()
    let deleteAllButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(presentToInsertPage))
        
        // 从本地数据库获取JSON数据、建模、赋值
        let json = table.getJSON()
        let model = CSProgressModel.init(jsonData: json)
        idArray = model.id
        currentProgressArray = model.currentProgress
        itemIdArray = model.itemId
        
        self.tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, bottom: 0)
        tableView.reloadData()
        
        deleteAllButton.set(superview: view, target: self, action: #selector(deleteAll))
        deleteAllButton.setStyleSystemIconButton(imageName: "delete")
        deleteAllButton.setShadow(y: 2, radius: 16)
        deleteAllButton.setFrame(right: 20, bottom: 20 + kNavBarHeight + kBottomBarHeight, width: 44, height: 44)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(leftInset: 20, rightInset: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: "itemId: \(itemIdArray[indexPath.row])    currentProgress: \(currentProgressArray[indexPath.row])")
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "discovery_next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updatePage = CSProgressUpdatePage()
        updatePage.delegate = self
        updatePage.updatedId = idArray[indexPath.row]
        self.present(toTarget: updatePage)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func deleteAll() {
        table.delete()
        idArray = []
        currentProgressArray = []
        itemIdArray = []
        tableView.reloadData()
    }
    
    // 建立委托
    @objc func presentToInsertPage() {
        let insertPage = CSProgressInsertPage()
        insertPage.delegate = self
        self.present(toTarget: insertPage)
    }
    
    // 委托的事
    func reloadData() {
        // 如果不需要把已加载的清除，则不用把itemName清空，直接再遍历
        let json = table.getJSON()
        let model = CSProgressModel.init(jsonData: json)
        idArray = model.id
        currentProgressArray = model.currentProgress
        itemIdArray = model.itemId

        print("reloadData")
        // 关键：reloadData()，刷新页面数据
        tableView.reloadData()
    }
}

