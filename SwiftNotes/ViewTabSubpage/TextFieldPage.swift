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
        textField.set(superview: view, placeholder: "Input something")
        textField.makeConstraints(left: 20, top: 100, width: kScreenWidth, height: 44)
        textField.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        return true
    }
}

