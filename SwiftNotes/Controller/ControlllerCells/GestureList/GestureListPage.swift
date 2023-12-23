//
//  GestureListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSGestureListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableData: [DefaultCellItem] = [
        DefaultCellItem(title: "Disable Pop", viewController: CSDisablePopGesturePage()),
        DefaultCellItem(title: "Long Press", viewController: CSLongPressGesturePage()),
        DefaultCellItem(title: "Pan", viewController: CSPanGesturePage()),
        DefaultCellItem(title: "Pinch", viewController: CSPinchGesturePage()),
        DefaultCellItem(title: "Swipe", viewController: CSSwipeGesturePage()),
        DefaultCellItem(title: "Tap", viewController: CSTapGesturePage()),
        DefaultCellItem(title: "TouchesBegan", viewController: CSTouchesBeganGesturePage()),
        DefaultCellItem(title: "TouchesMoved", viewController: CSTouchesMovedGesturePage())
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
        cell.prepare(row: indexPath.row, dataCount: tableData.count)
        cell.configure(cellType: .titleRightIcon, title: tableData[indexPath.row].title)
        return cell
    }
    
    
    // MARK: - @objc func
    
}


//import UIKit
//
//class CSGestureListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    let titleList = ["Disable Pop", "Long Press", "Pan", "Pinch", "Swipe", "Tap", "TouchesBegan", "TouchesMoved"]
//    let pageList = [CSDisablePopGesturePage(), CSLongPressGesturePage(), CSPanGesturePage(), CSPinchGesturePage(), CSSwipeGesturePage(), CSTapGesturePage(), CSTouchesBeganGesturePage(), CSTouchesMovedGesturePage()]
//    var cardHeight: CGFloat = 0
//
//    let tableView = UITableView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.setBackgroundColor(color: cFFF)
//
//        self.tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
//        tableView.setFrame(left: 0, top: 0, right: 0, bottom: 0)
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
//        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
//        cell.setSeparator(left: 20, right: 0)
//
//        let cellTitle = UILabel()
//        cellTitle.setup(superview: cell, text: titleList[indexPath.row])
//        cellTitle.setFrame(left: 20, centerY: cell.centerY)
//
//        let next = UIImageView()
//        next.setup(superview: cell, imageName: kIconNext)
//        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
//
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return titledataSource.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 56
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.push(toTarget: pageList[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}
