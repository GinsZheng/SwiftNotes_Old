//
//  CSDatePicker.swift
//  SnailProgress
//
//  Created by GinsMac on 2020/3/8.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSDatePicker {
    
    let mask = UIButton()
    let pickerBg = UIView()
    let datePicker = UIDatePicker()
    let pickerConfirmBar = UIView()
    let cancelButton = UIButton()
    let confirmButton = UIButton()
    
    var timeStamp = 0.0
    var iDateFormat = "yyyy/M/d HH:mm"
    
    var iLabel = UILabel()
    var iTextField = UITextField()
    var iTextView = UITextView()
    
    
    func setBasicAttribute(target: Any?, confirmAction: Selector) {
        UIApplication.shared.windows[0].addSubview(mask)
        mask.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        mask.setBackgroundColor(color: cNoColor)
        mask.setFrame(allEdges: 0)
        
        pickerBg.set(superview: mask, backgroundColor: cFFF)
        pickerBg.setFrame(left: 0, bottom: -(kBottomBarHeight + 215 + 44), width: kScreenWidth, height: kBottomBarHeight + 215 + 44)
        
        datePicker.set(superview: pickerBg, backgroundColor: cFFF)
        datePicker.setFrame(left: 0, bottom: kBottomBarHeight, width: kScreenWidth, height: 215)
        datePicker.locale = Locale(identifier: "zh_CN")
        
        pickerConfirmBar.set(superview: pickerBg, backgroundColor: cFFF)
        pickerConfirmBar.setFrame(left: 0, bottom: datePicker.height + kBottomBarHeight, width: kScreenWidth, height: 44)

        cancelButton.set(superview: pickerConfirmBar, target: self, action: #selector(cancel))
        cancelButton.setStyleWordButton(title: "取消")
        cancelButton.setFrame(left: 20, centerY: pickerConfirmBar.height/2, width: 44, height: 44)

        confirmButton.set(superview: pickerConfirmBar, target: target, action: confirmAction)
        confirmButton.setStyleWordButton(title: "确定")
        confirmButton.setFrame(right: 20, centerY: pickerConfirmBar.height/2, width: 44, height: 44)
        
        UIView.animate(withDuration: 0.3) {
            self.mask.backgroundColor = .hex(c04040F_40_mask)
            self.pickerBg.bottom = 0
        }
    }
    
    // 设置点击“确定”后，要改变的控件的文本
    func setText(_ label: UILabel, dateFormat: String) {
        iLabel = label
        iDateFormat = dateFormat
    }
    
    func setText(_ textField: UITextField, dateFormat: String = "yyyy/M/d HH:mm") {
        iTextField = textField
        iDateFormat = dateFormat
    }
    
    func setText(_ textView: UITextView, dateFormat: String) {
        iTextView = textView
        iDateFormat = dateFormat
    }
    
    func getTimeStamp() -> Double {
        return timeStamp
    }
    
    
    @objc func cancel() {
        UIView.animate(withDuration: 0.3) {
            self.mask.backgroundColor = .hex(cNoColor)
            self.pickerBg.bottom = -(kBottomBarHeight + 215 + 44)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute:{
            self.mask.removeFromSuperview()
        })
    }
    
    func confirm() {
        UIView.animate(withDuration: 0.3) {
            self.mask.backgroundColor = .hex(cNoColor)
            self.pickerBg.bottom = -(kBottomBarHeight + 215 + 44)
        }
        
        timeStamp = getTimeStampWithDate(date: datePicker.date)
        iTextField.text = getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: iDateFormat)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute:{
            self.mask.removeFromSuperview()
        })
    }
    
}

