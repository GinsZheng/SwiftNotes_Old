//
//  LongPressCopyPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/8/3.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class LongPressCopyPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.set(superview: view, text: "heheda")
        label.makeConstraints(left: 20, top: 100, width: 300, height: 44)
        
        
    }
    
    
}

