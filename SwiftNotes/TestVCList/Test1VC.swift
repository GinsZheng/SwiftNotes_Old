//
//  Test1VC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/24.
//  Copyright © 2023 GinsMac. All rights reserved.
//
//  Test1VC

import UIKit

class Test1VC: UIViewController {
    
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
        tableView.register(DefaultTableViewCell22.self, forCellReuseIdentifier: DefaultTableViewCell22.identifier)
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
    }
    
    
    // MARK: - @objc func
    
    
}


// MARK: - 代理方法：UITableViewDelegate
extension Test1VC: UITableViewDelegate {
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
extension Test1VC: UITableViewDataSource {
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell22.identifier, for: indexPath) as? DefaultTableViewCell22 else { return UITableViewCell() }
        cell.configure(title: dataSource[indexPath.row].title)
        return cell
    }
}


// MARK: - 自定义的默认 tableViewCell
class DefaultTableViewCell22: UITableViewCell {
    
    static let identifier = String(describing: DefaultTableViewCell22.self)
    
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

