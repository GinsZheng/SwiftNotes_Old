//
//  CSControllerListVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .titleNextVC(title: "TestVC", viewController: ViewController()),
            .titleNextVC(title: "TestPresentVC", viewController: TestPresentVC()),
            .titleNextVC(title: "ActionSheet", viewController: ActionSheetPage()),
            .titleNextVC(title: "Alamofire", viewController: CSAlamofirePage()),
            .titleNextVC(title: "Alert", viewController: CSAlertListPage()),
            .titleNextVC(title: "Class", viewController: CSClassPage()),
            .titleNextVC(title: "Closure", viewController: ClosureListVC()),
            .titleNextVC(title: "Custom Popup Window", viewController: CSCustomPopupWindowPage()),
            .titleNextVC(title: "Decorator", viewController: CSDecoratorPage()),
            .titleNextVC(title: "Delegate", viewController: CSDelegatePage()),
            .titleNextVC(title: "Delegate2", viewController: CSDelegate2Page()),
            .titleNextVC(title: "Delegate3", viewController: CSDelegate3Page()),
            .titleNextVC(title: "DidSet", viewController: DidSetVC()),
            .titleNextVC(title: "For & While", viewController: CSForWhilePage()),
            .titleNextVC(title: "Formatter", viewController: FormatterListPage()),
            .titleNextVC(title: "Gesture", viewController: CSGestureListPage()),
            .titleNextVC(title: "Jump", viewController: CSJumpListPage()),
            .titleNextVC(title: "Loading", viewController: CSLoadingPage()),
            .titleNextVC(title: "Map", viewController: CSMapPage()),
            .titleNextVC(title: "Menu Controller", viewController: CSMenuControllerPage()),
            .titleNextVC(title: "Operator @", viewController: CSOperatorAtPage()),
            .titleNextVC(title: "Protocol", viewController: CSProtocolPage()),
            .titleNextVC(title: "Reload Data", viewController: CSReloadDataPage()),
            .titleNextVC(title: "Switch View", viewController: SwitchViewListPage()),
            .titleNextVC(title: "Timer", viewController: CSTimerPage()),
            .titleNextVC(title: "Transfer Data", viewController: TransferDataListVC()),
            .titleNextVC(title: "Try", viewController: CSTryPage()),
            .titleNextVC(title: "上传(文字/图片等)", viewController: CSUploadDataPage())
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
        setupDefaultTableView(tableView)
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
        let item = tableData[indexPath.row]
        item.pushViewControllerOnTap(from: self)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(row: indexPath.row, cellCountInSection: tableData.count)
        let item = tableData[indexPath.row]
        item.configureCell(cell)
        return cell
    }
}

