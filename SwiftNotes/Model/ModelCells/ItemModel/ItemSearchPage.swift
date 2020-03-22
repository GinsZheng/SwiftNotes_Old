//
//  SQLite.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON

class CSItemSearchPage: UIViewController, UITableViewDelegate, UITableViewDataSource, CSReloadDelegate {
    
    let table = CSItemsTable()
    
    var idArray = [Int]()
    var nameArray = [String]()
    
    let tableView = UITableView()
    let deleteAllButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(presentToInsertPage))
        
        // 从本地数据库获取JSON数据、建模、赋值
        let json = table.getJSON()
        let model = CSItemModel.init(jsonData: json)
        idArray = model.id
        nameArray = model.name
        
        tableView.set(superview: view, delegate: self, dataSource: self)
        tableView.setFrame(left: 0, top: 0, right: 0, bottom: 0)
        
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
        cellTitle.set(superview: cell, text: nameArray[indexPath.row])
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
        let updatePage = CSItemUpdatePage()
        updatePage.delegate = self
        updatePage.updatedId = idArray[indexPath.row]
        self.present(toTarget: updatePage)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func deleteAll() {
        table.delete()
        idArray = []
        nameArray = []
        tableView.reloadData()
    }
    
    // 建立委托
    @objc func presentToInsertPage() {
        let insertPage = CSItemInsertPage()
        insertPage.delegate = self
        self.present(toTarget: insertPage)
    }
    
    // 委托的事
    func reloadData() {
        // 如果不需要把已加载的清除，则不用把itemName清空，直接再遍历
        let json = table.getJSON()
        let model = CSItemModel.init(jsonData: json)
        idArray = model.id
        nameArray = model.name
        
        print("reloadData")
        // 关键：reloadData()，刷新页面数据
        tableView.reloadData()
    }
}
