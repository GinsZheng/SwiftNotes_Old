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

class CSBasicModelPage: UIViewController, UITableViewDelegate, UITableViewDataSource, CSReloadDelegate {
    
    let itemTable = CSBasicTable()
    
    var idArray = [Int]()
    var nameArray = [String]()
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(presentToInsertPage))
        
        // 从本地数据库获取JSON数据、建模、赋值
        let result = itemTable.getJSON()
        let model = CSBasicModel.init(jsonData: result)
        idArray = model.id
        nameArray = model.name
        
        tableView.set(superview: view, delegate: self, dataSource: self)
        tableView.setFrame(left: 0, top: 0, right: 0, bottom: 0)
        tableView.reloadData()
        
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
        let updatePage = CSUpdatePage()
        updatePage.delegate = self
        updatePage.updatedId = idArray[indexPath.row]
        self.present(toTarget: updatePage)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 建立委托
    @objc func presentToInsertPage() {
        let insertPage = CSInsertPage()
        insertPage.delegate = self
        self.present(toTarget: insertPage)
    }
    
    // 委托的事
    func reloadItemsList() {
        // 如果不需要把已加载的清除，则不用把itemName清空，直接再遍历
        idArray = []
        nameArray = []
        
        for name in itemTable.search() {
            idArray.append(name[itemTable.id])
            nameArray.append(name[itemTable.name])
        }
        print("reloadData")
        // 关键：reloadData()，刷新页面数据
        tableView.reloadData()
    }
}



// 建模
struct CSBasicModel {
    var id: [Int]
    var name: [String]
    var resume: [String]
    var totalProgress: [Int]
    var color: [Int]
    
    init(jsonData: JSON) {
        id = jsonData.arrayValue.map {$0["id"].intValue}
        name = jsonData.arrayValue.map {$0["name"].stringValue}
        resume = jsonData.arrayValue.map {$0["resume"].stringValue}
        totalProgress = jsonData.arrayValue.map {$0["totalProgress"].intValue}
        color = jsonData.arrayValue.map {$0["color"].intValue}
    }
}
