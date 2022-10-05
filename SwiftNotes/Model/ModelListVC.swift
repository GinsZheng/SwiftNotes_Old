//
//  CSModelListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSModelListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let titleArray = ["Array", "CSV", "Data Operate", "Data Save List", "设备信息" , "Dictionary", "Double", "Enum", "Int", "Item Model (Basic)", "plist", "Progress Model (Joined)", "Read File", "Request", "String", "SwiftyJSON", "Time"]
    let pageArray = [CSArrayPage(), CSVPage(), CSDataOperate(), CSDataSaveListVC(), CSDeviceInfoPage(), CSDictionaryPage(), DoublePage(), CSEnumPage(), CSIntPage(), CSItemSearchPage(), CSPlistPage(),  CSProgressSearchPage(), CSReadFilePage(), CSRequestPage(), CSStringPage(), CSSwiftyJSONPage(), CSTimePage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Model"
        
        let tableView = UITableView()
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndBottomBarHeight)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(leftInset: 20, rightInset: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: titleArray[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: pageArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
