//
//  Test1VC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/24.
//  Copyright © 2023 GinsMac. All rights reserved.
//

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
        
        let customView = CustomView()
        customView.fetchDataClosure = {
            // 这里返回需要传递给CustomView的数据
            return "这里是需要的数据"
        }
    }
    
    
    // MARK: - 代理方法
    
    
    
    
    // MARK: - @objc func
    
    
    
    
}


class CustomView: UIView {
    // 定义一个闭包类型的属性，它返回一个字符串数据
    var fetchDataClosure: (() -> String)?
    
    func updateData() {
        // 在需要数据时调用闭包
        let data = fetchDataClosure?() ?? ""
        // 使用获取到的数据...
    }
}
