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
        
        self.items = newItems.map { item in
            let title = item.title
            let description = item.description
            let leftIconName = item.leftIconName
            let rightIconName = item.rightIconName
            let isSwitchOn = item.isSwitchOn
            
            let viewController = ViewControllerFactory.viewController(for: item.pageId ?? 0)

            switch item.typeId {
            case 11:
                return description == nil ?
                    .title(title: title) :
                    .titleDesc(title: title, description: item.description!)
            case 12:
                if description == nil {
                    return .titleNextVC(title: title, viewController: viewController ?? ButtonPage())
                }
                return .titleDescNextVC(title: title, description: item.description!, viewController: viewController ?? ButtonPage())
//                return item.description == nil ?
//                    .titleNextVC(title: title, viewController: viewController) :
//                    .titleDescNextVC(title: title, description: item.description!, viewController: viewController)
            default:
                print("未知的typeId: \(item.typeId)")
                return .title(title: title)
            }
        }
        
        // ⚠️下一步，把初始化逻辑完善，测试有pageId的情况下是否可以正常跳转
        // 通知数据已更新
        self.onItemsUpdated?()
    }
}

// 映射 pageId 到 viewController
class ViewControllerFactory {
    static var viewControllerMapping: [Int: UIViewController.Type] = [
        1: ButtonPage.self,
        2: ImageViewPage.self,
    ]

    static func viewController(for pageId: Int?) -> UIViewController? {
        guard let pageId = pageId, let vcType = viewControllerMapping[pageId] else {
            print("pageId为nil 或 pageId值对应的页面不存在")
            return nil
        }
        return vcType.init()
    }
}




private struct Response: Decodable {
    var code: Int
    var message: String
    var items: [Items]
}

private struct Items: Decodable {
    var typeId: Int // UI类型id
    var title: String
    var description: String?
    var leftIconName: String?
    var rightIconName: String?
    var isSwitchOn: Bool?
    var pageId: Int? // 要跳转的页面id
}

//cellType: CellType, title: String, description: String = "", descriptionLine: Int = 1, leftIconName: String = "", rightIconName: String = kIconNext, isSwitchOn: Bool = false

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
                self.tableData.updateItems(with: items)
//                for item in items {
//                    let typeId = item.typeId
//                    let title = item.title
//                    let description = item.description ?? ""
//                    let rightIconName = item.rightIconName ?? "next"
//                    print("typeId", typeId, "title", title, description)
//                }

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
            // ⚠️下一步：这里加上有VC的UI类型，以便能够渲染相关内容
        default:
            print("出错")
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
            cell.configure(cellType: .title, title: title, description: description )
        case .titleRightIcon(let title, let rightIconName):
            cell.configure(cellType: .titleRightIcon, title: title, rightIconName: rightIconName)
        case .titleNextVC(let title, _):
            cell.configure(cellType: .titleRightIcon, title: title)
        case .titleDescNextVC(let title, let description, _):
            cell.configure(cellType: .titleRightIcon, title: title)
            // ⚠️下一步：这里加上有VC的UI类型，以便能够渲染相关内容
        default:
            print("出错")
        }
        
        return cell
    }
}

