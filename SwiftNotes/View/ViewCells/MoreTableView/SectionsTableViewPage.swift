//
//  SectionsTableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/15.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: DefaultSectionAndCellDataManager {
    init() {
        super.init(initialItems: [
            DefaultSection(
                header: .title(title: "分组1"),
                cells: [
                    .titleNextVC(title: "标题1", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题2", viewController: CSGeneralSubpage()),
                ],
                footer: .title(title: "表尾内容")
            ),
            DefaultSection(
                header: .titleBg(title: "分组2", titleType: .small),
                cells: [
                    .titleNextVC(title: "标题3", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题4", viewController: CSGeneralSubpage())
                ]
            ),
        ])
    }
}


class SectionsTableViewPage: UIViewController {
    private let tableData = DataManager()
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
}


// MARK: - tableView 代理方法
extension SectionsTableViewPage: UITableViewDelegate, UITableViewDataSource {
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
        return tableData.cellCount(in: section)
    }
    
    // 表头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DefaultHeader()
        let headerItem = tableData.sectionData(for: section).header ?? .noheader
        headerItem.configureHeader(header)
        return header
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        let sectionItem = tableData.sectionData(for: indexPath.section)
        let cellCountInSection = tableView.numberOfRows(inSection: indexPath.section) // 获取当前 section 的 cell 数量
        cell.prepare(row: indexPath.row, cellCountInSection: cellCountInSection, isWhiteHeader: sectionItem.isWhiteHeader(), isWhiteFooter: sectionItem.isWhiteFooter()) // 配置基本参数
        let cellItem = tableData.cellData(for: indexPath)
        cellItem.configureCell(cell) // 配置Cell数据与UI
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
