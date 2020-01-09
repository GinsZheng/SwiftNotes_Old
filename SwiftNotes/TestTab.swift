//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestTab: UIViewController {
    
    
    let label = UILabel()
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.set(superview: view, text: "在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在")
        label.setFontStyle(size: 20, color: cBlue_2C9EFF) // 文字要先设字号再布局
        label.setFrame(left: 20, top: 100, width: kScreenWidth - 40, height: label.getTextHeight(withWidth: kScreenWidth - 40))
        label.setBackgroundColor(color: cCCC)
        
        
        textView.set(superview: view, text: "在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在", maxLines: 0)
        textView.setFontStyle(size: 20, color: c222)
        textView.setFrame(left: 20, top: 400, width: kScreenWidth - 40, height: 28*3)
        textView.setBackgroundColor(color: cCCC)
        textView.isUserInteractionEnabled = false
        
    }
    
    
}






//
//@IBDesignable class PaddingLabel: UILabel {
//
//    @IBInspectable var topInset: CGFloat = 30
//    @IBInspectable var bottomInset: CGFloat = 30
//    @IBInspectable var leftInset: CGFloat = 0.0
//    @IBInspectable var rightInset: CGFloat = 0.0
//
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: rect.inset(by: insets))
//    }
//
//    override var intrinsicContentSize: CGSize {
//        let size = super.intrinsicContentSize
//        return CGSize(width: size.width + leftInset + rightInset,
//                      height: size.height + topInset + bottomInset)
//    }
//}
