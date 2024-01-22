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

class ItemBasePage: UIViewController {
    var onCompleted: (() -> Void)? // 新删改完成时(刷新列表)
    
    let navView = CSPresentNavView()
    let nameTextField = UITextField()
    let resumeTextField = UITextField()
    let totalProgressTextField = UITextField()
    let colorTextField = UITextField()
    let actionButton = UIButton()
    let deleteButton = UIButton(type: .custom)
    
    let itemTable = ItemTable()
    
    var isEditMode = false
    var itemModel: Models.Item? // 用于编辑时填充数据的模型
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 供重写的方法：处理添加或更新操作
    func handleAction() {
    }
    
}


// MARK: - 私有方法
extension ItemBasePage: UITextFieldDelegate {
    private func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        // 设置导航视图
        let navTitle = isEditMode ? "Update" : "Insert"
        navView.setup(superview: view, title: navTitle)
        navView.onCloseButtonTap = { self.dismiss() }
        
        // 配置各输入框
        setupTextField(nameTextField, placeholder: "itemName", top: navView.bottom)
        setupTextField(resumeTextField, placeholder: "resume", top: nameTextField.bottom + kVertMargin)
        setupTextField(totalProgressTextField, placeholder: "totalProgress", top: resumeTextField.bottom + kVertMargin)
        setupTextField(colorTextField, placeholder: "color(Int)", top: totalProgressTextField.bottom + kVertMargin)
        
        // 如果是编辑模式，填充文本字段
        if isEditMode, let data = itemModel {
            nameTextField.text = data.itemName
            resumeTextField.text = data.resume
            totalProgressTextField.text = String(data.totalProgress)
            colorTextField.text = String(data.color)
        }
        
        // 设置操作按钮
        let buttonTitle = isEditMode ? "Update" : "Insert"
        actionButton.setup(superview: view)
        actionButton.setStyleSolid17ptFgWhiteThemeButton(title: buttonTitle)
        actionButton.setFrame(left: kEdgeMargin, top: colorTextField.bottom + kVertMargin, right: kEdgeMargin, height: kCellHeight)
        actionButton.setEvent { [weak self] in
            self?.handleAction()
        }
        
        // 设置删除按钮
        if isEditMode {
            deleteButton.setup(superview: view)
            deleteButton.setStyleIconButton(imageName: "delete")
            deleteButton.setShadow(y: 2, radius: 16)
            deleteButton.setFrame(centerX: view.centerX, bottom: 20, width: 44, height: 44)
            deleteButton.setEvent { [weak self] in
                guard let self = self else { return }
                DB.shared.delete(table: self.itemTable, id: self.itemModel?.id ?? 0)
                self.onCompleted?()
                self.dismiss()
            }
        }

    }
    
    // 输入框通用设置
    private func setupTextField(_ textField: UITextField, placeholder: String, top: CGFloat) {
        textField.setup(superview: view, placeholder: placeholder, delegate: self)
        textField.setStyleOneLineTextField()
        textField.setFrame(left: kEdgeMargin, top: top, right: kEdgeMargin, height: kCellHeight)
    }
    
}
