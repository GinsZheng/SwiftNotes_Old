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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        datePicker.set(superview: view)
        datePicker.setFrame(left: 0, top: 0, width: kScreenWidth, height: 215)
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.calendar = .current
        
        
        
        datePicker2.set(superview: view)
        datePicker2.setFrame(left: 0, bottom: kNavBarHeight + kBottomSafeAreaHeight, width: kScreenWidth, height: 215)
        //设置tag(可通过tag来获取其对象)
        datePicker2.tag = 1
        //更改地区文字
        datePicker2.locale = Locale(identifier: "zh_CN")
        //设置显示模式为日期时间
        datePicker2.datePickerMode = .date
        //设置最小值为现在
        datePicker2.minimumDate = Date()
        //设置最大值为现在时间往后三天以内
        datePicker2.maximumDate = Date(timeInterval:3*24*60*60,since:Date())
        //设置文字颜色
        datePicker2.setValue(UIColor.hex(c222), forKey: "textColor")
        
        //添加确定按钮
        let button = UIButton()
        button.set(superview: view, target: self, action: #selector(getValue))
        button.setStyleSolidBtn(title: "打印时间")
        button.setFrame(left: 20, top: 235, right: 20, height: 56)
        
    }
    
    @objc func getValue() {
        
        let datePicker2 = self.view.viewWithTag(1)as! UIDatePicker//通过tag获取datePicker对象
        let date = datePicker2.date//获取选定的值
        //初始化日期格式化对象
        let dateFormatter = DateFormatter()
        //设置日期格式化对象的具体格式
        dateFormatter.dateFormat = "yyyy/M/d HH:mm"
        //将选定的值转换为string格式以设定格式输出
        let dateAndTime = dateFormatter.string(from: date)
        print(dateAndTime)
    }
    
}

