//
//  CSModelListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//
//

import UIKit

private class DataManager: BaseDataManager<DefaultTableItem> {
    init() {
        super.init(initialItems: [
            DefaultTableItem(title: "Array", viewController: CSArrayPage()),
            DefaultTableItem(title: "CSV", viewController: CSVPage()),
            DefaultTableItem(title: "Data Operate", viewController: CSDataOperate()),
            DefaultTableItem(title: "Data Save List", viewController: CSDataSaveListVC()),
            DefaultTableItem(title: "设备信息", viewController: CSDeviceInfoPage()),
            DefaultTableItem(title: "Dictionary", viewController: CSDictionaryPage()),
            DefaultTableItem(title: "Double", viewController: DoublePage()),
            DefaultTableItem(title: "Enum", viewController: CSEnumPage()),
            DefaultTableItem(title: "Int", viewController: CSIntPage()),
            DefaultTableItem(title: "Item Model (Basic)", viewController: CSItemSearchPage()),
            DefaultTableItem(title: "Localization", viewController: LocalizationPage()),
            DefaultTableItem(title: "plist", viewController: CSPlistPage()),
            DefaultTableItem(title: "Private", viewController: PrivatePage()),
            DefaultTableItem(title: "Progress Model (Joined)", viewController: CSProgressSearchPage()),
            DefaultTableItem(title: "Read File", viewController: CSReadFilePage()),
            DefaultTableItem(title: "Request", viewController: CSRequestPage()),
            DefaultTableItem(title: "String", viewController: CSStringPage()),
            DefaultTableItem(title: "SwiftyJSON", viewController: CSSwiftyJSONPage()),
            DefaultTableItem(title: "Time", viewController: CSTimePage()),
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
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: tableData[indexPath.row].title
        )
        return cell
    }
}

