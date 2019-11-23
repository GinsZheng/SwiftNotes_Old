//
//  ControllerTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

class ControllerTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let controllerList = ["Plist", "Decorator", "Protocol", "Number Formatter", "Menu Controller", "Delegate"]
    let controllerPage = [PlistPage(), DecoratorPage(), ProtocolPage(), NumberFormatterPage(), MenuControllerPage(), DelegatePage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let table = UITableView()
        table.set(superview: view)
        table.makeConstraints(left: 0, top: kNavBarHeight, right: 0, height: getSafeAreaHeight())
        table.contentSize = CGSize(width: kScreenWidth, height: kCellHeight * CGFloat(controllerList.count))
        table.dataSource = self
        table.delegate = self
        table.separatorColor = UIColor.hex(cNoColor)
        
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
        cell.addSeparator(leftInset: 20, rightInset: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: controllerList[indexPath.row])
        cellTitle.makeConstraints(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "discovery_next")
        next.makeConstraints(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: controllerPage[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
