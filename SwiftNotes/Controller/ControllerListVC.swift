//
//  CSControllerListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: BaseDataManager<TempDefaultCellItem> {
    init() {
        super.init(initialItems: [
            TempDefaultCellItem(title: "TestVC", viewController: ViewController()),
            TempDefaultCellItem(title: "TestPresentVC", viewController: TestPresentVC()),
            TempDefaultCellItem(title: "ActionSheet", viewController: ActionSheetPage()),
            TempDefaultCellItem(title: "Alamofire", viewController: CSAlamofirePage()),
            TempDefaultCellItem(title: "Alert", viewController: CSAlertListPage()),
            TempDefaultCellItem(title: "Class", viewController: CSClassPage()),
            TempDefaultCellItem(title: "Closure", viewController: ClosureListVC()),
            TempDefaultCellItem(title: "Custom Popup Window", viewController: CSCustomPopupWindowPage()),
            TempDefaultCellItem(title: "Decorator", viewController: CSDecoratorPage()),
            TempDefaultCellItem(title: "Delegate", viewController: CSDelegatePage()),
            TempDefaultCellItem(title: "Delegate2", viewController: CSDelegate2Page()),
            TempDefaultCellItem(title: "Delegate3", viewController: CSDelegate3Page()),
            TempDefaultCellItem(title: "DidSet", viewController: DidSetVC()),
            TempDefaultCellItem(title: "For & While", viewController: CSForWhilePage()),
            TempDefaultCellItem(title: "Formatter", viewController: FormatterListPage()),
            TempDefaultCellItem(title: "Gesture", viewController: CSGestureListPage()),
            TempDefaultCellItem(title: "Jump", viewController: CSJumpListPage()),
            TempDefaultCellItem(title: "Loading", viewController: CSLoadingPage()),
            TempDefaultCellItem(title: "Map", viewController: CSMapPage()),
            TempDefaultCellItem(title: "Menu Controller", viewController: CSMenuControllerPage()),
            TempDefaultCellItem(title: "Operator @", viewController: CSOperatorAtPage()),
            TempDefaultCellItem(title: "Protocol", viewController: CSProtocolPage()),
            TempDefaultCellItem(title: "Reload Data", viewController: CSReloadDataPage()),
            TempDefaultCellItem(title: "Switch View", viewController: SwitchViewListPage()),
            TempDefaultCellItem(title: "Timer", viewController: CSTimerPage()),
            TempDefaultCellItem(title: "Transfer Data", viewController: TransferDataListVC()),
            TempDefaultCellItem(title: "Try", viewController: CSTryPage()),
            TempDefaultCellItem(title: "上传(文字/图片等)", viewController: CSUploadDataPage())
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
        cell.prepare(row: indexPath.row, dataCount: tableData.count)
        cell.configure(cellType: .titleRightIcon, title: tableData[indexPath.row].title)
        return cell
    }
}

