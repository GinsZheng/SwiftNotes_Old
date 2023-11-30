//
//  Test1VC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/24.
//  Copyright © 2023 GinsMac. All rights reserved.
//

/// 本页为使用闭包在ViewController和CustomView之前传递数据的示例
/// 视图控制器 (ViewController): 主要的控制器，它包含一个自定义视图
/// 自定义视图 (CustomView): 一个简单的视图，它有一个方法updateData，用于更新其显示的数据。
/// 数据传递：CustomView使用闭包从ViewController获取数据。

import UIKit

class Test1VC: UIViewController {
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let customView = ClosureCustomView(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        view.addSubview(customView)
        
        customView.fetchDataClosure = {
            return "Hello from ViewController"
        }
        
    }
    
}
