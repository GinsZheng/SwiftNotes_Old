//
//  TableViewWithMultiCellType.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//



import UIKit

// 下一步：1. 把多类别的tableView写出来 2. 单类与多类应当很容易切换(因为列表很可能在迭代时增加一个类)
private class DataManager: BaseDataManager<TableCellItem> {
    init() {
        super.init(initialItems: [
            .title(title: "Animation"),
            .titleRightIcon(title: "Button", rightIconName: "checkmark"),
            .titleDesc(title: "Label", description: "描述"),
            .titleDesc(title: "Layer", description: "哈哈"),
            .titleVC(title: "Nav Controller", viewController: NavControllerPage()),
            .titleLeftIconRightIconVC(title: "Picker View", leftIconName: "tab_tickets_s", rightIconName: "next", viewController: PickerViewPage()),
            .titleDescVC(title: "Scroll View", description: "哈哈", viewController: ScrollViewPage()),
            .titleDescLeftIconSwitchVC(title: "Scroll View Horizonal", description: "hey", leftIconName: "tab_tickets_s", isSwitchOn: true, viewController: ScrollViewHorizonalPage())
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
        /// 本例中，Cell是否有点击事件取决于是否viewController参数，所以用tableData来判断
        /// 常见情况有：
        /// 1. 各个Cell跳转与否，跳转到哪都不同(常见于我的页列表)，需要配viewController参数：用tableData来判断
        /// 2. 各个Cell跳转与否，跳转到哪都相同(常见于首页列表)，无需viewController参数，分3情情况：1. 无需判断(即每个列表都跳转到相同的页面) 2. 用固定的逻辑判断(比如判断是否离线等，不用tableData或cellTypeData来判断) 3. 用cellTypeData来判断(属于比较省事的做法，把跳转的逻辑与CellType绑定)
        let item = tableData[indexPath.row]
        switch item {
        case .titleVC(_, let viewController):
            self.push(toTarget: viewController)
        case .titleLeftIconRightIconVC(_, _, _, let viewController):
            self.push(toTarget: viewController)
        case .titleDescVC(_, _, let viewController):
            self.push(toTarget: viewController)
        case .titleDescLeftIconSwitchVC(_, _, _, _, let viewController):
            self.push(toTarget: viewController)
        default:
            print("done")
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
        
//        cell.prepare(cellType: cellTypeItem, row: indexPath.row, dataCount: cellTypeData.count)
        
        // 这里我想先判断
        
        switch item {
        case .title(let title):
            cell.prepare(cellType: .title, row: indexPath.row, dataCount: tableData.count)
            cell.configure(title: title)
        case .titleRightIcon(let title, let rightIconName):
            cell.prepare(cellType: .titleRightIcon, row: indexPath.row, dataCount: tableData.count)
            cell.configure(title: title, rightIconName: rightIconName)
        default:
            print("done")
        }

//            .title(title: "Animation"),
//            .titleRightIcon(title: "Button", rightIconName: "checkmark"),
//            .titleDesc(title: "Label", description: "描述"),
//            .titleDesc(title: "Layer", description: "哈哈"),
//            .titleVC(title: "Nav Controller", viewController: NavControllerPage()),
//            .titleLeftIconRightIconVC(title: "Picker View", leftIconName: "tab_tickets_s", rightIconName: "next", viewController: PickerViewPage()),
//            .titleDescVC(title: "Scroll View", description: "哈哈", viewController: ScrollViewPage()),
//            .titleDescLeftIconSwitchVC(title: "Scroll View Horizonal", description: "hey", leftIconName: "tab_tickets_s", isSwitchOn: true, viewController: ScrollViewHorizonalPage())
        
        
//    case .titleVC(let title, _):
//        cell.prepare(cellType: .title, row: indexPath.row, dataCount: tableData.count)
//        cell.configure(title: title)
//    case .titleSwitchVC(let title, let isSwitchOn, _):
//        cell.configure(title: title, isSwitchOn: isSwitchOn)
        
        
        
        return cell
    }
}


//.title(title: "Animation"),
//.titleRightIcon(title: "Button", rightIconName: "checkmark"),
//.titleDesc(title: "Label", description: "描述"),
//.titleDesc(title: "Layer", description: "哈哈"),
//.titleVC(title: "Nav Controller", viewController: NavControllerPage()),
//.titleLeftIconRightIconVC(title: "Picker View", leftIconName: "tab_tickets_s", rightIconName: "next", viewController: PickerViewPage()),
//.titleDescVC(title: "Scroll View", description: "哈哈", viewController: ScrollViewPage()),
//.titleDescLeftIconSwitchVC(title: "Scroll View Horizonal", description: "hey", leftIconName: "tab_tickets_s", isSwitchOn: true, viewController: ScrollViewHorizonalPage())

