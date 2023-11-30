//
//  TransferDataListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/30.
//  Copyright © 2023 GinsMac. All rights reserved.
//

/*
 值传递的方式除了代理，还有其他方式。比如：闭包。本页用来呈现不同传值方式的使用示例，找出他们各自的使用场景
 1. 代理：直接以 DelegatePage.swift为例 (类名为：CSNameEditorPage)
 2. 闭包：直接以 Closure2VC为例
 
 */

import UIKit

class TransferDataListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list: [(String, UIViewController)] = [
        ("Delegate", CSDelegatePage()),
        ("Closure", Closure2VC()),
    ]
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: String(describing: DefaultTableViewCell.self))
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
    }
    
    
    // MARK: - tableview 代理方法
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: list[indexPath.row].1)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
        cell.titleLabel.setText(text: list[indexPath.row].0)
        
        return cell
    }
    
    
    // MARK: - @objc func
    
    
}


