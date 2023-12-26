//
//  JsonDataTableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/23.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit
import Alamofire


// ⚠️下一步：看GPT，把TableCellDataManager这个子类实现
private class DataManager: DefaultCellDataManager {
    
}


// 映射 pageId 到 viewController
class ViewControllerManager {
    static var viewControllers: [Int: UIViewController.Type] = [
        1: ButtonPage.self,
        2: ImageViewPage.self,
    ]
    
    static func viewController(for pageId: Int?) -> UIViewController? {
        guard let pageId = pageId, let vcType = viewControllers[pageId] else {
            return nil
        }
        return vcType.init()
    }
}




struct DefaultTableResponse: Decodable {
    var code: Int
    var message: String
    var items: [DefaultCellModel]
}

struct DefaultCellModel: Decodable {
    var typeId: Int // UI类型id
    var title: String
    var description: String?
    var leftIconName: String?
    var rightIconName: String?
    var isSwitchOn: Bool?
    var pageId: Int? // 要跳转的页面id
}


class JsonDataTableViewPage: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let url = "https://gotest.ginkgeek.com/returnJson"
        AF.request(url).responseDecodable(of: DefaultTableResponse.self) { response in
            if let value = response.value {
                let items = value.items
                self.tableData.updateItems(with: items)
            } else {
                print(response.error!)
            }
        }
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
        tableView.register(DefaultCell.self, forCellReuseIdentifier: DefaultCell.identifier)
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kVertMargin, right: 0)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - @objc func
    
}


// MARK: - TableView 代理方法
extension JsonDataTableViewPage: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.push(toTarget: CSGeneralSubpage())
        let item = tableData[indexPath.row]
        
        switch item {
        case .titleNextVC(_, let viewController):
            self.push(toTarget: viewController)
        case .titleDescNextVC(_, _, let viewController):
            self.push(toTarget: viewController)
        default:
            print("无跳转")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(row: indexPath.row, dataCount: tableData.count)
        let item = tableData[indexPath.row]
        
        switch item {
        case .title(let title):
            cell.configure(cellType: .title, title: title)
        case .titleDesc(let title, let description):
            cell.configure(cellType: .title, title: title, description: description)
        case .titleRightIcon(let title, let rightIconName):
            cell.configure(cellType: .titleRightIcon, title: title, rightIconName: rightIconName)
        case .titleNextVC(let title, _):
            cell.configure(cellType: .titleRightIcon, title: title)
        case .titleDescNextVC(let title, let description, _):
            cell.configure(cellType: .titleRightIcon, title: title, description: description)
        case .titleSwitch(let title, let isSwitchOn):
            cell.configure(cellType: .titleSwitch, title: title, isSwitchOn: isSwitchOn)
        default:
            print("出错")
        }
        
        return cell
    }
}

