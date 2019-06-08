//
//  UITextFieldPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class UITextFieldPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let textField = createUITextField(parentView: view, placeholder: "I'm placeholder")
        textField.makeConstraintsToLeftTop(left: 20, top: 100, width: 335, height: 44)
    }
    
    
}
