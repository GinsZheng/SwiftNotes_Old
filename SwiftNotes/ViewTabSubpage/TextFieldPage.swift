//
//  TextFieldPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TextFieldPage: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let textField = UITextField()
        textField.set(parentView: view, placeholder: "Input something")
        textField.makeConstraintsToLeftTop(left: 20, top: 100, width: 335, height: 44)
        textField.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        return true
    }
}

