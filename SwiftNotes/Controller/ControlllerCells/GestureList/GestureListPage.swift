//
//  GestureListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSGestureListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list: [(String, UIViewController)] = [
        ("Disable Pop", CSDisablePopGesturePage()),
        ("Long Press", CSLongPressGesturePage()),
        ("Pan", CSPanGesturePage()),
        ("Pinch", CSPinchGesturePage()),
        ("Swipe", CSSwipeGesturePage()),
        ("Tap", CSTapGesturePage()),
        ("TouchesBegan", CSTouchesBeganGesturePage()),
        ("TouchesMoved", CSTouchesMovedGesturePage()),
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: "DefaultTableViewCell")
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)

    }
    
    
    // MARK: - tableview 代理

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: list[indexPath.row].1)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath) as! DefaultTableViewCell
        cell.titleLabel.setText(text: list[indexPath.row].0)
        
        return cell
    }
    
    // MARK: - @objc
    
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
//        view.backgroundColor = UIColor.white
//
//        self.tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
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
//        cellTitle.set(superview: cell, text: titleList[indexPath.row])
//        cellTitle.setFrame(left: 20, centerY: cell.centerY)
//
//        let next = UIImageView()
//        next.set(superview: cell, imageName: "next")
//        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
//
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return titleList.count
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
