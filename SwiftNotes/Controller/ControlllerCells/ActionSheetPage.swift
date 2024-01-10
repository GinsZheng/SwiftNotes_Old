//
//  ActionSheetPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class ActionSheetPage: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setBackgroundColor(color: cFFF)
        
        setupActionSheet()
    }
    
    
    // MARK: - func
    func setupActionSheet() {
        actionSheet(actionsTitle: ["返回", "跳转", "打印"], actionsStyle: [.default, .default, .destructive], actionsHandler: [
            { (x) in
                self.pop()
            },
            { (x) in
                self.push(targetVC: CSGeneralSubpage())
            },
            { (x) in
                print("点了打印选项")
            }])
    }
    
}

