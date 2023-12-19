//
//  AlertListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/16.
//  Copyright © 2020 GinsMac. All rights reserved.
//
//let titleList = ["One Button", "Two Button"]
//let pageList = [CSAlertOneBtnPage(), CSAlertTwoBtnPage()]
import UIKit

class CSAlertListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableData: [DefaultTableViewItem] = [
        DefaultTableViewItem(title: "One Button", viewController: CSAlertOneBtnPage()),
        DefaultTableViewItem(title: "Two Button", viewController: CSAlertTwoBtnPage())
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: String(describing: DefaultTableViewCell.self))
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)

    }
    
    
    // MARK: - tableview 代理方法

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: tableData[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
        cell.configure(cellType: .titleRightArrow,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title:  tableData[indexPath.row].title)

        return cell
    }
    
    // MARK: - @objc func
    
}

