//
//  HeaderAndFooterTableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/15.
//  Copyright © 2023 GinsMac. All rights reserved.
//

/*
 本页演示了tableView怎么加表头表尾，具体包括了：
 1. 多个section且有表头时数据结构怎么写怎么调用 A
 2. 每个section展开/折叠怎么写 B
 */

import UIKit

// A1. 表头与cell写两个Struct，表头的struct 遵循 SectionProtocol以实现cellData方法
private struct Section: SectionProtocol {
    var header: DefaultHeaderItems
    var cells: [DefaultCellItems]
}


// A2. DataManager 遵循 SectionedDataManager 以实现cellData方法
private class DataManager: BaseDataManager<Section>, SectionedDataManager {
    init() {
        super.init(initialItems: [
            Section(
                header: .title(title: "title"),
                cells: [
                    .titleNextVC(title: "标题1", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题2", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题3", viewController: CSGeneralSubpage())
                ]
            ),
            Section(
                header: .titleBg(title: "titleBg", titleType: .small),
                cells: [
                    .titleNextVC(title: "标题4", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题5", viewController: CSGeneralSubpage())
                ]
            ),
            Section(
                header: .titleDescBg(title: "titleDescBg", titleType: .medium, description: "hey"),
                cells: [
                    .titleNextVC(title: "标题6", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题7", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题8", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题9", viewController: CSGeneralSubpage()),
                ]
            ),
            Section(
                header: .titleDescRightIcon(title: "titleDescRightIcon", titleType: .large, description: "hey", rightIconName: "checkmark"),
                cells: [.titleNextVC(title: "Hey", viewController: CSGeneralSubpage()),]
            ),
            Section(
                header: .titleDescRightIcon(title: "titleDescRightIcon", titleType: .small, description: "hey", rightIconName: "checkmark"),
                cells: [.titleNextVC(title: "Hey", viewController: CSGeneralSubpage()),]
            ),
            Section(
                header: .titleNext(title: "titleNext", titleType: .small),
                cells: [.titleNextVC(title: "Hey", viewController: CSGeneralSubpage()),]
            ),
            Section(
                header: .titleDescNext(title: "titleDescNext", titleType: .small, description: "hey"),
                cells: [.titleNextVC(title: "Hey", viewController: CSGeneralSubpage()),]
            ),
            Section(
                header: .titleFoldBg(title: "titleFoldBg", titleType: .small, isFolded: true),
                cells: [.titleNextVC(title: "Hey", viewController: CSGeneralSubpage()),]
            ),
            Section(
                header: .titleDescFoldBg(title: "titleDescFoldBg", titleType: .small, description: "hey", isFolded: false),
                cells: [.titleNextVC(title: "Hey", viewController: CSGeneralSubpage()),]
            ),
            // ————
            
        ])
    }
}


class HeaderAndFooterTableViewPage: UIViewController {
    private let tableData = DataManager()
    let headerHeight: CGFloat = kHeaderSmallHeight
    // B1. 定义用于记录是否展开列表的变量
    var isSectionFolded: [Bool] = []
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // B2. 变量初始化(因为tableData的使用需要先初始化)
        isSectionFolded = Array(repeating: true, count: tableData.count)
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        setupDefaultTableView(tableView)
        tableView.setBackgroundColor(color: cNoColor)
        // 对于iOS 15.0.由于会有一个默认分组外边距，所以需要做调整，而15.0之前的默认无此外边距，无需处理
        tableView.hideSectionHeaderTopPadding()
        // 数据更新时刷新列表
        tableData.onItemsUpdated = {  [weak self] in
            self?.tableView.reloadData()
        }
        
    }

}


// MARK: - tableView 代理方法
extension HeaderAndFooterTableViewPage: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let viewController = tableData.cellData(for: indexPath).viewController // cellData函数调用
//        self.push(toTarget: viewController)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 表头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerItem = tableData.items[section].header
        return headerItem.setHeaderHeight()
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 表尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kVertMargin
    }
    
    // 组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // B3. 设置行数：当折叠列表时cell行数返回0(即隐藏了cell)
        return isSectionFolded[section] ? tableData.numberOfCells(in: section) : 0
    }
    
    // 表头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DefaultHeader()
        let headerItem = tableData.items[section].header
        headerItem.configureHeader(header)

        // B4. 配置切换按钮 (这里看起来配不配tag都行)
        // header.toggleButton.tag = section
        header.onToggleSection = { [weak self] in
            guard let self = self else { return }
            self.isSectionFolded[section].toggle() // 切换 section 的展开状态(toggle为bool属性自带函数，切换true与false状态)
            tableView.reloadSections([section], with: .automatic) // 刷新该 section
        }
        
        return header
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        // 获取当前 section 的 cell 数量
        let cellCountInSection = tableView.numberOfRows(inSection: indexPath.section)
        cell.prepare(row: indexPath.row, cellCountInSection: cellCountInSection, isWhiteHeader: true)
        
        // 获取 cell 的数据
        let item = tableData.items[indexPath.section].cells[indexPath.row]
        item.configureCell(cell)

        return cell
    }
    
    // 表尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
        // 本函数不写时，即使设置了表尾高度，也不会生效
        // 所以，如果只是希望两个分组之间有个间隔而设置了表尾，那就直接写 return UIView() 即可
    }
    
}





/*
 indexPath.section 与 indexPath.row：
 前者是section的下标，总数为 numberOfSections 返回
 后者是cell的下标，或者说每个cell就是一个row，总数为numberOfRowsInSection 返回
 */
