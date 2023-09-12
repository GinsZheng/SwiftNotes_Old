//
//  CSPickerViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSPickerViewPage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerData = ["今天", "昨天", "前天"]
    
    let pickerView = UIPickerView()
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        pickerView.set(superview: view, delegate: self, dataSource: self)
        pickerView.setFrame(left: 10, top: 100, width: kScreenWidth - 20, height: 215)
    }
    
    
    // MARK: - PickerView 代理
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // 标题
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // 行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }
    
}
