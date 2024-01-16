//
//  TableViewWithMultiCellType.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/22.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// 所有UI类型的示例
private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            // 正常数据
            .title(title: "11 title"),
            .titleDesc(title: "11 titleDesc", description: "描述"),
            .titleRightIcon(title: "12 titleRightIcon", rightIconName: kIconCheckbox_s),
            .titleDescRightIcon(title: "12 titleDescRightIcon", description: "描述", rightIconName: kIconCheckbox_s),
            .titleNext(title: "12 titleNext"),
            .titleDescNext(title: "12 titleDescNext", description: "描述"),
            .titleNextVC(title: "12 titleNextVC", viewController: ViewControllerManager.viewController(for: 1) ?? ImageViewPage()),
            .titleDescNextVC(title: "12 titleDescNextVC", description: "描述", viewController: ButtonPage()),
            .titleSwitch(title: "13 titleSwitch", isSwitchOn: true),
            .titleLeftIconNext(title: "14 titleLeftIconNext", leftIconName: kIconCheckbox_s),
            .titleDescLeftIconNext(title: "14 titleDescLeftIconNext", description: "描述", leftIconName: kIconCheckbox_s),
            .titleLeftIconNextVC(title: "14 titleLeftIconNextVC", leftIconName: kIconCheckbox_s, viewController: ButtonPage()),
            .titleDescLeftIconNextVC(title: "14 titleDescLeftIconNextVC", description: "描述", leftIconName: kIconCheckbox, viewController: ButtonPage()),
            .titleLeftIconSwitch(title: "15 titleLeftIconSwitch", leftIconName: kIconCheckbox, isSwitchOn: true),
            .titleMiddleIconRightIcon(title: "16 titleMiddleIconRightIcon", middleIconName: "mine_aboutAs", rightIconName: kIconCheckbox_s),
            .titleDescMiddleIconRightIcon(title: "16 titleDescMiddleIconRightIcon", description: "IIIIII描述", middleIconName: "mine_aboutAs", rightIconName: kIconCheckbox_s),
            .titleMiddleIconNext(title: "16 titleMiddleIconNext", middleIconName: "mine_aboutAs"),
            .titleDescMiddleIconNext(title: "16 titleDescMiddleIconNext", description: "描述", middleIconName: "mine_aboutAs"),
            .titleMiddleIconNextVC(title: "16 titleMiddleIconNextVC", middleIconName: "mine_aboutAs", viewController: ButtonPage()),
            .titleDescMiddleIconNextVC(title: "16 titleDescMiddleIconNextVC", description: "描述", middleIconName: "mine_aboutAs", viewController: ButtonPage()),
            .titleMiddleIconSwitch(title: "17 titleMiddleIconSwitch", middleIconName: "mine_aboutAs", isSwitchOn: true),
            .titleDescRightIcon2Line(title: "22 titleDescRightIcon2Line", description: "描述", rightIconName: kIconCheckbox),
            .titleDesc2Line(title: "21 titleDesc2Line", description: "描述"),
            .titleDescNext2Line(title: "22 titleDescNext2Line", description: "描述"),
            .titleDescNextVC2Line(title: "22 titleDescNextVC2Line", description: "描述", viewController: ButtonPage()),
            .titleDescSwitch2Line(title: "23 titleDescSwitch2Line", description: "描述", isSwitchOn: true),
            .titleDescSwitchVC2Line(title: "23 titleDescSwitchVC2Line", description: "描述", isSwitchOn: false, viewController: ButtonPage()),
            // 长标题
            .title(title: "11 title IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"),
            .titleDesc(title: "11 titleDesc IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述"),
            .titleRightIcon(title: "12 titleRightIcon IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", rightIconName: kIconCheckbox_s),
            .titleDescRightIcon(title: "12 titleDescRightIcon IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", rightIconName: kIconCheckbox_s),
            .titleNext(title: "12 titleNext IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"),
            .titleDescNext(title: "12 titleDescNext IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述"),
            .titleNextVC(title: "12 titleNextVC IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", viewController: ViewControllerManager.viewController(for: 1) ?? ImageViewPage()),
            .titleDescNextVC(title: "12 titleDescNextVC IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", viewController: ButtonPage()),
            .titleSwitch(title: "13 titleSwitch IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", isSwitchOn: true),
            .titleLeftIconNext(title: "14 titleLeftIconNext IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", leftIconName: kIconCheckbox_s),
            .titleDescLeftIconNext(title: "14 titleDescLeftIconNext IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", leftIconName: kIconCheckbox_s),
            .titleLeftIconNextVC(title: "14 titleLeftIconNextVC IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", leftIconName: kIconCheckbox_s, viewController: ButtonPage()),
            .titleDescLeftIconNextVC(title: "14 titleDescLeftIconNextVC IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", leftIconName: kIconCheckbox, viewController: ButtonPage()),
            .titleLeftIconSwitch(title: "15 titleLeftIconSwitch IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", leftIconName: kIconCheckbox, isSwitchOn: true),
            .titleMiddleIconRightIcon(title: "16 titleMiddleIconRightIcon IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", middleIconName: "mine_aboutAs", rightIconName: kIconCheckbox_s),
            .titleDescMiddleIconRightIcon(title: "16 titleDescMiddleIconRightIcon IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", middleIconName: "mine_aboutAs", rightIconName: kIconCheckbox_s),
            .titleMiddleIconNext(title: "16 titleMiddleIconNext IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", middleIconName: "mine_aboutAs"),
            .titleDescMiddleIconNext(title: "16 titleDescMiddleIconNext IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", middleIconName: "mine_aboutAs"),
            .titleMiddleIconNextVC(title: "16 titleMiddleIconNextVC IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", middleIconName: "mine_aboutAs", viewController: ButtonPage()),
            .titleDescMiddleIconNextVC(title: "16 titleDescMiddleIconNextVC IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", middleIconName: "mine_aboutAs", viewController: ButtonPage()),
            .titleMiddleIconSwitch(title: "17 titleMiddleIconSwitch IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", middleIconName: "mine_aboutAs", isSwitchOn: true),
            .titleDescRightIcon2Line(title: "22 titleDescRightIcon2Line IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", rightIconName: kIconCheckbox),
            .titleDesc2Line(title: "21 titleDesc2Line IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述"),
            .titleDescNext2Line(title: "22 titleDescNext2Line IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述"),
            .titleDescNextVC2Line(title: "22 titleDescNextVC2Line IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", viewController: ButtonPage()),
            .titleDescSwitch2Line(title: "23 titleDescSwitch2Line IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", isSwitchOn: true),
            .titleDescSwitchVC2Line(title: "23 titleDescSwitchVC2Line IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", description: "描述", isSwitchOn: false, viewController: ButtonPage()),
            // 长描述
            .title(title: "11 title"),
            .titleDesc(title: "11 titleDesc", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述"),
            .titleRightIcon(title: "12 titleRightIcon", rightIconName: kIconCheckbox_s),
            .titleDescRightIcon(title: "12 titleDescRightIcon", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", rightIconName: kIconCheckbox_s),
            .titleNext(title: "12 titleNext"),
            .titleDescNext(title: "12 titleDescNext", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述"),
            .titleNextVC(title: "12 titleNextVC", viewController: ViewControllerManager.viewController(for: 1) ?? ImageViewPage()),
            .titleDescNextVC(title: "12 titleDescNextVC", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", viewController: ButtonPage()),
            .titleSwitch(title: "13 titleSwitch", isSwitchOn: true),
            .titleLeftIconNext(title: "14 titleLeftIconNext", leftIconName: kIconCheckbox_s),
            .titleDescLeftIconNext(title: "14 titleDescLeftIconNext", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", leftIconName: kIconCheckbox_s),
            .titleLeftIconNextVC(title: "14 titleLeftIconNextVC", leftIconName: kIconCheckbox_s, viewController: ButtonPage()),
            .titleDescLeftIconNextVC(title: "14 titleDescLeftIconNextVC", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", leftIconName: kIconCheckbox, viewController: ButtonPage()),
            .titleLeftIconSwitch(title: "15 titleLeftIconSwitch", leftIconName: kIconCheckbox, isSwitchOn: true),
            .titleMiddleIconRightIcon(title: "16 titleMiddleIconRightIcon", middleIconName: "mine_aboutAs", rightIconName: kIconCheckbox_s),
            .titleDescMiddleIconRightIcon(title: "16 titleDescMiddleIconRightIcon", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", middleIconName: "mine_aboutAs", rightIconName: kIconCheckbox_s),
            .titleMiddleIconNext(title: "16 titleMiddleIconNext", middleIconName: "mine_aboutAs"),
            .titleDescMiddleIconNext(title: "16 titleDescMiddleIconNext", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", middleIconName: "mine_aboutAs"),
            .titleMiddleIconNextVC(title: "16 titleMiddleIconNextVC", middleIconName: "mine_aboutAs", viewController: ButtonPage()),
            .titleDescMiddleIconNextVC(title: "16 titleDescMiddleIconNextVC", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", middleIconName: "mine_aboutAs", viewController: ButtonPage()),
            .titleMiddleIconSwitch(title: "17 titleMiddleIconSwitch", middleIconName: "mine_aboutAs", isSwitchOn: true),
            .titleDescRightIcon2Line(title: "22 titleDescRightIcon2Line", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", rightIconName: kIconCheckbox),
            .titleDesc2Line(title: "21 titleDesc2Line", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述"),
            .titleDescNext2Line(title: "22 titleDescNext2Line", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述"),
            .titleDescNextVC2Line(title: "22 titleDescNextVC2Line", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", viewController: ButtonPage()),
            .titleDescSwitch2Line(title: "23 titleDescSwitch2Line", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", isSwitchOn: true),
            .titleDescSwitchVC2Line(title: "23 titleDescSwitchVC2Line", description: "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII描述", isSwitchOn: false, viewController: ButtonPage()),
        ])
    }
}


class MultiCellTypeTableViewPage: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupDefaultTableView(tableView)
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
        return tableData[indexPath.row].getCellHeight()
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// 本例中，Cell是否有点击事件取决于是否viewController参数，所以用tableData来判断
        /// 常见情况有：
        /// 1. 各个Cell跳转与否，跳转到哪都不同(常见于我的页列表)，需要配viewController参数：用tableData来判断
        /// 2. 各个Cell跳转与否，跳转到哪都相同(常见于首页列表)，无需viewController参数，分3情情况：1. 无需判断(即每个列表都跳转到相同的页面) 2. 用固定的逻辑判断(比如判断是否离线等，不用tableData来判断) 3. 用tableData中的UI类型来判断(属于比较省事的做法，把跳转的逻辑与tableData绑定)
        tableData[indexPath.row].handleCellTapForPushOrClosure(from: self) {
            self.push(targetVC: CSGeneralSubpage())
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
        cell.prepare(row: indexPath.row, cellCountInSection: tableData.count)
        tableData[indexPath.row].configureCell(cell)
        return cell
    }
    
}
