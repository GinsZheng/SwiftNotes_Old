//
//  CSModelListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSModelListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list: [(String, UIViewController)] = [
        ("Array", CSArrayPage()),
        ("CSV", CSVPage()),
        ("Data Operate", CSDataOperate()),
        ("Data Save List", CSDataSaveListVC()),
        ("设备信息", CSDeviceInfoPage()),
        ("Dictionary", CSDictionaryPage()),
        ("Double", DoublePage()),
        ("Enum", CSEnumPage()),
        ("Int", CSIntPage()),
        ("Item Model (Basic)", CSItemSearchPage()),
        ("plist", CSPlistPage()),
        ("Progress Model (Joined)", CSProgressSearchPage()),
        ("Read File", CSReadFilePage()),
        ("Request", CSRequestPage()),
        ("String", CSStringPage()),
        ("SwiftyJSON", CSSwiftyJSONPage()),
        ("Time", CSTimePage()),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Model"
        
        let tableView = UITableView()
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndBottomBarHeight)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(left: 20, right: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: list[indexPath.row].0)
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: list[indexPath.row].1)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
