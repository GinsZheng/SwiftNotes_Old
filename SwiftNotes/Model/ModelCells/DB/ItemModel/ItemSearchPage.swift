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

private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .titleNextVC(title: "Animation", viewController: CSGeneralSubpage()),
            .titleNextVC(title: "Button", viewController: CSGeneralSubpage())
        ])
    }
}


// MARK: - 视图控制器
class CSItemSearchPage: UIViewController {
    private let tableData = DataManager()
    
    let table = ItemTable()
    
    private var ids = [Int]()
    private var names = [String]()
    
    private let tableView = UITableView()
    private let deleteAllButton = UIButton(type: .custom)
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData()
        setupUI()
    }
    
}


// MARK: - tableView 代理方法
extension CSItemSearchPage: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableData[indexPath.row].pushViewControllerOnTap(from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableData[indexPath.row].getCellHeight()
    }

    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(row: indexPath.row, cellCountInSection: tableData.count)
        tableData[indexPath.row].configureCell(cell)
        return cell
    }
    
}


extension CSItemSearchPage: CSReloadDelegate {
    // MARK: - CSReloadDelegate 代理方法
    // 委托的事
    func reloadData() {
        // 如果不需要把已加载的清除，则不用把itemName清空，直接再遍历
        let json = table.getJSON()
        let model = CSItemModel.init(jsonData: json)
        ids = model.id
        names = model.itemName
        
        // 关键：reloadData()，刷新页面数据
        tableView.reloadData()
    }
    
}


// MARK: - 私有方法
extension CSItemSearchPage {
    private func initializeData() {
        // 从本地数据库获取JSON数据、建模、赋值
        let json = table.getJSON()
        let model = CSItemModel.init(jsonData: json)
        ids = model.id
        names = model.itemName
    }
    
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        let editButton = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(presentToInsertPage))
        editButton.tintColor = .hex(cRed_FF635A)
        self.navigationItem.rightBarButtonItem = editButton
        
        setupDefaultTableView(tableView)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        deleteAllButton.setup(superview: view)
        deleteAllButton.setStyleIconButton(imageName: "delete")
        deleteAllButton.setShadow(y: 2, radius: 16)
        deleteAllButton.setFrame(right: 20, bottom: 20 + kNavBarHeight + kHomeBarHeight, width: 44, height: 44)
        deleteAllButton.setEvent {
            self.table.delete()
            self.ids = []
            self.names = []
            self.tableView.reloadData()
        }
    }
    
}


// MARK: - @objc方法
extension CSItemSearchPage {
    // 建立委托
    @objc func presentToInsertPage() {
        let insertPage = CSItemInsertPage()
        insertPage.delegate = self
        self.present(targetVC: insertPage)
    }
}
