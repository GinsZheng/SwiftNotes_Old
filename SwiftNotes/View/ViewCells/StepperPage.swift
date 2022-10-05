//
//  CSStepperPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSStepperPage: UIViewController {
    
    @objc func printValue(_ stepper: UIStepper) {
        print(stepper.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let stepper = UIStepper()
        stepper.set(superview: view, target: self, action: #selector(printValue(_:)))
        stepper.setFrame(left: 20, top: 20, width: 200, height: 36)
            
        
    }
    
    
}

