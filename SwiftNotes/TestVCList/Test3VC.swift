//
//  Test3VC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/14.
//  Copyright © 2023 GinsMac. All rights reserved.
//
//
//import UIKit
//
//private class DataManager: BaseDataManager<DefaultTableViewItem> {
//    init() {
//        super.init(initialItems: [
//            DefaultTableViewItem(title: "Animation", viewController: CSGeneralSubpage()),
//            DefaultTableViewItem(title: "Button", viewController: CSGeneralSubpage()),
//        ])
//    }
//}
//
//
//class ViewController: UIViewController {
//    
//    private let tableData = DataManager()
//    var sectionExpanded: [Bool] = [true, true, false]
//    let headerHeight: CGFloat = 44
//    
//    let tableView = UITableView()
//    
//    
//    // MARK: - 生命周期方法
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//    
//    
//    // MARK: - func
//    func setupUI() {
//        view.setBackgroundColor(color: cFFF)
//        
//        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
//        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
//        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
//        tableView.setBackgroundColor(color: cLightRed)
//        // 对于iOS 15.0.由于会有一个默认分组外边距，所以需要做调整，而15.0之前的默认无此外边距，无需处理
//        if #available(iOS 15.0, *) {
//            tableView.sectionHeaderTopPadding = 0
//        }
//        // 数据更新时刷新列表
//        tableData.onItemsUpdated = {  [weak self] in
//            self?.tableView.reloadData()
//        }
//        
//    }
//    
//    
//    // MARK: - @objc func
//    
//}
//
//
//// MARK: - tableView 代理方法
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    // 点击
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.push(toTarget: tableData[indexPath.row].viewController)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    // 表头高度
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return headerHeight
//    }
//    
//    // 行高
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return kCellHeight
//    }
//    
//    // 表尾高度
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return kVertMargin
//    }
//    
//    // 组数
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sectionExpanded.count
//    }
//    
//    // 行数
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sectionExpanded[section] ? tableData.count : 0
//    }
//    
//    // 表头视图
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let bgView = UIView()
//        bgView.setBackgroundColor(color: cLightTheme)
//        bgView.setFrame(left: kEdgeMargin, top: 0, width: kScreenWidth - 2*kEdgeMargin, height: headerHeight)
//        return bgView
//    }
//    
//    // cell
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
//        let item = tableData[indexPath.row]
//        cell.configure(title: item.title, index: indexPath.row, dataCount: tableData.count)
//        return cell
//    }
//    
//    // 表尾视图
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView()
//        // 本函数不写时，即使设置了表尾高度，也不会生效
//        // 所以，如果只是希望两个分组之间有个间隔而设置了表尾，那就直接写 return UIView() 即可
//    }
//    
//    
//    
//}
//
//
//// ❓对于有多个section的内容，应该怎么写数据结构
//// 写一个cell的通用表达式：包括：1. 有Header/Footer时圆角怎么处理，无Header时怎么处理。注意：有Header并不意味着第一个cell就要无圆角，因为Header/Footer有可能不是白底，而只是文字描述
//
//
//
//// MARK: - 自定义的 tableViewCell
//class TaskTableViewCell: UITableViewCell {
//    
//    let cellBg = UIView()
//    
//    
//    static let identifier = String(describing: TaskTableViewCell.self)
//    
//    private let titleLabel = UILabel()
//    private let nextIcon = UIImageView()
//    private let separator = UIView()
//    
//    
//    // MARK: - 初始化
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    // MARK: - func
//    // 设置控件非布局内容 (严谨说是一次性设置的内容，这通常都是非布局内容)
//    private func setupUI() {
//        
//        //        self.setBackgroundColor(color: <#T##String#>)
//        
//        
//        cellBg.setup(superview: contentView, backgroundColor: cFFF)
//        cellBg.setFrame(left: kEdgeMargin, top: 0, right: kEdgeMargin, height: kCellHeight)
//        cellBg.setSeparator(left: 42, right: 12)
//        
//        
//        titleLabel.setup(superview: contentView)
//        titleLabel.setStyle17pt222()
//        
//        nextIcon.setup(superview: contentView, imageName: kIconNext)
//        
//        separator.setup(superview: contentView, backgroundColor: cSeparator)
//        
//    }
//    
//    // 设置控件布局 (严谨说是布局刷新时需要刷新的内容，这通常都是布局内容)
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        titleLabel.setFrame(left: 16, centerY: contentView.centerY)
//
//    }
//    
//    // 配置数据
//    func configure(title: String, index: Int, dataCount: Int) {
//        titleLabel.text = title
//        cellBg.setCellCornerRadius(radius: kRadius, index: index, dataCount: dataCount)
//    }
//    
//}
//
