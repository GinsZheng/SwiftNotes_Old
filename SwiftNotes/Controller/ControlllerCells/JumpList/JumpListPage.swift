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
    
    let tableData: [DefaultCellItem] = [
        DefaultCellItem(title: "Disabled Dismiss", viewController: CSDisabledDismissParentPage()),
        DefaultCellItem(title: "Dismiss", viewController: CSDismissPage1()),
        DefaultCellItem(title: "Dismiss all Page", viewController: CSDismissAllPage1()),
        DefaultCellItem(title: "Pop to specific page", viewController: CSPopToSpecificPage()),
        DefaultCellItem(title: "Pop and dismiss Page", viewController: CSPopAndDismissPage1()),
        DefaultCellItem(title: "Present", viewController: CSPresentPage())
    ]
        
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DefaultCell.self, forCellReuseIdentifier: String(describing: DefaultCell.self))
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultCell.self), for: indexPath) as! DefaultCell
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title:  tableData[indexPath.row].title)
        
        return cell
    }
    
    
    // MARK: - @objc func
    
}

