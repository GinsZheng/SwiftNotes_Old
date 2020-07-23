//
//  CustomControl.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/7/23.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

// UITextField
class CSNoPastingUITextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
         if action == #selector(UIResponderStandardEditActions.paste(_:)) {
             return false
         }
         return super.canPerformAction(action, withSender: sender)
    }
    
}

