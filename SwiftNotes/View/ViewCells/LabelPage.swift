//
//  LabelPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class LabelPage: UIViewController {
    
    let label = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: "在在在在在在在在在在在在在在在在")
        label.setFontStyle(size: 24, color: c222)
        label.setFrame(left: 20, top: 20, width: 384)
        label.setBackgroundColor(color: cF0F1F3)
        
        label2.set(superview: view, text: "在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在")
        label2.setFontStyle(size: 12, color: c222)
        label2.setFrame(left: 20, top: 50, width: 384)
        label2.setBackgroundColor(color: cF0F1F3)
        
        label3.set(superview: view, text: "在在在在")
        label3.setFontStyle(size: 96, color: c222)
        label3.setFrame(left: 20, top: 300, width: 384)
        label3.setBackgroundColor(color: cF0F1F3)
        
        label4.set(superview: view, text: "在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在")
        label4.setFontStyle(size: 20, color: c222)
        label4.setFrame(left: 20, top: 500, width: 384)
        label4.setBackgroundColor(color: cF0F1F3)
        label4.adjustsFontSizeToFitWidth = true
        label4.minimumScaleFactor = 0.7
        
        label5.set(superview: view, text: "特朗普威胁世行不该给富起来的中国贷款二在")
        label5.numberOfLines = 3
        label5.setFrame(left: 20, top: label4.bottom + 20, right: 20, height: 60)
        label5.setBackgroundColor(color: cF0F1F3)
        
    }
    
}

