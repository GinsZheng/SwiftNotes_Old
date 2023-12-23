//
//  CSModelListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//
//

import UIKit

private class DataManager: BaseDataManager<DefaultCellItem> {
    init() {
        super.init(initialItems: [
            DefaultCellItem(title: "Array", viewController: CSArrayPage()),
            DefaultCellItem(title: "CSV", viewController: CSVPage()),
            DefaultCellItem(title: "Data Operate", viewController: CSDataOperate()),
            DefaultCellItem(title: "Data Save List", viewController: CSDataSaveListVC()),
            DefaultCellItem(title: "设备信息", viewController: CSDeviceInfoPage()),
            DefaultCellItem(title: "Dictionary", viewController: CSDictionaryPage()),
            DefaultCellItem(title: "Double", viewController: DoublePage()),
            DefaultCellItem(title: "Enum", viewController: CSEnumPage()),
            DefaultCellItem(title: "Int", viewController: CSIntPage()),
            DefaultCellItem(title: "Item Model (Basic)", viewController: CSItemSearchPage()),
            DefaultCellItem(title: "Localization", viewController: LocalizationPage()),
            DefaultCellItem(title: "plist", viewController: CSPlistPage()),
            DefaultCellItem(title: "Private", viewController: PrivatePage()),
            DefaultCellItem(title: "Progress Model (Joined)", viewController: CSProgressSearchPage()),
            DefaultCellItem(title: "Read File", viewController: CSReadFilePage()),
            DefaultCellItem(title: "Request", viewController: CSRequestPage()),
            DefaultCellItem(title: "String", viewController: CSStringPage()),
            DefaultCellItem(title: "SwiftyJSON", viewController: CSSwiftyJSONPage()),
            DefaultCellItem(title: "Time", viewController: CSTimePage()),
        ])
    }
}


class CSModelListVC: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
        tableView.register(DefaultCell.self, forCellReuseIdentifier: DefaultCell.identifier)
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kVertMargin, right: 0)
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
        self.push(toTarget: tableData[indexPath.row].viewController)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(row: indexPath.row, dataCount: tableData.count)
        cell.configure(cellType: .titleRightIcon, title: tableData[indexPath.row].title)
        return cell
    }
}

