//
//  TableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

// MARK: - TableView 默认数据结构体
struct DefaultTableViewItem {
    let title: String
    let viewController: UIViewController
}


class TableViewPage: UIViewController {
    
    let dataSource: [DefaultTableViewItem] = [
        DefaultTableViewItem(title: "Animation", viewController: CSGeneralSubpage()),
        DefaultTableViewItem(title: "Button", viewController: CSGeneralSubpage()),
    ]
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
    }
    
    
    // MARK: - @objc func
    
    
}


// MARK: - 代理方法：UITableViewDelegate
extension TableViewPage: UITableViewDelegate {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: dataSource[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - 代理方法：UITableViewDataSource
extension TableViewPage: UITableViewDataSource {
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        cell.configure(title: dataSource[indexPath.row].title)
        return cell
    }
}


// MARK: - 自定义的默认 tableViewCell
class DefaultTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: DefaultTableViewCell.self)
    
    private let titleLabel = UILabel()
    private let nextIcon = UIImageView()
    private let separator = UIView()
    
    
    // MARK: - 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    // 设置控件非布局内容 (严谨说是一次性设置的内容，这通常都是非布局内容)
    private func setupUI() {
        titleLabel.set(superview: contentView)
        titleLabel.setStyle17pt222()
        
        nextIcon.set(superview: contentView, imageName: "next")
        
        separator.set(superview: contentView, backgroundColor: cSeparator)
        
    }
    
    // 设置控件布局 (严谨说是布局刷新时需要刷新的内容，这通常都是布局内容)
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.setFrame(left: 16, centerY: contentView.centerY)
        nextIcon.setFrame(right: 16, centerY: contentView.centerY, width: 18, height: 18)
        separator.setSeparatorFrame(left: 16, right: 16)
    }
    
    // 配置数据
    func configure(title: String) {
        titleLabel.text = title
    }
    
}


/*
 DefaultTableViewCell 类中，为什么要把分为 setupUI() 和 layoutSubviews()
 前者(主要是非布局内容)只会在初始化时调用一次，后者(主要是布局内容)则会经常刷新，时机有：视图大小改变时、添加或移除子视图时、改变约束时等等
 为了性能考虑，应当区分二者
 */

/*
 TableViewCell内容超出Frame：
 TableViewCell内容超出Frame时，以投影超出为例，可以完整显示，不会被裁切，
 但在滑动列表后，会出现投影被裁切的情况，些时把背景颜色设置为透明即可解决
 (可能)扩展而言：只要不设置 maskToBounds 属性，所有的视图都可以超出控件边界
 */

/*
 复杂情形示例：
 同时满足 A：需要在子页面(通过代理)更新父页面的列表 B：列表的高度根据文字多少计算而来
 思路：1. 为了满足B，高度需要创建一个数组如cellHeightArray，在func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) 函数中完成计算与添加值到数组cellHeightArray中。然后把cellHeightArray的值作为func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)中的返回的cell高度值
 2. 为了满足A，需要创建一个代理，代理中由于不知道cellHeightArray在更新后的值，所以要让cellHeightArray = Array(repeating: 0, count: dateArray.count)，先填个正确长度的值，然后让cellHeightArray在<cellForRowAt>中赋值，要写成cellHeightArray[indexPath.row] = cellHeight 而不是用append方法，来完成替换
 3. 详见蜗牛进度中的⌜进度列表⌟页面
 
 */


/*
 TableViewCell中可交互控件失效处理方法：
 // 以UISwitch为例，把UISwitch控件添加到cell.contentView上而不是添加到cell上
 let cell = CellComponent()
 cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: 0)
 cell.setBackgroundColor(color: cNoColor)
 cell.selectionStyle = .none
 
 let switchView = UISwitch()
 switchView.set(superview: cell.contentView)
 switchView.setFrame(right: 20, centerY: cardBg.centerY, width: switchView.width, height: switchView.height)
 switchView.onTintColor = UIColor.hex(cBlue_5393FF)
 switchView.setOn(true, animated: false)
 */

/*
 此函数：func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 主要是用来设置数据，而不是设置UI，所以应当把UI放到另一个自定义的UITableViewCell类中
 */
/*
 ⚠️如果是做成卡片等视觉区域与与响应区域不重叠时，一定要把视觉区域置于响应区域中间，否则会出现响应区域偏差
 */

