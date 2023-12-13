//
//  DatePickerPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class DatePickerPage: UIViewController {
    
    let datePicker = UIDatePicker() // 常规用法
    let datePicker2 = UIDatePicker() // 尽可能多的属性
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        datePicker.setup(superview: view)
        datePicker.setFrame(centerX: view.centerX, top: 0, width: 320, height: 215)
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        datePicker2.setup(superview: view)
        datePicker2.setFrame(centerX: view.centerX, top: 300, width: 320, height: 215)
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
        if #available(iOS 13.4, *) {
            datePicker2.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        // 确定按钮
        let button = UIButton()
        button.setup(superview: view, target: self, action: #selector(getValue))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "打印时间")
        button.setFrame(left: 20, top: 235, right: 20, height: 56)
        
    }
    
    
    // MARK: - @objc func
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
 zh-CN 华 - 中国
 zh-CHS 华 - 简体 24小时制
 zh-SG 华 -新加坡
 zh-TW 华 -台湾
 zh-CHT 华 - 繁体
 
 en 英国
 en-GB 英国 - 英国
 en-US 英国 - 美国
 */


/*
 Picker中的宽高：
 1. 使用frame时不能更改其尺寸，且尺寸必须设为：width: 320, height: 215，否则布局会出错(和UISwitch类似)
 2. 如果想修改尺寸，可以用Auto Layout，以下是一个写在 viewDidLoad 中的将宽度设为屏幕宽度的做法：
 NSLayoutConstraint.activate([
 durationPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor), // 左边与屏幕左边对齐
 durationPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor), // 右边与屏幕右边对齐
 durationPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor), // 垂直居中
 ])
 
 */

