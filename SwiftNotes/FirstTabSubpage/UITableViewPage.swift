//
//  UITableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class UITableViewPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let controlList = ["Label", "Button", "Text Field", "Switch", "Table View"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controlList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        let cellTitle = createUILabel(parentView: cell.contentView, text: controlList[indexPath.row])
        cellTitle.makeConstraintsToLeftCenterY(left: 20, centerY: cell.contentView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: UIButtonPage())
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let table = UITableView()
        view.addSubview(table)
        table.makeConstraintsToLeftTopRight(left: 0, top: navBarHeight, right: 0, height: 500)
        table.dataSource = self
        table.delegate = self
        table.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        table.separatorColor = UIColor.hex("1A000820")
        
        
        
        
        
        
        
        
    }
    
    
}

