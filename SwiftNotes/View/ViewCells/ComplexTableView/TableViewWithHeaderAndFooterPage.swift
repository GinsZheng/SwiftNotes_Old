//
//  TableViewWithHeaderAndFooterPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/15.
//  Copyright © 2023 GinsMac. All rights reserved.
//

/*
 本页演示了tableView怎么加表头表尾，具体包括了：
 1. 多个section且有表头时数据结构怎么写怎么调用 A1 -A4
 2. 每个section展开/折叠怎么写 B
 */

import UIKit

// A1. 表头与cell写两个Struct，表头的struct 遵循 SectionProtocol以实现cellData方法
private struct Section: SectionProtocol {
    var sectionTitle: String
    var cells: [CellData]
}

// A2. cell的struct
private struct CellData {
    var title: String
    var viewController: UIViewController
}

// A3. DataManager 遵循 SectionedDataManager 以实现cellData方法
private class DataManager: BaseDataManager<Section>, SectionedDataManager {
    init() {
        super.init(initialItems: [
            Section(
                sectionTitle: "Section 1",
                cells: [
                    CellData(title: "标题1", viewController: CSGeneralSubpage()),
                    CellData(title: "标题2", viewController: CSGeneralSubpage()),
                    CellData(title: "标题3", viewController: CSGeneralSubpage())
                ]
            ),
            Section(
                sectionTitle: "Section 2",
                cells: [
                    CellData(title: "标题4", viewController: CSGeneralSubpage()),
                    CellData(title: "标题5", viewController: CSGeneralSubpage())
                ]
            ),
            Section(
                sectionTitle: "Section 3",
                cells: [
                    CellData(title: "标题6", viewController: CSGeneralSubpage()),
                    CellData(title: "标题7", viewController: CSGeneralSubpage()),
                    CellData(title: "标题8", viewController: CSGeneralSubpage()),
                    CellData(title: "标题9", viewController: CSGeneralSubpage()),
                ]
            )
        ])
    }
}


class TableViewWithHeaderAndFooterPage: UIViewController {
    
    private let tableData = DataManager()
    let headerHeight: CGFloat = 44
    // B1. 定义用于记录是否展开列表的变量
    var sectionExpanded: [Bool] = []
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // B2. 变量初始化(因为tableData的使用需要先初始化)
        sectionExpanded = Array(repeating: true, count: tableData.count)
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 8, right: 0, height: kWithoutNavBarHeight)
        // 对于iOS 15.0.由于会有一个默认分组外边距，所以需要做调整，而15.0之前的默认无此外边距，无需处理
        tableView.hideSectionHeaderTopPadding()
        tableView.setBackgroundColor(color: cNoColor)
        tableData.onItemsUpdated = {  [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    
    // MARK: - @objc func
    @objc func toggleScetion() {
        print("Yes")
    }
}


// MARK: - tableView 代理方法
extension TableViewWithHeaderAndFooterPage: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = tableData.cellData(for: indexPath).viewController // cellData函数调用
        self.push(toTarget: viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 表头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
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
        return sectionExpanded[section] ? tableData.numberOfCells(in: section) : 0
    }
    
    // 表头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DefaultSectionHeader()
        header.setFrame(left: 0, top: 0, width: kScreenWidth, height: headerHeight)
        header.setupView()
        header.configure(title: tableData[section].sectionTitle)
        // B4. 配置切换按钮 (这里看起来配不配tag都行)
        // header.toggleButton.tag = section
        header.onToggleSection = { [weak self] in
            guard let self = self else { return }
            self.sectionExpanded[section].toggle() // 切换 section 的展开状态(toggle为bool属性自带函数，切换true与false状态)
            tableView.reloadSections([section], with: .automatic) // 刷新该 section
        }
        
        return header
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        let item = tableData.cellData(for: indexPath)
        cell.configure(cellType: .titleRightArrow,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: item.title)
        return cell
    }
    
    // 表尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
        // 本函数不写时，即使设置了表尾高度，也不会生效
        // 所以，如果只是希望两个分组之间有个间隔而设置了表尾，那就直接写 return UIView() 即可
    }
    
}


class DefaultSectionHeader: UIView {
    
    var onToggleSection: (() -> Void)?
    
    let bgView = UIView()
    let titleLabel = UILabel()
    let toggleButton = UIButton(type: .custom)
    
    // MARK: - func
    func setupView() {
        bgView.setup(superview: self, backgroundColor: cFFF)
        bgView.setBackgroundColor(color: cFFF)
        bgView.setFrame(allEdges: 0)
        
        titleLabel.setup(superview: bgView)
        titleLabel.setStyle20pt000Med()
        titleLabel.setFrame(left: 16, centerY: bgView.centerY, width: 300)
        
        toggleButton.setup(superview: bgView, target: self, action: #selector(toggleScetion))
        toggleButton.setStyleIconButton(imageName: "location_upArrow")
        toggleButton.setFrame(right: 16, centerY: bgView.centerY, width: 16, height: 16)
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    // MARK: - @objc func
    @objc func toggleScetion() {
        onToggleSection?()
    }
    
}



/*
 indexPath.section 与 indexPath.row：
 前者是section的下标，总数为 numberOfSections 返回
 后者是cell的下标，或者说每个cell就是一个row，总数为numberOfRowsInSection 返回
 */
