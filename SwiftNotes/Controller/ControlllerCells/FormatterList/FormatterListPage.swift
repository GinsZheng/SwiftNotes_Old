//
//  FormatterListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/9/13.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class FormatterListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableData: [DefaultCellItem] = [
        DefaultCellItem(title: "Date Formatter", viewController: DateFormatterPage()),
        DefaultCellItem(title: "Number Formatter", viewController: NumberFormatterPage())
    ]
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        tableView.register(DefaultCell.self, forCellReuseIdentifier: String(describing: DefaultCell.self))
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
    }
    
    
    // MARK: - tableview 代理方法
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: tableData[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // cell
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


