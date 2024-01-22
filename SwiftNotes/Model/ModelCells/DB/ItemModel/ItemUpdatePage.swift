//
//  ItemUpdatePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//

class ItemEditPage: ItemBasePage {
    override func viewDidLoad() {
        isEditMode = true
        super.viewDidLoad()
        print("编辑")
    }

    override func handleAction() {
        // 实现更新操作的逻辑
        let updatedRow = Models.Item(
            itemName: self.nameTextField.text ?? "",
            resume: self.resumeTextField.text ?? "",
            totalProgress: Int(self.totalProgressTextField.text ?? "") ?? 100,
            color: Int(self.colorTextField.text ?? "") ?? 0
        )
        print("hey")
        DB.shared.update(table: self.itemTable, id: itemModel?.id ?? 0, model: updatedRow)
        self.onCompleted?()
        self.dismiss()
    }
}
