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
    
    let itemTable = CSItemsTable()
    
    weak var delegate: CSReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navPresent.setTitleLabel(superview: view, title: "Insert")
        navPresent.setCloseButton(superview: view, target: self, action: #selector(dismissPage))
        
        nameTextField.set(superview: view, placeholder: "itemName", delegate: self)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: navPresent.titleLabel.bottom + 20, right: 20, height: 48)
        
        resumeTextField.set(superview: view, placeholder: "resume", delegate: self)
        resumeTextField.setStyleOneLineTextField()
        resumeTextField.setFrame(left: 20, top: nameTextField.bottom + 20, right: 20, height: 48)
        
        totalProgressTextField.set(superview: view, placeholder: "totalProgress", delegate: self)
        totalProgressTextField.setStyleOneLineTextField()
        totalProgressTextField.setFrame(left: 20, top: resumeTextField.bottom + 20, right: 20, height: 48)
        
        colorTextField.set(superview: view, placeholder: "color(Int)", delegate: self)
        colorTextField.setStyleOneLineTextField()
        colorTextField.setFrame(left: 20, top: totalProgressTextField.bottom + 20, right: 20, height: 48)
        
        addingButton.set(superview: view, target: self, action: #selector(addItem))
        addingButton.setStyleSolidBtn(title: "Insert")
        addingButton.setFrame(left: 20, top: colorTextField.bottom + 20, right: 20, height: 48)
    }
    
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        print("释放")
    }
    
}

