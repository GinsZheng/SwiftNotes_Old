//
//  JsonDataTableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/23.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit
import Alamofire

class JsonDataTableViewPage: UIViewController {
    
    private let tableData = DefaultCellDataManager() // 1. 初始化默认Cell的DataManager
    
    let tableView = UITableView()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchTableData()
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
    
    func fetchTableData() {
        let url = "https://gotest.ginkgeek.com/returnJson"
//        AF.request(url).responseDecodable(of: DefaultTableResponse.self) { response in
        AF.request(url).responseDecodable(of: ApiResponse<[Models.DefaultCell]>.self) { response in
            if let value = response.value {
                self.tableData.updateItems(with: value.data)  // 2. 调用 updateItems 函数为 tableData 更新值
            } else {
                print(response.error!)
            }
        }
    }
    
    // MARK: - @objc func
    
}


// MARK: - TableView 代理方法
extension JsonDataTableViewPage: UITableViewDelegate, UITableViewDataSource {
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

