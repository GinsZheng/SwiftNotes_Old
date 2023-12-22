//
//  CSControllerListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: BaseDataManager<DefaultTableItem> {
    init() {
        super.init(initialItems: [
            DefaultTableItem(title: "TestVC", viewController: ViewController()),
            DefaultTableItem(title: "TestPresentVC", viewController: TestPresentVC()),
            DefaultTableItem(title: "ActionSheet", viewController: ActionSheetPage()),
            DefaultTableItem(title: "Alamofire", viewController: CSAlamofirePage()),
            DefaultTableItem(title: "Alert", viewController: CSAlertListPage()),
            DefaultTableItem(title: "Class", viewController: CSClassPage()),
            DefaultTableItem(title: "Closure", viewController: ClosureListVC()),
            DefaultTableItem(title: "Custom Popup Window", viewController: CSCustomPopupWindowPage()),
            DefaultTableItem(title: "Decorator", viewController: CSDecoratorPage()),
            DefaultTableItem(title: "Delegate", viewController: CSDelegatePage()),
            DefaultTableItem(title: "Delegate2", viewController: CSDelegate2Page()),
            DefaultTableItem(title: "Delegate3", viewController: CSDelegate3Page()),
            DefaultTableItem(title: "DidSet", viewController: DidSetVC()),
            DefaultTableItem(title: "For & While", viewController: CSForWhilePage()),
            DefaultTableItem(title: "Formatter", viewController: FormatterListPage()),
            DefaultTableItem(title: "Gesture", viewController: CSGestureListPage()),
            DefaultTableItem(title: "Jump", viewController: CSJumpListPage()),
            DefaultTableItem(title: "Loading", viewController: CSLoadingPage()),
            DefaultTableItem(title: "Map", viewController: CSMapPage()),
            DefaultTableItem(title: "Menu Controller", viewController: CSMenuControllerPage()),
            DefaultTableItem(title: "Operator @", viewController: CSOperatorAtPage()),
            DefaultTableItem(title: "Protocol", viewController: CSProtocolPage()),
            DefaultTableItem(title: "Reload Data", viewController: CSReloadDataPage()),
            DefaultTableItem(title: "Switch View", viewController: SwitchViewListPage()),
            DefaultTableItem(title: "Timer", viewController: CSTimerPage()),
            DefaultTableItem(title: "Transfer Data", viewController: TransferDataListVC()),
            DefaultTableItem(title: "Try", viewController: CSTryPage()),
            DefaultTableItem(title: "上传(文字/图片等)", viewController: CSUploadDataPage())
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
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: tableData[indexPath.row].title
        )
        return cell
    }
}

