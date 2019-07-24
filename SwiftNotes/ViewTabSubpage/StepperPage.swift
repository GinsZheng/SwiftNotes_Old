//
//  StepperPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class StepperPage: UIViewController {
    
    @objc func printValue(_ stepper: UIStepper) {
        print(stepper.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let stepper = UIStepper()
        view.addSubview(stepper)
        stepper.makeConstraints(left: 20, top: 100, width: 200, height: 36)
        stepper.addTarget(self, action: #selector(printValue(_:)), for: .touchUpInside)
        
    }
    
    
}

