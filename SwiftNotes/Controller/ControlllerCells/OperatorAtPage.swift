//
//  OperatorAtPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/8.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSOperatorAtPage: UIViewController {
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        func1()
    }
    
    
    // MARK: - func
    // 当返回值没有用到时，回避警告：Result of call to 'func1()' is unused
    @discardableResult
    func func1() -> Int {
        return 123
    }
    
}

