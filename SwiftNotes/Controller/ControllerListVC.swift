//
//  CSControllerListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

class CSControllerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableData: [DefaultTableViewItem] = [
        DefaultTableViewItem(title: "TestVC", viewController: ViewController()),
        DefaultTableViewItem(title: "TestPresentVC", viewController: TestPresentVC()),
        DefaultTableViewItem(title: "ActionSheet", viewController: ActionSheetPage()),
        DefaultTableViewItem(title: "Alamofire", viewController: CSAlamofirePage()),
        DefaultTableViewItem(title: "Alert", viewController: CSAlertListPage()),
        DefaultTableViewItem(title: "Class", viewController: CSClassPage()),
        DefaultTableViewItem(title: "Closure", viewController: ClosureListVC()),
        DefaultTableViewItem(title: "Custom Popup Window", viewController: CSCustomPopupWindowPage()),
        DefaultTableViewItem(title: "Decorator", viewController: CSDecoratorPage()),
        DefaultTableViewItem(title: "Delegate", viewController: CSDelegatePage()),
        DefaultTableViewItem(title: "Delegate2", viewController: CSDelegate2Page()),
        DefaultTableViewItem(title: "Delegate3", viewController: CSDelegate3Page()),
        DefaultTableViewItem(title: "DidSet", viewController: DidSetVC()),
        DefaultTableViewItem(title: "For & While", viewController: CSForWhilePage()),
        DefaultTableViewItem(title: "Formatter", viewController: FormatterListPage()),
        DefaultTableViewItem(title: "Gesture", viewController: CSGestureListPage()),
        DefaultTableViewItem(title: "Jump", viewController: CSJumpListPage()),
        DefaultTableViewItem(title: "Loading", viewController: CSLoadingPage()),
        DefaultTableViewItem(title: "Map", viewController: CSMapPage()),
        DefaultTableViewItem(title: "Menu Controller", viewController: CSMenuControllerPage()),
        DefaultTableViewItem(title: "Operator @", viewController: CSOperatorAtPage()),
        DefaultTableViewItem(title: "Protocol", viewController: CSProtocolPage()),
        DefaultTableViewItem(title: "Reload Data", viewController: CSReloadDataPage()),
        DefaultTableViewItem(title: "Switch View", viewController: SwitchViewListPage()),
        DefaultTableViewItem(title: "Timer", viewController: CSTimerPage()),
        DefaultTableViewItem(title: "Transfer Data", viewController: TransferDataListVC()),
        DefaultTableViewItem(title: "Try", viewController: CSTryPage()),
        DefaultTableViewItem(title: "上传(文字/图片等)", viewController: CSUploadDataPage())
    ]
    
    let tableView = UITableView()
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        self.title = "Controller"
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
    }
    
    
    // MARK: - tableView代理方法
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(left: 20, right: 0)
        
        let cellTitle = UILabel()
        cellTitle.setup(superview: cell, text: tableData[indexPath.row].title)
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.setup(superview: cell, imageName: kIconNext)
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.present(toTarget: tableData[indexPath.row].viewController)
        } else {
            self.push(toTarget: tableData[indexPath.row].viewController)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


