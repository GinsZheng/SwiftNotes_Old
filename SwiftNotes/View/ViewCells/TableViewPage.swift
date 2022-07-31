//
//  CSTableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSTableViewPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let titleList = ["Label", "Button", "Text Field"]
    let pageList = [CSGeneralSubpage(), CSGeneralSubpage(), CSGeneralSubpage(), ]
    
    var cardHeight: CGFloat = 0
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        self.tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
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





/*
 TableViewCell内容超出Frame：
    TableViewCell内容超出Frame时，以投影超出为例，可以完整显示，不会被裁切，
    但在滑动列表后，会出现投影被裁切的情况，些时把背景颜色设置为透明即可解决
    (可能)扩展而言：只要不设置 maskToBounds 属性，所有的视图都可以超出控件边界
 */


/*
 TableViewCell中可交互控件失效处理方法：
 // 以UISwitch为例，把UISwitch控件添加到cell.contentView上而不是添加到cell上
 let cell = CellComponent()
 cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: 0)
 cell.setBackgroundColor(color: cNoColor)
 cell.selectionStyle = .none
 
 let switchView = UISwitch()
 switchView.set(superview: cell.contentView)
 switchView.setFrame(right: 20, centerY: cardBg.centerY, width: switchView.width, height: switchView.height)
 switchView.onTintColor = UIColor.hex(cBlue_5393FF)
 switchView.setOn(true, animated: false)
 */
