//
//  DataHandle.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/20.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSDataOperate: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // trim
        let trimingText = "  123  ".trimmingCharacters(in: .whitespaces)
        print(trimingText)
        
    }
    
    
}

