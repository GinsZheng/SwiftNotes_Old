//
//  JsonDataTableViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/23.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit
import Alamofire

private class DataManager: BaseDataManager<TableCellItem> {
    
}

extension DataManager {
    func updateItems(with newItems: [Items]) {
        // 清除旧数据
        self.items.removeAll()

        // 遍历新数据，并转换为TableCellItem
        for item in newItems {
            switch item.typeId {
            case 11:
                if let description = item.description {
                    self.items.append(.titleDesc(title: item.title, description: description))
                } else {
                    self.items.append(.title(title: item.title))
                }
            case 12:
                if let rightIconName = item.rightIconName {
                    self.items.append(.titleRightIcon(title: item.title, rightIconName: rightIconName))
                } else {
                    self.items.append(.title(title: item.title))
                }
            default:
                print("未知的typeId: \(item.typeId)")
            }
        }

        // 通知数据已更新
        self.onItemsUpdated?()
    }
}


private struct Response: Decodable {
    var code: Int
    var message: String
    var items: [Items]
}

private struct Items: Decodable {
    var typeId: Int
    var title: String
    var description: String?
    var rightIconName: String?
}


class JsonDataTableViewPage: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let url = "http://127.0.0.1:8009/returnJson"
        AF.request(url).responseDecodable(of: Response.self) { response in
            if let value = response.value {
                let code = value.code
                let message = value.message
                let items = value.items
                for item in items {
                    let typeId = item.typeId
                    let title = item.title
                    let description = item.description ?? ""
                    let rightIconName = item.rightIconName ?? "next"
                    print("typeId", typeId, "title", title, description)
                }
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
        self.push(toTarget: CSGeneralSubpage())
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
        default:
            print("出错")
        }
        
        return cell
    }
}

