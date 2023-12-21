//
//  CollectionViewListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/12/9.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: BaseDataManager<DefaultTableViewItem> {
    init() {
        super.init(initialItems: [
            DefaultTableViewItem(title: "Equal Size", viewController: EqualSizeCollectionViewPage()),
            DefaultTableViewItem(title: "Equal Division", viewController: EqualDivisionCollectionViewPage()),
            DefaultTableViewItem(title: "Auto Layout", viewController: AutoLayoutCollectionViewPage())
        ])
    }
}


class CollectionViewListPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableData = DataManager()

    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: String(describing: DefaultTableViewCell.self))
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
    }
    
    
    // MARK: - tableview 代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: tableData[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title:  tableData[indexPath.row].title)
        
        return cell
    }
    
}

/*
 EqualSizeCollectionViewPage：使用了内置布局 UICollectionViewFlowLayout()，好处是简单易懂，适用于宽高一致的布局
 EqualDivisionCollectionViewPage：自定义的等宽布局，适用于单元格宽度相同高度不同的布局(如瀑布流)
 CollectionViewAutoLayoutPage: 自定义的自适应布局，适用于单元格宽度随着文字长度变化的布局
 */
