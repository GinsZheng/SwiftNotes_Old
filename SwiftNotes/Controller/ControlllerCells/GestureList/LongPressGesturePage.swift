//
//  LongPressGesturePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSLongPressGesturePage: UIViewController {
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLongPress()
    }
    
    
    // MARK: - func
    
    func setupLongPress() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture(_:)))
        view.addGestureRecognizer(longPress)
    }
    
    
    // MARK: - @objc func

    @objc func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        if sender.state != .began {
            return
        }
        
        CSToast.showCenterWithText("已长按")
    }
    
}



/*
 手势状态：.state
 -> 手势状态有：
 -> case possible = 0
 -> case began = 1      开始
 -> case changed = 2    改变
 -> case ended = 3      结束
 -> case cancelled = 4  取消
 -> case failed = 5     失败
 -> recognized
 */
