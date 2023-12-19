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

class CSItemInsertPage: UIViewController, UITextFieldDelegate {
    
    let navPresent = CSPresentNav()
    
    let nameTextField = UITextField()
    let resumeTextField = UITextField()
    let totalProgressTextField = UITextField()
    let colorTextField = UITextField()
    let addingButton = UIButton()
    
    let itemTable = ItemTable()
    
    weak var delegate: CSReloadDelegate?
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        navPresent.setTitleLabel(superview: view, title: "Insert")
        navPresent.setCloseButton(superview: view, target: self, action: #selector(dismissPage))
        
        nameTextField.setup(superview: view, placeholder: "itemName", delegate: self)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: navPresent.titleLabel.bottom + 20, right: 20, height: 48)
        
        resumeTextField.setup(superview: view, placeholder: "resume", delegate: self)
        resumeTextField.setStyleOneLineTextField()
        resumeTextField.setFrame(left: 20, top: nameTextField.bottom + 20, right: 20, height: 48)
        
        totalProgressTextField.setup(superview: view, placeholder: "totalProgress", delegate: self)
        totalProgressTextField.setStyleOneLineTextField()
        totalProgressTextField.setFrame(left: 20, top: resumeTextField.bottom + 20, right: 20, height: 48)
        
        colorTextField.setup(superview: view, placeholder: "color(Int)", delegate: self)
        colorTextField.setStyleOneLineTextField()
        colorTextField.setFrame(left: 20, top: totalProgressTextField.bottom + 20, right: 20, height: 48)
        
        addingButton.setup(superview: view, target: self, action: #selector(addItem))
        addingButton.setStyleSolid17ptFgWhiteThemeButton(title: "Insert")
        addingButton.setFrame(left: 20, top: colorTextField.bottom + 20, right: 20, height: 48)
    }
    
    
    // MARK: - @objc func
    @objc func dismissPage() {
        self.dismiss()
    }
    
    // 建立委托
    @objc func addItem() {
        let id = itemTable.getNextId()
        let insertValue: [String: Any] = [
            "id": id,
            "itemName": nameTextField.text ?? "",
            "resume": resumeTextField.text ?? "",
            "totalProgress": Int(totalProgressTextField.text ?? "") ?? 100,
            "color": Int(colorTextField.text ?? "") ?? 0
        ]
        itemTable.insert(item: JSON(insertValue))
        
        if delegate != nil {
            delegate!.reloadData()
        }
        
        self.dismiss()
    }

}

