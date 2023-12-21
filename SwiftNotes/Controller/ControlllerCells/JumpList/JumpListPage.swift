//
//  JumpPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/1.
//  Copyright © 2020 GinsMac. All rights reserved.
//
//

import UIKit

class CSJumpListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableData: [DefaultTableViewItem] = [
        DefaultTableViewItem(title: "Disabled Dismiss", viewController: CSDisabledDismissParentPage()),
        DefaultTableViewItem(title: "Dismiss", viewController: CSDismissPage1()),
        DefaultTableViewItem(title: "Dismiss all Page", viewController: CSDismissAllPage1()),
        DefaultTableViewItem(title: "Pop to specific page", viewController: CSPopToSpecificPage()),
        DefaultTableViewItem(title: "Pop and dismiss Page", viewController: CSPopAndDismissPage1()),
        DefaultTableViewItem(title: "Present", viewController: CSPresentPage())
    ]
        
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
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
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title:  tableData[indexPath.row].title)
        
        return cell
    }
    
    
    // MARK: - @objc func
    
}

