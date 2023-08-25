//
//  CollectionViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/12/9.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CollectionViewPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list: [(String, UIViewController)] = [
        ("Equal Division", CollectionViewEqualDivisionPage()),
        ("Auto Layout", CollectionViewAutoLayoutPage())
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: String(describing: DefaultTableViewCell.self))
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
        cell.titleLabel.setText(text: list[indexPath.row].0)
        
        return cell
    }
    
    // MARK: - @objc
    
}



//import UIKit
//
//class CollectionViewPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    let list: [(String, UIViewController)] = [
//        ("Equal Division", CollectionViewEqualDivisionPage()),
//        ("Auto Layout", CollectionViewAutoLayoutPage())
//    ]
//
//    let tableView = UITableView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.setBackgroundColor(color: cEEEFF1)
//
//        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
//        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
//
//    }
//
//
//    // MARK: - tableview 代理
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return kCellHeight
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.push(toTarget: list[indexPath.row].1)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
//        cell.setSeparator(left: 20, right: 0)
//
//        let cellTitle = UILabel()
//        cellTitle.set(superview: cell, text: list[indexPath.row].0)
//        cellTitle.setStyle17pt222Med()
//        cellTitle.setFrame(left: 16, centerY: cell.centerY)
//
//        let next = UIImageView()
//        next.set(superview: cell, imageName: "next")
//        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
//
//        return cell
//    }
//
//    // MARK: - @objc
//
//}
//
//
//
