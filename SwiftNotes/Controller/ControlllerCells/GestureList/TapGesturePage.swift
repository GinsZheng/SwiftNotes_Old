//
//  TapGesturePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/18.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSTapGesturePage: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        setupTapGesture()
    }
    
    // MARK: - func
    func setupTapGesture() {
        // 单击
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapGesture)
        
        // 双击
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        // 双击失败时执行单击
        tapGesture.require(toFail: doubleTapGesture)
        
        // 双指单击
        let doubleTouchesGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTouches))
        doubleTouchesGesture.numberOfTouchesRequired = 2
        view.addGestureRecognizer(doubleTouchesGesture)
    }
    
    // MARK: - @objc func
    @objc func tap() {
        CSToast.showCenterWithText("已单击")
    }
    
    @objc func doubleTap() {
        CSToast.showCenterWithText("已双击")
    }
    
    @objc func doubleTouches() {
        CSToast.showCenterWithText("已双指单击")
    }
}

