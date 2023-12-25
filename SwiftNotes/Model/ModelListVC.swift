//
//  CSModelListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//
//

import UIKit

private class DataManager: BaseDataManager<TempDefaultCellItem> {
    init() {
        super.init(initialItems: [
            TempDefaultCellItem(title: "Array", viewController: CSArrayPage()),
            TempDefaultCellItem(title: "CSV", viewController: CSVPage()),
            TempDefaultCellItem(title: "Data Operate", viewController: CSDataOperate()),
            TempDefaultCellItem(title: "Data Save List", viewController: CSDataSaveListVC()),
            TempDefaultCellItem(title: "设备信息", viewController: CSDeviceInfoPage()),
            TempDefaultCellItem(title: "Dictionary", viewController: CSDictionaryPage()),
            TempDefaultCellItem(title: "Double", viewController: DoublePage()),
            TempDefaultCellItem(title: "Enum", viewController: CSEnumPage()),
            TempDefaultCellItem(title: "Int", viewController: CSIntPage()),
            TempDefaultCellItem(title: "Item Model (Basic)", viewController: CSItemSearchPage()),
            TempDefaultCellItem(title: "Localization", viewController: LocalizationPage()),
            TempDefaultCellItem(title: "plist", viewController: CSPlistPage()),
            TempDefaultCellItem(title: "Private", viewController: PrivatePage()),
            TempDefaultCellItem(title: "Progress Model (Joined)", viewController: CSProgressSearchPage()),
            TempDefaultCellItem(title: "Read File", viewController: CSReadFilePage()),
            TempDefaultCellItem(title: "Request", viewController: CSRequestPage()),
            TempDefaultCellItem(title: "String", viewController: CSStringPage()),
            TempDefaultCellItem(title: "SwiftyJSON", viewController: CSSwiftyJSONPage()),
            TempDefaultCellItem(title: "Time", viewController: CSTimePage()),
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

