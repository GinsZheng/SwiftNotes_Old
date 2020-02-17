//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestTab: UIViewController {

    let pickerView = UIPickerView()
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        self.title = "Test"
        
        // 时间转时间戳
        //获取当前时间
        let now = NSDate()
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print("当前日期时间：\(dformatter.string(from: now as Date))")
        
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        print("当前时间的时间戳：\(timeStamp)")
        
        
        // 时间戳转时间
        //时间戳
        let timeStamp2 = 1463637809
        print("时间戳：\(timeStamp)")
        
        //转换为时间
        let timeInterval2:TimeInterval = TimeInterval(timeStamp2)
        let date = NSDate(timeIntervalSince1970: timeInterval2)
        
        //格式话输出
        let dformatter2 = DateFormatter()
        dformatter2.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print("对应的日期时间：\(dformatter.string(from: date as Date))")
        
        // 打印
        print("viewDidAppear")
    }
    
    

}

