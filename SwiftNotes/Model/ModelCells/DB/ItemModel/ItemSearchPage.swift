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
    private let tableData = DefaultCellDataManager() // 用于tableView的数据，与下面items不同
    private let itemTable = ItemTable()
    private var itemModels: [Models.Item] = [] // 用于保存查出的各字段的数据
    
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


// MARK: - 私有方法 UI Setup
extension ItemSearchPage {
    private func updateData() {
        itemModels = itemTable.getAll()
        tableData.items = itemModels.map { .titleDescNext(title: $0.itemName, description: "简述：\($0.resume)，进度：\($0.totalProgress), 颜色：\($0.color)") }
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupNavButton()
        setupDefaultTableView(tableView)
    }
    
    private func setupNavButton() {
        let navButton = CSNavBarButton(imageName: "adding", viewController: self)
        navButton.onTap = { [weak self] in
            guard let self = self else { return }
            let insertPage = ItemInsertPage()
            insertPage.onCompleted = { self.updateData() }
            self.present(targetVC: insertPage)
        }
    }
    
}
