//
//  FontPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/3.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSFontPage: UIViewController {
    
    let timerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 设置字体
        timerLabel.set(superview: view, text: "00:00")
        timerLabel.setStyle80ptFFF80ThinCenter()
        timerLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 80)
        timerLabel.setFrame(left: 20, top: 20, right: 20, height: 100)
        
        // 获取字族内所有字体名称
        let fontArray = UIFont.fontNames(forFamilyName: "Helvetica Neue")
        print(fontArray)
        
    }
    
    
}

