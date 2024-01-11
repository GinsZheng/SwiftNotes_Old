//
//  DictionaryPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/12.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSDictionaryPage: UIViewController {
    
    let dict = [
        "a": "alpha",
        "b": "beta",
        "g": "gamma"
    ]
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 设置key默认值。不设置时，如果没有此key，会返回nil
        let delta = dict["d", default: "Unknown"]
        print(delta)
        
        
    }
    
    
}

