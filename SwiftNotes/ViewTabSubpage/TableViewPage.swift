//
//  TableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TableViewPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let controlList = ["Label", "Button", "Text Field", "Switch", "Table View"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controlList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.makeConstraints(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: controlList[indexPath.row])
        cellTitle.makeConstraints(left: 20, centerY: cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: GeneralSubpage())
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let table = UITableView()
        table.set(superview: view)
        table.makeConstraints(left: 0, top: kNavBarHeight, right: 0, height: kCellHeight * CGFloat(controlList.count))
        table.contentSize = CGSize(width: kScreenWidth, height: kCellHeight * CGFloat(controlList.count))
        table.dataSource = self
        table.delegate = self
        table.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        table.separatorColor = UIColor.hex("1A000820")
        
    }
    
    
}

