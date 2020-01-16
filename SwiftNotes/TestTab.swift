//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestTab: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        self.title = "Test"
        
        let label = UILabel()
        label.set(superview: view)
        label.setBackgroundColor(color: cBlue_2C9EFF)
        label.setFrame(left: 20, top: 20, right: 20)

        let string = "点击注册按钮,即表示您已同意隐私条款和服务协议"
        let ranStr = "同意"
        let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:string)
        let str = NSString(string: string)
        let theRange = str.range(of: ranStr)
        attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: theRange)
        attrstring.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14), range: theRange)
        label.attributedText = attrstring
        
    }

}
