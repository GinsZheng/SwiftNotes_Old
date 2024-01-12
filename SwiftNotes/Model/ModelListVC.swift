//
//  CSModelListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//
//

import UIKit

private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .titleNextVC(title: "Array", viewController: CSArrayPage()),
            .titleNextVC(title: "CSV", viewController: CSVPage()),
            .titleNextVC(title: "Data Operate", viewController: CSDataOperate()),
            .titleNextVC(title: "Data Save List", viewController: CSDataSaveListVC()),
            .titleNextVC(title: "设备信息", viewController: CSDeviceInfoPage()),
            .titleNextVC(title: "Dictionary", viewController: CSDictionaryPage()),
            .titleNextVC(title: "Double", viewController: DoublePage()),
            .titleNextVC(title: "Enum", viewController: CSEnumPage()),
            .titleNextVC(title: "Int", viewController: CSIntPage()),
            .titleNextVC(title: "Item Model (Basic)", viewController: CSItemSearchPage()),
            .titleNextVC(title: "Localization", viewController: LocalizationPage()),
            .titleNextVC(title: "plist", viewController: CSPlistPage()),
            .titleNextVC(title: "Private", viewController: PrivatePage()),
            .titleNextVC(title: "Progress Model (Joined)", viewController: CSProgressSearchPage()),
            .titleNextVC(title: "Read File", viewController: CSReadFilePage()),
            .titleNextVC(title: "Request", viewController: CSRequestPage()),
            .titleNextVC(title: "String", viewController: CSStringPage()),
            .titleNextVC(title: "SwiftyJSON", viewController: CSSwiftyJSONPage()),
            .titleNextVC(title: "Time", viewController: CSTimePage()),
        ])
    }
}


class CSModelListVC: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    // MARK: - 初始化与生命周期方法
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
extension CSModelListVC: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableData[indexPath.row]
        item.pushViewControllerOnTap(from: self)
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

