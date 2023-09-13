//
//  DoublePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/12/9.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class DoublePage: UIViewController {
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let d1 = 3.0
        let d2 = 3.5
        
        print("向上取整，返回依然为Double ➤ d1:\(ceil(d1)), d2:\(ceil(d2)))")
        
        print("向下取整，返回依然为Double ➤ d1:\(floor(d1)), d2:\(floor(d2)))")
        
    }
    
    
}

