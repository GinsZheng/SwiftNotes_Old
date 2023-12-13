//
//  UIEffectsPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/9.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class UIListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataSource: [DefaultTableViewItem] = [
        DefaultTableViewItem(title: "Mask", viewController: CSMaskPage()),
        DefaultTableViewItem(title: "Font", viewController: CSFontPage())
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
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)

    }
    
    
    // MARK: - tableview 代理方法

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: dataSource[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
        cell.configure(title: dataSource[indexPath.row].title)
        
        return cell
    }
    
    
    // MARK: - @objc func
    
}

