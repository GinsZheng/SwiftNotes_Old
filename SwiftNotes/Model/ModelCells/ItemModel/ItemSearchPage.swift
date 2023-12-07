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
    
    let dataSource: [DefaultTableViewItem] = [
        DefaultTableViewItem(title: "Animation", viewController: CSGeneralSubpage()),
        DefaultTableViewItem(title: "Button", viewController: CSGeneralSubpage())
    ]
    
    let table = ItemTable()
    
    var idArray = [Int]()
    var nameArray = [String]()
    
    let tableView = UITableView()
    let deleteAllButton = UIButton(type: .custom)
    
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 从本地数据库获取JSON数据、建模、赋值
        let json = table.getJSON()
        let model = CSItemModel.init(jsonData: json)
        idArray = model.id
        nameArray = model.itemName
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        let editButton = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(presentToInsertPage))
        editButton.tintColor = .hex(cRed_FF635A)
        self.navigationItem.rightBarButtonItem = editButton
        
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: String(describing: DefaultTableViewCell.self))
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        
        deleteAllButton.set(superview: view, target: self, action: #selector(deleteAll))
        deleteAllButton.setStyleIconButton(imageName: "delete")
        deleteAllButton.setShadow(y: 2, radius: 16)
        deleteAllButton.setFrame(right: 20, bottom: 20 + kNavBarHeight + kBottomBarHeight, width: 44, height: 44)
    }
    
    
    // MARK: - tableview 代理方法
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
        cell.configure(title: nameArray[indexPath.row])
        
        return cell
    }
    
    
    // MARK: - CSReloadDelegate 代理方法
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
    
    
    // MARK: - @objc func
    
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
    

    
}

