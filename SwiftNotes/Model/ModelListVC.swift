//
//  CSModelListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSModelListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataSource: [DefaultTableViewItem] = [
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
        DefaultTableViewItem(title: "Time", viewController: CSTimePage())
    ]
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Model"
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndBottomBarHeight)
    }
    
    
    // MARK: - tableView代理方法

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(left: 20, right: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: dataSource[indexPath.row].title)
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: dataSource[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
