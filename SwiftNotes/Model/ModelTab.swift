//
//  ModelTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ModelTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let controllerList = ["Array", "Basic Model", "HandyJSON", "Joined Model", "Request", "SwiftyJSON"]
    let controllerPage = [ArrayPage(), BasicModelPage(), HandyJSONPage(), JoinedModelPage(), RequestPage(), SwiftyJSONPage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Model"
        
        let table = UITableView()
        table.set(superview: view, delegate: self, dataSource: self)
        table.setFrame(left: 0, top: 0, right: 0, height: getSafeAreaHeight())
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllerList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(leftInset: 20, rightInset: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: controllerList[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "discovery_next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: controllerPage[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
