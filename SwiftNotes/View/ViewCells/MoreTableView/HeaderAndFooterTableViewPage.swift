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
 2.
 */

import UIKit

// A1. 表头/表尾层级的struct 遵循 SectionProtocol以实现cellData方法
private struct Section: SectionProtocol {
    var header: DefaultHeaderItems?
    var cells: [DefaultCellItems]
    var footer: DefaultFooterItems?
    
    func isWhiteHeader() -> Bool {
        switch header {
        case .none, .noheader, .title:
            return false
        default:
            return true
        }
    }
    
    func isWhiteFooter() -> Bool {
        switch footer {
        case .none, .nofooter, .title:
            return false
        default:
            return true
        }
    }
}


// A2. DataManager 遵循 SectionedDataManager 以实现cellData方法
private class DataManager: BaseDataManager<Section>, SectionedDataManager {
    init() {
        super.init(initialItems: [
            Section(
                cells: [
                    .titleNextVC(title: "标题1", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题2", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题3", viewController: CSGeneralSubpage())
                ]
            ),
            Section(
                header: .noheader,
                cells: [
                    .titleNextVC(title: "标题1", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题2", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题3", viewController: CSGeneralSubpage())
                ],
                footer: .title(title: "title")
            ),
            Section(
                header: .title(title: "titletitletitletitletitle"),
                cells: [
                    .titleNextVC(title: "标题1", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题2", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题3", viewController: CSGeneralSubpage())
                ],
                footer: .titleBg(title: "titleBg", titleType: .medium)
            ),
            Section(
                header: .titleBg(title: "titleBg", titleType: .small),
                cells: [
                    .titleNextVC(title: "标题4", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题5", viewController: CSGeneralSubpage())
                ],
                footer: .nofooter
            ),
            Section(
                header: .titleDescBg(title: "titleDescBg", titleType: .medium, description: "hey"),
                cells: [
                    .titleNextVC(title: "标题6", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题7", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题8", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题9", viewController: CSGeneralSubpage()),
                ],
                footer: .title(title: "title")
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
                header: .titleFoldBg(title: "titleFoldBg", titleType: .small, isFolded: false),
                cells: [.titleNextVC(title: "Hey", viewController: CSGeneralSubpage()),]
            ),
            Section(
                header: .titleDescFoldBg(title: "titleDescFoldBg", titleType: .small, description: "hey", isFolded: false),
                cells: [.titleNextVC(title: "Hey", viewController: CSGeneralSubpage()),]
            ),
        ])
    }
}


class HeaderAndFooterTableViewPage: UIViewController {
    private let tableData = DataManager()
    // ⚠️默认表头吸顶，不吸顶要在初始化时把style设为.grouped。维持吸顶就直接 let tableView = UITableView()
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
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
        // B3. 设置行数：当折叠列表时cell行数返回0(即隐藏了cell)
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
        // 获取section数据
        let sectionItem = tableData.sectionData(for: indexPath.section)
        // 获取当前 section 的 cell 数量
        let cellCountInSection = tableView.numberOfRows(inSection: indexPath.section)
        cell.prepare(row: indexPath.row, cellCountInSection: cellCountInSection, isWhiteHeader: sectionItem.isWhiteHeader())
        
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
//        return UIView()
        // 所以，如果只是希望两个分组之间有个间隔而设置了表尾，那就直接写 return UIView() 即可 (不写时，即使设置了表尾高度，也不会生效)
    }
    
}





/*
 indexPath.section 与 indexPath.row：
 前者是section的下标，总数为 numberOfSections 返回
 后者是cell的下标，或者说每个cell就是一个row，总数为numberOfRowsInSection 返回
 */
