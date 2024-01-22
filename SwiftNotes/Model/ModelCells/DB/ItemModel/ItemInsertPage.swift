//
//  ItemInsertPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/21.
//  Copyright © 2024 GinsMac. All rights reserved.
//

class ItemInsertPage: ItemBasePage {
    override func viewDidLoad() {
        super.viewDidLoad()
        isEditMode = false
    }
    
    override func handleAction() {
        // 实现添加操作的逻辑
        let newRow = Models.Item(
            itemName: self.nameTextField.text ?? "",
            resume: self.resumeTextField.text ?? "",
            totalProgress: Int(self.totalProgressTextField.text ?? "") ?? 100,
            color: Int(self.colorTextField.text ?? "") ?? 0
        )
        DB.shared.insert(table: self.itemTable, model: newRow)
        self.onCompleted?()
        self.dismiss()
    }
    
}
