//
//  CSControllerListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: BaseDataManager<DefaultCellItem> {
    init() {
        super.init(initialItems: [
            DefaultCellItem(title: "TestVC", viewController: ViewController()),
            DefaultCellItem(title: "TestPresentVC", viewController: TestPresentVC()),
            DefaultCellItem(title: "ActionSheet", viewController: ActionSheetPage()),
            DefaultCellItem(title: "Alamofire", viewController: CSAlamofirePage()),
            DefaultCellItem(title: "Alert", viewController: CSAlertListPage()),
            DefaultCellItem(title: "Class", viewController: CSClassPage()),
            DefaultCellItem(title: "Closure", viewController: ClosureListVC()),
            DefaultCellItem(title: "Custom Popup Window", viewController: CSCustomPopupWindowPage()),
            DefaultCellItem(title: "Decorator", viewController: CSDecoratorPage()),
            DefaultCellItem(title: "Delegate", viewController: CSDelegatePage()),
            DefaultCellItem(title: "Delegate2", viewController: CSDelegate2Page()),
            DefaultCellItem(title: "Delegate3", viewController: CSDelegate3Page()),
            DefaultCellItem(title: "DidSet", viewController: DidSetVC()),
            DefaultCellItem(title: "For & While", viewController: CSForWhilePage()),
            DefaultCellItem(title: "Formatter", viewController: FormatterListPage()),
            DefaultCellItem(title: "Gesture", viewController: CSGestureListPage()),
            DefaultCellItem(title: "Jump", viewController: CSJumpListPage()),
            DefaultCellItem(title: "Loading", viewController: CSLoadingPage()),
            DefaultCellItem(title: "Map", viewController: CSMapPage()),
            DefaultCellItem(title: "Menu Controller", viewController: CSMenuControllerPage()),
            DefaultCellItem(title: "Operator @", viewController: CSOperatorAtPage()),
            DefaultCellItem(title: "Protocol", viewController: CSProtocolPage()),
            DefaultCellItem(title: "Reload Data", viewController: CSReloadDataPage()),
            DefaultCellItem(title: "Switch View", viewController: SwitchViewListPage()),
            DefaultCellItem(title: "Timer", viewController: CSTimerPage()),
            DefaultCellItem(title: "Transfer Data", viewController: TransferDataListVC()),
            DefaultCellItem(title: "Try", viewController: CSTryPage()),
            DefaultCellItem(title: "上传(文字/图片等)", viewController: CSUploadDataPage())
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
        
        tableView.register(DefaultCell.self, forCellReuseIdentifier: DefaultCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(cellType: .titleRightIcon, row: indexPath.row, dataCount: tableData.count)
        cell.configure(title: tableData[indexPath.row].title)
        return cell
    }
}

