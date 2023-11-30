//
//  CSControllerListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

class CSControllerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list: [(String, UIViewController)] = [
        ("TestVC", ViewController()),
        ("TestPresentVC", TestPresentVC()),
        ("ActionSheet", ActionSheetPage()),
        ("Alamofire", CSAlamofirePage()),
        ("Alert", CSAlertListPage()),
        ("Class", CSClassPage()),
        ("Closure", ClosureListVC()),
        ("Custom Popup Window", CSCustomPopupWindowPage()),
        ("Decorator", CSDecoratorPage()),
        ("Delegate", CSDelegatePage()),
        ("Delegate2", CSDelegate2Page()),
        ("Delegate3", CSDelegate3Page()),
        ("DidSet", DidSetVC()),
        ("For & While", CSForWhilePage()),
        ("Formatter", FormatterListPage()),
        ("Gesture", CSGestureListPage()),
        ("Jump", CSJumpListPage()),
        ("Loading", CSLoadingPage()),
        ("Map", CSMapPage()),
        ("Menu Controller", CSMenuControllerPage()),
        ("Operator @", CSOperatorAtPage()),
        ("Protocol", CSProtocolPage()),
        ("Reload Data", CSReloadDataPage()),
        ("Switch View", SwitchViewListPage()),
        ("Timer", CSTimerPage()),
        ("Transfer Data", TransferDataListVC()),
        ("Try", CSTryPage()),
        ("上传(文字/图片等)", CSUploadDataPage()),
    ]
    
    let tableView = UITableView()
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Controller"
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
    }
    
    
    // MARK: - tableView代理方法
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(left: 20, right: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: list[indexPath.row].0)
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.present(toTarget: list[indexPath.row].1)
        } else {
            self.push(toTarget: list[indexPath.row].1)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


