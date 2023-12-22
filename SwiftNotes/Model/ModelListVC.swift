//
//  CSModelListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//
//

import UIKit

private class DataManager: BaseDataManager<DefaultTableViewItem> {
    init() {
        super.init(initialItems: [
            DefaultTableViewItem(title: "Array", viewController: CSArrayPage()),
            DefaultTableViewItem(title: "CSV", viewController: CSVPage()),
            DefaultTableViewItem(title: "Data Operate", viewController: CSDataOperate()),
            DefaultTableViewItem(title: "Data Save List", viewController: CSDataSaveListVC()),
            DefaultTableViewItem(title: "设备信息", viewController: CSDeviceInfoPage()),
            DefaultTableViewItem(title: "Dictionary", viewController: CSDictionaryPage()),
            DefaultTableViewItem(title: "Double", viewController: DoublePage()),
            DefaultTableViewItem(title: "Enum", viewController: CSEnumPage()),
            DefaultTableViewItem(title: "Int", viewController: CSIntPage()),
            DefaultTableViewItem(title: "Item Model (Basic)", viewController: CSItemSearchPage()),
            DefaultTableViewItem(title: "Localization", viewController: LocalizationPage()),
            DefaultTableViewItem(title: "plist", viewController: CSPlistPage()),
            DefaultTableViewItem(title: "Private", viewController: PrivatePage()),
            DefaultTableViewItem(title: "Progress Model (Joined)", viewController: CSProgressSearchPage()),
            DefaultTableViewItem(title: "Read File", viewController: CSReadFilePage()),
            DefaultTableViewItem(title: "Request", viewController: CSRequestPage()),
            DefaultTableViewItem(title: "String", viewController: CSStringPage()),
            DefaultTableViewItem(title: "SwiftyJSON", viewController: CSSwiftyJSONPage()),
            DefaultTableViewItem(title: "Time", viewController: CSTimePage()),
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
        
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: tableData[indexPath.row].title
        )
        return cell
    }
}

