//
//  GestureListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .titleNextVC(title: "Disable Pop", viewController: CSDisablePopGesturePage()),
            .titleNextVC(title: "Long Press", viewController: CSLongPressGesturePage()),
            .titleNextVC(title: "Pan", viewController: CSPanGesturePage()),
            .titleNextVC(title: "Pinch", viewController: CSPinchGesturePage()),
            .titleNextVC(title: "Swipe", viewController: CSSwipeGesturePage()),
            .titleNextVC(title: "Tap", viewController: CSTapGesturePage()),
            .titleNextVC(title: "TouchesBegan", viewController: CSTouchesBeganGesturePage()),
            .titleNextVC(title: "TouchesMoved", viewController: CSTouchesMovedGesturePage())
        ])
    }
}


class CSGestureListPage: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupDefaultTableView(tableView)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - @objc func
    
}


// MARK: - TableView 代理方法
extension CSGestureListPage: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableData[indexPath.row]
        item.pushViewControllerOnTap(from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(row: indexPath.row, cellCountInSection: tableData.count)
        let item = tableData[indexPath.row]
        item.configureCell(cell)
        return cell
    }
}


//class CSGestureListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    private let tableData = DataManager()
//        
//    let tableView = UITableView()
//    
//    
//    // MARK: - 生命周期方法
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupUI()
//    }
//    
//    
//    // MARK: - func
//    func setupUI() {
//        tableView.register(DefaultCell.self, forCellReuseIdentifier: String(describing: DefaultCell.self))
//        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
//        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
//    }
//    
//    
//    // MARK: - tableview 代理方法
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableData.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return kCellHeight
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.push(targetVC: tableData[indexPath.row].viewController)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultCell.self), for: indexPath) as! DefaultCell
//        cell.prepare(row: indexPath.row, cellCountInSection: tableData.count)
//        cell.configure(cellType: .titleRightIcon, title: tableData[indexPath.row].title)
//        return cell
//    }
//    
//    
//    // MARK: - @objc func
//    
//}
