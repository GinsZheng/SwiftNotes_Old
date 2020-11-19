//
//  Decorator.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/7/31.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSDecoratorPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 有@discardableResult，会忽略函数结果未赋值的警告
        // 替代方案为： _ = testDiscardableResult()
        testDiscardableResult()
        
        let x = UILabel()
    }
    

    @discardableResult
    func testDiscardableResult() -> Int {
        return 1
    }
}

