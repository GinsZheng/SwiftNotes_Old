//
//  FoldableTableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/6.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import UIKit

// A. DataManager 遵循 SectionsProtocol 以实现cellData方法
private class DataManager: DefaultSectionDataManager {
    init() {
        super.init(initialItems: [
            DefaultSection(
                header: .titleFoldBg(title: "titleFoldBg", titleType: .small, isFolded: false),
                cells: [
                    .titleNextVC(title: "标题1", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题2", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题3", viewController: CSGeneralSubpage())
                ]
            ),
            DefaultSection(
                header: .titleDescFoldBg(title: "titleDescFoldBg", titleType: .small, description: "hey", isFolded: true),
                cells: [
                    .titleNextVC(title: "标题4", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题5", viewController: CSGeneralSubpage())
                ],
                footer: .nofooter
            ),
        ])
    }
}


class FoldableTableViewPage: UIViewController {
    private var tableData = DataManager()
    // 1. 定义用于记录是否展开列表的变量
    private var isSectionFolded: [Bool] = []
    
    let tableView = UITableView()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initializeSectionFoldedStatus() // 2. 变量初始化(读取DataManager中的数据)
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupDefaultGroupedTableView(tableView)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = {  [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    func initializeSectionFoldedStatus() {
        isSectionFolded = tableData.items.map { section in
            // 检查是否为 titleFoldBg 或 titleDescFoldBg 类型
            if case let .titleFoldBg(_, _, isFolded) = section.header {
                return isFolded
            } else if case let .titleDescFoldBg(_, _, _, isFolded) = section.header {
                return isFolded
            } else {
                return false
            }
        }
    }

}


// MARK: - tableView 代理方法
extension FoldableTableViewPage: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableData.cellData(for: indexPath)
        item.pushViewControllerOnTap(from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 表头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerItem = tableData.sectionData(for: section).header ?? .noheader
        return headerItem.setHeaderHeight()
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 表尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let footerItem = tableData.sectionData(for: section).footer ?? .nofooter
        return footerItem.setFooterHeight()
    }
    
    // 组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 3. 设置行数：当折叠列表时cell行数返回0(即隐藏了cell)
        return isSectionFolded[section] ? 0 : tableData.cellCount(in: section)
    }
    
    // 表头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DefaultHeader()
        let headerItem = tableData.sectionData(for: section).header ?? .noheader
        headerItem.configureHeader(header)
        header.updateHeaderUI(isFolded: isSectionFolded[section]) // 4.使用可变的isSectionFolded参数设置UI(背景圆角、箭头方向)
        
        // 5. 设置点击事件：切换折叠状态 (以及可能有更新本地缓存/后台数据)
        header.onHeaderTap = { [weak self] in
            guard let self = self else { return }
            self.isSectionFolded[section].toggle()
            header.updateHeaderUI(isFolded: self.isSectionFolded[section])
            self.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
        
        return header
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        // 获取section数据
        let sectionItem = tableData.sectionData(for: indexPath.section)
        // 获取当前 section 的 cell 数量
        let cellCountInSection = tableView.numberOfRows(inSection: indexPath.section)
        cell.prepare(row: indexPath.row, cellCountInSection: cellCountInSection, isWhiteHeader: sectionItem.isWhiteHeader(), isWhiteFooter: sectionItem.isWhiteFooter())
        // 获取 cell 的数据
        let cellItem = tableData.cellData(for: indexPath)
        cellItem.configureCell(cell)
        return cell
    }
    
    // 表尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = DefaultFooter()
        let footerItem = tableData.sectionData(for: section).footer ?? .nofooter
        footerItem.configureFooter(footer)
        return footer
    }
    
}



/*
 indexPath.section 与 indexPath.row：
 前者是section的下标，总数为 numberOfSections 返回
 后者是cell的下标，或者说每个cell就是一个row，总数为numberOfRowsInSection 返回
 */
