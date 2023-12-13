//
//  DateFormatterPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/9/13.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class DateFormatterPage: UIViewController {
    
    
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)

        let timestamp = 1672678923 // 时间戮 (2023-01-3 01:02:03)
        
        // 创建一个Date对象，从时间戳中获取日期和时间
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))

        // 创建一个DateFormatter对象
        let dateFormatter = DateFormatter()
        // 设置本地化语言和地区
        dateFormatter.locale = Locale.current
        // 设置日期和时间样式。dateStyle 与 timeStyle 如果不写，将为空，即可以只写dateStyle以只输出日期
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long

        // 使用DateFormatter来格式化日期和时间
        let formattedDate = dateFormatter.string(from: date)
        print("格式化的日期和时间：\(formattedDate)")
        
        // 显示在屏幕上
        let label = UILabel()
        label.setup(superview: view, text: formattedDate)
        label.setStyle17pt222Med()
        label.setFrame(left: 20, top: 100)
        
    }
    
    
    // MARK: - 代理方法
    
    
    
    
    // MARK: - @objc func
    
    
    
}


