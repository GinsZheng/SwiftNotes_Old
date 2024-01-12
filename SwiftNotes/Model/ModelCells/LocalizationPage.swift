//
//  Localization.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/27.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit
import Localize_Swift

class LocalizationPage: UIViewController {
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        // 固定文案
        let fixText = "已完成".localized()
        print(fixText)
        
        // 带1个变量文案
        let timeCount = 3
        let oneVarText = "定时播报  %@个时间点".localizedFormat(String(timeCount))
        print(oneVarText)
        
        // 带多个变量文案(按顺序写)
        let time = "18:00"
        let repeatDays = "工作日"
        let multiVarText = "定时播报  %@ %@".localizedFormat(time, repeatDays)
        print(multiVarText)
        
        /*
         注：
         1. 如果key输入错误，会直接返回key作为字符串
         2. 如果值类型错误，会崩溃(危险)，我的做法是所有文案都输出为⌜%@⌟，在localizedFormat中转化为String(好处有2：1. 简化翻译文档的输入和查找 2. 如果出错，不必去改翻译文档，直接在代码中改，比较高效)
         */
        
    }
    
    
    // MARK: - 代理方法
    
    
    
    // MARK: - @objc func
    
    
    
}


