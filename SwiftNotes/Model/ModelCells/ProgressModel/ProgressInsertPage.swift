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

class CSProgressInsertPage: UIViewController, UITextFieldDelegate {
    
    let table = ProgressTable()
    
    let navPresent = CSPresentNav()
    let currentProgressTextField = UITextField()
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let itemIdTextField = UITextField()
    let insertButton = UIButton()
    
    weak var delegate: CSReloadDelegate?
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navPresent.setTitleLabel(superview: view, title: "Insert")
        navPresent.setCloseButton(superview: view, target: self, action: #selector(dismissPage))
        
        currentProgressTextField.setup(superview: view, placeholder: "currentProgress", delegate: self)
        currentProgressTextField.setStyleOneLineTextField()
        currentProgressTextField.setFrame(left: 20, top: navPresent.titleLabel.bottom + 20, right: 20, height: 48)
        
        startTimeTextField.setup(superview: view, placeholder: "startTime", delegate: self)
        startTimeTextField.setStyleOneLineTextField()
        startTimeTextField.setFrame(left: 20, top: currentProgressTextField.bottom + 20, right: 20, height: 48)
        
        endTimeTextField.setup(superview: view, placeholder: "entTime", delegate: self)
        endTimeTextField.setStyleOneLineTextField()
        endTimeTextField.setFrame(left: 20, top: startTimeTextField.bottom + 20, right: 20, height: 48)
        
        itemIdTextField.setup(superview: view, placeholder: "itemId", delegate: self)
        itemIdTextField.setStyleOneLineTextField()
        itemIdTextField.setFrame(left: 20, top: endTimeTextField.bottom + 20, right: 20, height: 48)
        
        insertButton.setup(superview: view, target: self, action: #selector(addProgress))
        insertButton.setStyleSolid17ptFgWhiteThemeButton(title: "Insert")
        insertButton.setFrame(left: 20, top: itemIdTextField.bottom + 20, right: 20, height: 48)
    }
    
    
    @objc func dismissPage() {
        self.dismiss()
    }
    
    // 建立委托
    @objc func addProgress() {
        let insertValue: [String: Any] = [
            "id": table.getNextId(),
            "currentProgress": Int(currentProgressTextField.text ?? "10") ?? 110,
            "startTime": Int(startTimeTextField.text ?? "") ?? 0,
            "entTime": Int(endTimeTextField.text ?? "") ?? 0,
            "itemId": Int(itemIdTextField.text ?? "") ?? 0,
        ]
        print(table.getNextId())
        print(Int(currentProgressTextField.text ?? "10") ?? 110)
        print(Int(startTimeTextField.text ?? "") ?? 0)
        print(Int(endTimeTextField.text ?? "") ?? 0)
        print(Int(itemIdTextField.text ?? "") ?? 0)
        
        table.insert(item: JSON(insertValue))
        
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

