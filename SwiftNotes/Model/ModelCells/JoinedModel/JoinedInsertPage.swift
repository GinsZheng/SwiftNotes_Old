//
//  JoinedInsertPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/15.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite

class CSJoinedInsertPage: UIViewController, UITextFieldDelegate {
    
    let navPresent = UIPresentNav()
    
    let currentProgressTextField = UITextField()
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let itemIdTextField = UITextField()
    let insertButton = UIButton()
    
    let table = CSJoinedTable()
    
    weak var delegate: CSReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navPresent.setTitleLabel(superview: view, title: "Insert")
        navPresent.setCloseButton(superview: view, target: self, action: #selector(dismissPage))
        
        currentProgressTextField.set(superview: view, placeholder: "currentProgress", delegate: self)
        currentProgressTextField.setStyleOneLineTextField()
        currentProgressTextField.setFrame(left: 20, top: navPresent.titleLabel.bottom + 20, right: 20, height: 48)
        
        startTimeTextField.set(superview: view, placeholder: "startTime", delegate: self)
        startTimeTextField.setStyleOneLineTextField()
        startTimeTextField.setFrame(left: 20, top: currentProgressTextField.bottom + 20, right: 20, height: 48)
        
        endTimeTextField.set(superview: view, placeholder: "entTime", delegate: self)
        endTimeTextField.setStyleOneLineTextField()
        endTimeTextField.setFrame(left: 20, top: startTimeTextField.bottom + 20, right: 20, height: 48)
        
        itemIdTextField.set(superview: view, placeholder: "itemId", delegate: self)
        itemIdTextField.setStyleOneLineTextField()
        itemIdTextField.setFrame(left: 20, top: endTimeTextField.bottom + 20, right: 20, height: 48)
        
        insertButton.set(superview: view, target: self, action: #selector(addProgress))
        insertButton.setStyleSolidBtn(title: "Insert")
        insertButton.setFrame(left: 20, top: itemIdTextField.bottom + 20, right: 20, height: 48)
    }
    
    
    @objc func dismissPage() {
        self.dismiss()
    }
    
    // 建立委托
    @objc func addProgress() {
        let id = table.getNextId()
        let insertValue: [String: Any] = [
            "id": id,
            "currentProgress": Int(currentProgressTextField.text ?? "") ?? 0,
            "startTime": Int(startTimeTextField.text ?? "") ?? 0,
            "entTime": Int(endTimeTextField.text ?? "") ?? 0,
            "itemId": Int(itemIdTextField.text ?? "") ?? 0,
//            "createTime": 1000000
        ]
        table.insert(item: JSON(insertValue))
        
        if delegate != nil {
            delegate!.reloadItemsList()
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

