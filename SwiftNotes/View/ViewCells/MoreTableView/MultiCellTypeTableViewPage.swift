//
//  TableViewWithMultiCellType.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// 下一步：1. 把多类别的tableView写出来 2. 单类与多类应当很容易切换(因为列表很可能在迭代时增加一个类)
private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .title(title: "11 title"),
            .titleDesc(title: "11 titleDesc", description: "描述"),
            .titleNext(title: "12 titleNext"),
            .titleDescNext(title: "12 titleDescNext", description: "描述描述描述描述描述描述描述描述描述描述描述"),
            .titleNextVC(title: "12 titleNextVC", viewController: ViewControllerManager.viewController(for: 1) ?? ImageViewPage()),
            .titleDescNextVC(title: "12 titleDescNextVC", description: "hey", viewController: ButtonPage()),
            .titleRightIcon(title: "12 titleRightIcon", rightIconName: kIconCheckbox_s),
            .titleDescRightIcon(title: "12 titleDescRightIcon", description: "hey", rightIconName: kIconCheckbox_s),
            .titleSwitch(title: "13 titleSwitch", isSwitchOn: true),
            .titleLeftIconNext(title: "14 titleLeftIconNext", leftIconName: kIconCheckbox_s),
            .titleDescLeftIconNext(title: "14 titleDescLeftIconNext", description: "hey", leftIconName: kIconCheckbox_s),
            .titleLeftIconNextVC(title: "14 titleLeftIconNextVC", leftIconName: kIconCheckbox_s, viewController: ButtonPage()),
            .titleDescLeftIconNextVC(title: "14 titleDescLeftIconNextVC", description: "hey", leftIconName: kIconCheckbox, viewController: ButtonPage()),
            .titleLeftIconSwitch(title: "15 titleLeftIconSwitch", leftIconName: kIconCheckbox, isSwitchOn: true),
            .titleDesc2Line(title: "21 titleDesc2Line", description: "hey"),
            .titleDescNext2Line(title: "22 titleDescNext2Line", description: "hey"),
            .titleDescNextVC2Line(title: "22 titleDescNextVC2Line", description: "hey", viewController: ButtonPage()),
            .titleDescRightIcon2Line(title: "22 titleDescRightIcon2Line", description: "hey", rightIconName: kIconCheckbox),
            .titleDescSwitch2Line(title: "23 titleDescSwitch2Line", description: "hey", isSwitchOn: true),
            .titleDescSwitchVC2Line(title: "23 titleDescSwitchVC2Line", description: "hey", isSwitchOn: false, viewController: ButtonPage()),
            // ————
            .title(title: "11 title"),
            .titleDesc(title: "11 titleDesc", description: "描述"),
            .titleNext(title: "12 titleNext"),
            .titleDescNext(title: "12 titleDescNext", description: "描述描述描述描述描述描述描述描述描述描述描述"),
            .titleNextVC(title: "12 titleNextVC", viewController: ViewControllerManager.viewController(for: 1) ?? ImageViewPage()),
            .titleDescNextVC(title: "12 titleDescNextVC", description: "hey", viewController: ButtonPage()),
            .titleRightIcon(title: "12 titleRightIcon", rightIconName: kIconCheckbox_s),
            .titleDescRightIcon(title: "12 titleDescRightIcon", description: "hey", rightIconName: kIconCheckbox_s),
            .titleSwitch(title: "13 titleSwitch", isSwitchOn: true),
            .titleLeftIconNext(title: "14 titleLeftIconNext", leftIconName: kIconCheckbox_s),
            .titleDescLeftIconNext(title: "14 titleDescLeftIconNext", description: "hey", leftIconName: kIconCheckbox_s),
            .titleLeftIconNextVC(title: "14 titleLeftIconNextVC", leftIconName: kIconCheckbox_s, viewController: ButtonPage()),
            .titleDescLeftIconNextVC(title: "14 titleDescLeftIconNextVC", description: "hey", leftIconName: kIconCheckbox, viewController: ButtonPage()),
            .titleLeftIconSwitch(title: "15 titleLeftIconSwitch", leftIconName: kIconCheckbox, isSwitchOn: true),
            .titleDesc2Line(title: "21 titleDesc2Line", description: "hey"),
            .titleDescNext2Line(title: "22 titleDescNext2Line", description: "hey"),
            .titleDescNextVC2Line(title: "22 titleDescNextVC2Line", description: "hey", viewController: ButtonPage()),
            .titleDescRightIcon2Line(title: "22 titleDescRightIcon2Line", description: "hey", rightIconName: kIconCheckbox),
            .titleDescSwitch2Line(title: "23 titleDescSwitch2Line", description: "hey", isSwitchOn: true),
            .titleDescSwitchVC2Line(title: "23 titleDescSwitchVC2Line", description: "hey", isSwitchOn: false, viewController: ButtonPage()),            .title(title: "11 title"),
            .titleDesc(title: "11 titleDesc", description: "描述"),
            .titleNext(title: "12 titleNext"),
            .titleDescNext(title: "12 titleDescNext", description: "描述描述描述描述描述描述描述描述描述描述描述"),
            .titleNextVC(title: "12 titleNextVC", viewController: ViewControllerManager.viewController(for: 1) ?? ImageViewPage()),
            .titleDescNextVC(title: "12 titleDescNextVC", description: "hey", viewController: ButtonPage()),
            .titleRightIcon(title: "12 titleRightIcon", rightIconName: kIconCheckbox_s),
            .titleDescRightIcon(title: "12 titleDescRightIcon", description: "hey", rightIconName: kIconCheckbox_s),
            .titleSwitch(title: "13 titleSwitch", isSwitchOn: true),
            .titleLeftIconNext(title: "14 titleLeftIconNext", leftIconName: kIconCheckbox_s),
            .titleDescLeftIconNext(title: "14 titleDescLeftIconNext", description: "hey", leftIconName: kIconCheckbox_s),
            .titleLeftIconNextVC(title: "14 titleLeftIconNextVC", leftIconName: kIconCheckbox_s, viewController: ButtonPage()),
            .titleDescLeftIconNextVC(title: "14 titleDescLeftIconNextVC", description: "hey", leftIconName: kIconCheckbox, viewController: ButtonPage()),
            .titleLeftIconSwitch(title: "15 titleLeftIconSwitch", leftIconName: kIconCheckbox, isSwitchOn: true),
            .titleDesc2Line(title: "21 titleDesc2Line", description: "hey"),
            .titleDescNext2Line(title: "22 titleDescNext2Line", description: "hey"),
            .titleDescNextVC2Line(title: "22 titleDescNextVC2Line", description: "hey", viewController: ButtonPage()),
            .titleDescRightIcon2Line(title: "22 titleDescRightIcon2Line", description: "hey", rightIconName: kIconCheckbox),
            .titleDescSwitch2Line(title: "23 titleDescSwitch2Line", description: "hey", isSwitchOn: true),
            .titleDescSwitchVC2Line(title: "23 titleDescSwitchVC2Line", description: "hey", isSwitchOn: false, viewController: ButtonPage()),
        ])
    }
}


class MultiCellTypeTableViewPage: UIViewController {
    
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
extension MultiCellTypeTableViewPage: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// 本例中，Cell是否有点击事件取决于是否viewController参数，所以用tableData来判断
        /// 常见情况有：
        /// 1. 各个Cell跳转与否，跳转到哪都不同(常见于我的页列表)，需要配viewController参数：用tableData来判断
        /// 2. 各个Cell跳转与否，跳转到哪都相同(常见于首页列表)，无需viewController参数，分3情情况：1. 无需判断(即每个列表都跳转到相同的页面) 2. 用固定的逻辑判断(比如判断是否离线等，不用tableData来判断) 3. 用tableData中的UI类型来判断(属于比较省事的做法，把跳转的逻辑与tableData绑定)
        let item = tableData[indexPath.row]
        item.handleCellTap(in: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(row: indexPath.row, dataCount: tableData.count)
        let item = tableData[indexPath.row]
        item.configureCell(cell)
        return cell
    }
}
