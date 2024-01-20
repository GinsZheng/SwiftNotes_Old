//
//  DBLiastPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/20.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .titleNextVC(title: "DB", viewController: DBPage()),
            .titleNextVC(title: "Item Model (Basic)", viewController: CSItemSearchPage()),
            .titleNextVC(title: "Progress Model (Joined)", viewController: CSProgressSearchPage()),
        ])
    }
}


// MARK: - 视图控制器
class DBListPage: UIViewController {
    private let tableData = DataManager()
    
    private let tableView = UITableView()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - tableView 代理方法
extension DBListPage: UITableViewDelegate, UITableViewDataSource {
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


// MARK: - 私有方法
extension DBListPage {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupDefaultTableView(tableView)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

