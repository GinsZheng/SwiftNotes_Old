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


// MARK: - 视图控制器
class ItemSearchPage: UIViewController {
    private let tableData = DefaultCellDataManager()
    private let table = ItemTable()
    
    private let tableView = UITableView()
    private let deleteButton = UIButton(type: .custom)
    
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
        self.present(targetVC: CSItemInsertPage())
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


// MARK: - 私有方法
extension ItemSearchPage {
    private func updateData() {
        let items = table.getAll()
        tableData.items = items.map { .titleNext(title: $0.itemName) }
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupNavButton()
        setupDefaultTableView(tableView)
        setupDeleteButton()
    }
    
    private func setupNavButton() {
        let navButton = CSNavBarButton(imageName: "adding", viewController: self)
        navButton.onTap = { [weak self] in
            guard let self = self else { return }
            let insertPage = CSItemInsertPage()
            insertPage.onInserted = { self.updateData() }
            self.present(targetVC: insertPage)
        }
    }
    
    private func setupDeleteButton() {
        deleteButton.setup(superview: view)
        deleteButton.setStyleIconButton(imageName: "delete")
        deleteButton.setShadow(y: 2, radius: 16)
        deleteButton.setFrame(right: 20, bottom: 20 + kHomeBarHeight, width: 44, height: 44)
        deleteButton.setEvent {
            DB.shared.delete(table: self.table, id: DB.shared.getLastId(tableName: self.table.tableName))
            self.updateData()
        }
    }
    
}
