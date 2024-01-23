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

private class DataManager {
    private let table = ItemTable()
    
    // 获取所有数据
    func getAllItems() -> [Models.Item] {
        return table.getAll()
    }
    
}


// MARK: - 视图控制器
class ItemSearchPage: UIViewController {
    private let tableData = DefaultCellDataManager()
    private let itemData = DataManager()
    private var itemModels: [Models.Item] = []
    
    private let tableView = UITableView()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        setupUI()
    }
    
}


// MARK: - tableView 代理方法
extension ItemSearchPage: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetVC = ItemEditPage()
        targetVC.itemModel = itemModels[indexPath.row]
        targetVC.onCompleted = { self.updateData() }
        self.present(targetVC: targetVC)
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


// MARK: - 私有方法：控制
extension ItemSearchPage {
    private func updateData() {
        itemModels = itemData.getAllItems()
        tableData.items = itemModels.map { .titleDescNext(title: $0.itemName, description: "简述：\($0.resume)，进度：\($0.totalProgress), 颜色：\($0.color)") }
        tableView.reloadData()
    }
}


// MARK: - 私有方法：设置UI
extension ItemSearchPage {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupNavButton()
        setupDefaultTableView(tableView)
    }
    
    private func setupNavButton() {
        let navButton = CSNavBarButton(imageName: "adding", viewController: self)
        navButton.onTap = { [unowned self] in
            let insertPage = ItemInsertPage()
            insertPage.onCompleted = { self.updateData() }
            self.present(targetVC: insertPage)
        }
    }
    
}