//
//  TransferDataListPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/30.
//  Copyright © 2023 GinsMac. All rights reserved.
//

/*
 值传递与处理的方式除了代理，还有其他方式。本页用来呈现不同传值方式的使用示例
 ———— 传递值的方法
 1. 全局常量/全局变量
 2. (全局)结构体/类，如：
 struct GlobalStyles {
     static let sharedFontSize: CGFloat = 17
     static let sharedWeight: UIFont.Weight = .medium
 }
 3. 闭包：对于简单的事件处理，闭包通常是最简洁和直接的选择。但对于需要广播或者观察属性变化的场景，通知(NotificationCenter)或KVO可能更合适
 4. 代理
 */


 /*
 常见的数据传递方式的优劣、使用场景:
 1. 直接访问（Public Fields）:
 优点：简单直接，易于实现。
 劣点：违反了封装原则，增加了类之间的耦合度。
 使用场景：仅在类的内部模块或紧密相关的类之间使用，不推荐在大型项目中广泛使用。

 2. 通过方法访问（Getters/Setters）:
 优点：保持了封装，可以在方法中添加逻辑进行数据验证或处理。
 劣点：编写更多的代码，可能导致过度封装。
 使用场景：适用于大多数场合，特别是需要封装和数据验证的情况。

 3. 构造器参数:
 优点：可以在对象创建时就设置必要的数据，确保对象状态的完整性。
 劣点：随着参数数量的增加，构造器可能变得复杂。
 使用场景：适用于初始化必要状态的场合，尤其是不可变对象的创建。

 4. 依赖注入:
 优点：减少了类之间的耦合，增强了模块的独立性和可测试性。
 劣点：需要额外的框架支持，可能增加学习和配置的复杂度。
 使用场景：适用于大型、模块化的应用程序，尤其是在使用Spring等框架的情况下。

 5. 设计模式（如观察者模式、访问者模式等）:
 优点：提供了一种标准的方式来处理复杂的交互和数据传递。
 劣点：可能会增加系统的复杂性和理解难度。
 使用场景：适用于需要特定交互模式和灵活性的复杂应用场景。

 6. 服务层或代理类:
 优点：在不同类之间提供了一个中介层，可以处理复杂的逻辑和交互。
 劣点：可能增加了系统的层次和复杂性。
 使用场景：适用于需要将业务逻辑与数据访问逻辑分离的场合。
  
 */

import UIKit

private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .titleNextVC(title: "Delegate", viewController: CSDelegatePage()),
            .titleNextVC(title: "Closure", viewController: Closure2VC())
        ])
    }
}


class TransferDataListVC: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    // MARK: - 生命周期方法
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
extension TransferDataListVC: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableData[indexPath.row].pushViewControllerOnTap(from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableData[indexPath.row].setCellHeight()
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

