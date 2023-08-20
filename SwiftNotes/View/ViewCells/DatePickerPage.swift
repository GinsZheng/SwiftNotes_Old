//
//  CSDatePickerPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSDatePickerPage: UIViewController {
    
    let datePicker = UIDatePicker() // 常规用法
    let datePicker2 = UIDatePicker() // 尽可能多的属性
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        datePicker.set(superview: view)
        datePicker.setFrame(left: 0, top: 0, width: kScreenWidth, height: 215)
        datePicker.locale = Locale(identifier: "zh_CN")
        
        
        datePicker2.set(superview: view)
        datePicker2.setFrame(left: 0, bottom: kNavBarHeight + kBottomBarHeight, width: kScreenWidth, height: 215)
        // 设置tag(可通过tag来获取其对象)
        datePicker2.tag = 1
        // 更改地区文字
        datePicker2.locale = Locale(identifier: "zh-CHS") // 24小时制
        // 设置显示模式为日期时间
        datePicker2.datePickerMode = .dateAndTime
        // 设置默认值
        datePicker2.setDate(Date(timeInterval:24*60*60,since:Date()), animated: true)
        // 设置最小值为现在.注：如果默认值超出最小/最大值，则设为最小/最大值
        datePicker2.minimumDate = Date()
        // 设置最大值为现在时间往后三天以内
        datePicker2.maximumDate = Date(timeInterval:3*24*60*60,since:Date())
        // 设置文字颜色
        datePicker2.setValue(UIColor.hex(c222), forKey: "textColor")
        datePicker2.calendar = .current
        
        

        
        
        // 添加确定按钮
        let button = UIButton()
        button.set(superview: view, target: self, action: #selector(getValue))
        button.setStyleSolid17ptWhiteThemeButton(title: "打印时间")
        button.setFrame(left: 20, top: 235, right: 20, height: 56)
        
        
    }
    
    @objc func getValue() {
        
        let datePicker2 = self.view.viewWithTag(1)as! UIDatePicker // 通过tag获取datePicker对象
        let date = datePicker2.date // 获取选定的值
        // 初始化日期格式化对象
        let dateFormatter = DateFormatter()
        // 设置日期格式化对象的具体格式
        dateFormatter.dateFormat = "yyyy/M/d HH:mm"
        // 将选定的值转换为string格式以设定格式输出
        let dateAndTime = dateFormatter.string(from: date)
        print(dateAndTime)
    }
    
}

/*
 地区：
 zh-HK 华 - 香港的 SAR
 zh-MO 华 - 澳门的 SAR
 zh-CN 华 -中国
 zh-CHS 华 (单一化) 24小时制
 zh-SG 华 -新加坡
 zh-TW 华 -台湾
 zh-CHT 华 (传统的)
 
 en 英国
 en-GB 英国 - 英国
 en-US 英国 - 美国
 */
