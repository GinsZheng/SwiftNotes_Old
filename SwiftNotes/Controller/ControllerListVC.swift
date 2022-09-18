//
//  CSControllerListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

class CSControllerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let titleList = ["TestVC", "TestPresentVC", "ActionSheet", "Alamofire","Alert", "Class", "Custom Popup Window", "Decorator", "Delegate", "Delegate2", "For & While", "Gesture", "Jump", "Loading", "Map", "Menu Controller", "Number Formatter", "Operator @", "Protocol", "Reload Data", "Timer", "Try", "上传(文字/图片等)"]
    let pageList = [TestVC(), TestPresentVC(), CSActionSheetPage(), CSAlamofirePage(), CSAlertListPage(), CSClassPage(), CSCustomPopupWindowPage(), CSDecoratorPage(), CSDelegatePage(), CSDelegate2Page(), CSForWhilePage(), CSGestureListPage(),  CSJumpListPage(), CSLoadingPage(), CSMapPage(),  CSMenuControllerPage(), CSNumberFormatterPage(), CSOperatorAtPage(), CSProtocolPage(), CSReloadDataPage(), CSTimerPage(), CSTryPage(), CSUploadDataPage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Controller"
        
        let tableView = UITableView()
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.present(toTarget: pageList[indexPath.row])
        } else {
            self.push(toTarget: pageList[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
