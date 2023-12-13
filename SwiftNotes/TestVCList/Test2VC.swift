//
//  Test2VC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/11.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: BaseDataManager<DefaultTableViewItem> {
    init() {
        super.init(initialItems: [
            DefaultTableViewItem(title: "Animation", viewController: CSGeneralSubpage()),
            DefaultTableViewItem(title: "Button", viewController: CSGeneralSubpage()),
        ])
    }
}


class ViewController2: UIViewController {
    
    private let dataSource = DataManager()
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        
        dataSource.onItemsUpdated = {  [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - @objc func
    
}


// MARK: - 代理方法：UITableViewDelegate
extension ViewController2: UITableViewDelegate {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: dataSource[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - 代理方法：UITableViewDataSource
extension ViewController2: UITableViewDataSource {
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        cell.configure(title: dataSource[indexPath.row].title)
        return cell
    }
}

