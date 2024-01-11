//
//  TestVCListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/24.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .titleNextVC(title: "Test1", viewController: Test1VC()),
            .titleNextVC(title: "Table View", viewController: TableViewPage()),
            .titleNextVC(title: "Sections Table View", viewController: SectionsTableViewPage()),
            .titleNextVC(title: "FoldableTableViewPage", viewController: FoldableTableViewPage()),
        ])
    }
}


class TestVCListPage: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
   
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupDefaultTableView(tableView)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - @objc func
    
}


// MARK: - TableView 代理方法
extension TestVCListPage: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableData[indexPath.row]
        item.pushViewControllerOnTap(from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(row: indexPath.row, cellCountInSection: tableData.count)
        let item = tableData[indexPath.row]
        item.configureCell(cell)
        return cell
    }
}

