//
//  AlertListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/16.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSAlertListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let titleList = ["One Button", "Two Button"]
    let pageList = [CSAlertOneBtnPage(), CSAlertTwoBtnPage()]
    var cardHeight: CGFloat = 0
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.set(superview: view, delegate: self, dataSource: self)
        tableView.setFrame(left: 0, top: 0, right: 0, bottom: 0)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(leftInset: 20, rightInset: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: titleList[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "discovery_next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: pageList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}