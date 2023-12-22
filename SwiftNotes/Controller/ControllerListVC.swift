//
//  CSControllerListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: BaseDataManager<DefaultTableViewItem> {
    init() {
        super.init(initialItems: [
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
        ])
    }
}


class CSControllerListVC: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kVertMargin, right: 0)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - @objc func
    
}


// MARK: - TableView 代理方法
extension CSControllerListVC: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: tableData[indexPath.row].viewController)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: tableData[indexPath.row].title
        )
        return cell
    }
}

