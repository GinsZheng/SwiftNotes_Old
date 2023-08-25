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

    let list: [(String, UIViewController)] = [
        ("Animation", CSGeneralSubpage()),
        ("Button", CSGeneralSubpage()),
    ]

    let table = CSItemTable()

    var idArray = [Int]()
    var nameArray = [String]()

    let tableView = UITableView()
    let deleteAllButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()


        let editButton = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(presentToInsertPage))
        editButton.tintColor = .hex(cRed_FF635A)
        self.navigationItem.rightBarButtonItem = editButton
        
        // 从本地数据库获取JSON数据、建模、赋值
        let json = table.getJSON()
        let model = CSItemModel.init(jsonData: json)
        idArray = model.id
        nameArray = model.itemName
    
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: "DefaultTableViewCell")
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        
        deleteAllButton.set(superview: view, target: self, action: #selector(deleteAll))
        deleteAllButton.setStyleIconButton(imageName: "delete")
        deleteAllButton.setShadow(y: 2, radius: 16)
        deleteAllButton.setFrame(right: 20, bottom: 20 + kNavBarHeight + kBottomBarHeight, width: 44, height: 44)
    }


    // MARK: - tableview 代理

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(toTarget: CSItemUpdatePage())
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath) as! DefaultTableViewCell
        cell.titleLabel.setText(text: nameArray[indexPath.row])

        return cell
    }

    // MARK: - @objc
    
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
        nameArray = model.itemName
        
        print("reloadData")
        // 关键：reloadData()，刷新页面数据
        tableView.reloadData()
    }

}

