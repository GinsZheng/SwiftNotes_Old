//
//  CSItemInsertPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite

class CSItemInsertPage: UIViewController {
    var onInserted: (() -> Void)?
    
    let navView = CSPresentNavView()
    let nameTextField = UITextField()
    let resumeTextField = UITextField()
    let totalProgressTextField = UITextField()
    let colorTextField = UITextField()
    let addingButton = UIButton()
    
    let itemTable = ItemTable()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - 私有方法
extension CSItemInsertPage: UITextFieldDelegate {
    private func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        navView.setup(superview: view, title: "Insert")
        navView.onCloseButtonTap = { self.dismiss() }
        
        nameTextField.setup(superview: view, placeholder: "itemName", delegate: self)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: kEdgeMargin, top: navView.bottom, right: kEdgeMargin, height: kCellHeight)
        
        resumeTextField.setup(superview: view, placeholder: "resume", delegate: self)
        resumeTextField.setStyleOneLineTextField()
        resumeTextField.setFrame(left: kEdgeMargin, top: nameTextField.bottom + kVertMargin, right: kEdgeMargin, height: kCellHeight)
        
        totalProgressTextField.setup(superview: view, placeholder: "totalProgress", delegate: self)
        totalProgressTextField.setStyleOneLineTextField()
        totalProgressTextField.setFrame(left: kEdgeMargin, top: resumeTextField.bottom + kVertMargin, right: kEdgeMargin, height: kCellHeight)
        
        colorTextField.setup(superview: view, placeholder: "color(Int)", delegate: self)
        colorTextField.setStyleOneLineTextField()
        colorTextField.setFrame(left: kEdgeMargin, top: totalProgressTextField.bottom + kVertMargin, right: kEdgeMargin, height: kCellHeight)
        
        addingButton.setup(superview: view)
        addingButton.setStyleSolid17ptFgWhiteThemeButton(title: "Insert")
        addingButton.setFrame(left: kEdgeMargin, top: colorTextField.bottom + kVertMargin, right: kEdgeMargin, height: kCellHeight)
        addingButton.setEvent {
            let newRow = Models.Item(
                itemName: self.nameTextField.text ?? "",
                resume: self.resumeTextField.text ?? "",
                totalProgress: Int(self.totalProgressTextField.text ?? "") ?? 100,
                color: Int(self.colorTextField.text ?? "") ?? 0
            )
            DB.shared.insert(table: self.itemTable, model: newRow)
            self.onInserted?()
            self.dismiss()
        }
        
    }
    
}
