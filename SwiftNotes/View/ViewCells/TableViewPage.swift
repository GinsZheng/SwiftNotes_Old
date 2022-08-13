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
        cell.selectionStyle = .none
        
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
 复杂情形示例：
    同时满足 A：需要在子页面(通过代理)更新父页面的列表 B：列表的高度根据文字多少计算而来
    思路：1. 为了满足B，高度需要创建一个数组如cellHeightArray，在func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) 函数中完成计算与添加值到数组cellHeightArray中。然后把cellHeightArray的值作为func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)中的返回的cell高度值
        2. 为了满足A，需要创建一个代理，代理中由于不知道cellHeightArray在更新后的值，所以要让cellHeightArray = Array(repeating: 0, count: dateArray.count)，先填个正确长度的值，然后让cellHeightArray在<cellForRowAt>中赋值，要写成cellHeightArray[indexPath.row] = cellHeight 而不是用append方法，来完成替换
        3. 详见蜗牛进度中的⌜进度列表⌟页面
 
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

/*
 ⚠️如果是做成卡片等视觉区域与与响应区域不重叠时，一定要把视觉区域置于响应区域中间，否则会出现响应区域偏差
 */

