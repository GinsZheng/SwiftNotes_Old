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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        pickerView.set(superview: view, delegate: self, dataSource: self)
        pickerView.setFrame(left: 10, top: 100, width: kScreenWidth - 20, height: 215)
    }
    
    
    // MARK: - PickerView 代理
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }
    
}
