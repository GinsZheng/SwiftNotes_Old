//
//  ItemBasePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite
import Foundation

private class DataManager {
    func getLastId() -> Int {
        return DB.shared.getLastId(tableName: DBTable.item)
    }
}

// MARK: - 视图控制器
class ItemBasePage: UIViewController {
    var onCompleted: (() -> Void)? // 新删改完成时(刷新列表)
    
    let navView = CSPresentNavView()
    let nameTextField = UITextField()
    let resumeTextField = UITextField()
    let totalProgressTextField = UITextField()
    let colorTextField = UITextField()
    let actionButton = UIButton(type: .custom)
    let deleteButton = UIButton(type: .custom)
    let quickInsertButton = UIButton(type: .custom)
    
    var isInsertMode = true
    var itemModel: Models.Item? // 用于编辑时填充数据的模型
    
    private let dataManager = DataManager()
    private let itemData = ItemDataManager()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - 私有方法
extension ItemBasePage {
    private func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        // 设置导航视图
        let navTitle = isInsertMode ? "Insert" : "Update"
        navView.setup(superview: view, title: navTitle)
        navView.onCloseButtonTap = { self.dismiss() }
        
        // 设置各输入框
        setupTextField(nameTextField, placeholder: "itemName", top: navView.bottom)
        setupTextField(resumeTextField, placeholder: "resume", top: nameTextField.bottom + kVertMargin)
        setupTextField(totalProgressTextField, placeholder: "totalProgress", top: resumeTextField.bottom + kVertMargin)
        setupTextField(colorTextField, placeholder: "color(Int)", top: totalProgressTextField.bottom + kVertMargin)
        
        // 如果是编辑模式，填充文本字段
        if !isInsertMode, let data = itemModel {
            nameTextField.text = data.itemName
            resumeTextField.text = data.resume
            totalProgressTextField.text = String(data.totalProgress)
            colorTextField.text = String(data.color)
        }
        
        // 设置操作按钮
        let buttonTitle = isInsertMode ? "Insert" : "Update"
        actionButton.setup(superview: view, target: self, action: #selector(handleAction))
        actionButton.setStyleSolid17ptFgWhiteThemeButton(title: buttonTitle)
        actionButton.setFrame(left: kEdgeMargin, top: colorTextField.bottom + kVertMargin, right: kEdgeMargin, height: kCellHeight)
        
        // 设置快捷添加按钮
        let quickInsertButton = UIButton(type: .custom)
        quickInsertButton.setup(superview: view, target: self, action: #selector(handleQuickInsert))
        quickInsertButton.setStyleSolid17ptThemeGrayButton(title: "Quick Insert")
        quickInsertButton.setFrame(left: kEdgeMargin, top: actionButton.bottom + kVertMargin, right: kEdgeMargin, height: kCellHeight)
        
        // 设置删除按钮
        if !isInsertMode {
            deleteButton.setup(superview: view, target: self, action: #selector(handleDelete))
            deleteButton.setStyleIconButton(imageName: "delete")
            deleteButton.setShadow(y: 2, radius: 16)
            deleteButton.setFrame(centerX: view.centerX, bottom: 20, width: 44, height: 44)
        }
        
    }
    
    // 输入框设置
    private func setupTextField(_ textField: UITextField, placeholder: String, top: CGFloat) {
        textField.setup(superview: view, placeholder: placeholder, delegate: nil)
        textField.setStyleOneLineTextField()
        textField.setFrame(left: kEdgeMargin, top: top, right: kEdgeMargin, height: kCellHeight)
    }
    
}


// MARK: - @objc方法
extension ItemBasePage {
    @objc func handleDelete() {
        itemData.deleteItem(id: itemModel?.id ?? 0)
        onCompleted?()
        dismiss()
    }
    
    @objc func handleAction() {
        let newItem = Models.Item(
            itemName: self.nameTextField.text ?? "",
            resume: self.resumeTextField.text ?? "",
            totalProgress: Int(self.totalProgressTextField.text ?? "") ?? 100,
            color: Int(self.colorTextField.text ?? "") ?? 0
        )
        isInsertMode ? itemData.insertItem(model: newItem) : itemData.updateItem(id: itemModel?.id ?? 0, model: newItem)
        dismiss()
    }
    
    @objc func handleQuickInsert() {
        let newId = dataManager.getLastId()
        let newItem = Models.Item(itemName: "标题\(newId)", resume: "heyhey", totalProgress: Int(arc4random_uniform(100)) + 1, color: Int(arc4random_uniform(6)))
        itemData.insertItem(model: newItem)
        onCompleted?()
    }
}

