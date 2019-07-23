//
//  ControllerTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

class ControllerTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let controllerList = ["Plist"]
    let controllerPage = [plistPage()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
//        scrollView.makeConstraintsToLeftTop(left: 0, top: kNavBarHeight, width: view, height: getSafeAreaHeight(self))
        
        let viewContainer = UIView()
        scrollView.addSubview(viewContainer)
//        viewContainer.makeConstraintsToLeftTop(left: 0, top: 0, width: scrollView, height: scrollView)
        
        let table = UITableView()
        viewContainer.addSubview(table)
//        table.makeConstraintsToLeftTop(left: 0, top: 0, width: kScreenWidth, height: 56*controllerList.count)
//        table.makeConstraintsToBottom(bottom: viewContainer)
        table.dataSource = self
        table.delegate = self
        table.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        table.separatorColor = UIColor.hex("1A000820")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllerList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        let cellTitle = UILabel()
        cellTitle.set(parentView: cell.contentView, text: controllerList[indexPath.row])
//        cellTitle.makeConstraintsToLeftCenterY(left: 20, centerY: cell.contentView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: controllerPage[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
