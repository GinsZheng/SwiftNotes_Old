//
//  ControllerTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

class ControllerTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let controllerList = ["Plist", "Decorator", "Protocol"]
    let controllerPage = [plistPage(), DecoratorPage(), ProtocolPage()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.makeConstraints(left: 0, top: kNavBarHeight, width: kScreenWidth, height: kCellHeight*CGFloat(controllerList.count))
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kCellHeight*CGFloat(controllerList.count))
        
        let table = UITableView()
        table.set(superview: scrollView)
        table.makeConstraints(left: 0, top: 0, width: kScreenWidth, height: scrollView.height)
        table.dataSource = self
        table.delegate = self
        table.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        table.separatorColor = UIColor.hex("1A000820")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllerList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.makeConstraints(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: controllerList[indexPath.row])
        cellTitle.makeConstraints(left: 20, centerY: cell.centerY)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: controllerPage[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
