//
//  TableViewWithMultiCellType.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//



import UIKit

//private class DataManager: BaseDataManager<DefaultCellItem> {
//    init() {
//        super.init(initialItems: [
//            DefaultCellItem(title: "Animation", viewController: AnimationPage()),
//            DefaultCellItem(title: "Button", viewController: ButtonPage()),
//        ])
//    }
//}

// 下一步：1. 把多类别的写出来 2. 单类与多类应当很容易切换(因为列表很可能在迭代时增加一个类)
private class DataManager: BaseDataManager<TableCellItem> {
    init() {
        super.init(initialItems: [
            .title(title: "Animation", viewController: AnimationPage()),
            .titleSwitch(title: "Button", isSwitchOn: true, viewController: ButtonPage()),
            // 添加更多的items
        ])
    }
}



class MultiCellTypeTableView: UIViewController {
    
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
extension MultiCellTypeTableView: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.push(toTarget: tableData[indexPath.row].viewController)
        let item = tableData[indexPath.row]

        switch item {
        case .title(_, let viewController):
            self.push(toTarget: viewController)
        case .titleSwitch(_, _, let viewController):
            self.push(toTarget: viewController)
        // 根据需要添加更多的case
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        let item = tableData[indexPath.row]

        switch item {
        case .title(let title, _):
            cell.prepare(cellType: .title, row: indexPath.row, dataCount: tableData.count)
            cell.configure(title: title)
        case .titleSwitch(let title, let isSwitchOn, _):
            cell.configure(title: title, isSwitchOn: isSwitchOn)
        }
        return cell
    }
}

