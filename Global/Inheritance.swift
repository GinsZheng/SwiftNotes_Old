//
//  Inheritance.swift
//  SnailProgress
//
//  Created by GinsMac on 2022/9/12.
//  Copyright © 2022 GinsMac. All rights reserved.
//

import UIKit

class CSEditableTextView: UITextView {
    /// 占位文字
    var placeholder: String = ""
    var placeholderColor: UIColor? = .lightGray
    var fontsize: CGFloat = 17
    var weight: UIFont.Weight = .regular
    var lineHeight: CGFloat = 1.4
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        // 设置默认字体
        self.font = UIFont.systemFont(ofSize: fontsize, weight: weight)
        // 使用通知监听文字改变
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        print("执行A")
        // 如果有文字,就直接返回,不需要画占位文字
        if self.hasText {
            return
        }
        
        // 属性
        let attrs: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: self.placeholderColor as Any, NSAttributedString.Key.font: self.font!]
        // 文字
        var rect1 = rect
        rect1.origin.x = 0
        rect1.origin.y = -0.5*self.fontsize*(self.lineHeight - 1.194)
        (self.placeholder as NSString).draw(in: rect1, withAttributes: attrs)
        
        print("执行B")
    }
    
    @objc func textDidChange(_ note: Notification) {
        // 会重新调用draw方法
        self.setNeedsDisplay()
    }
    
    func set(superview: UIView, placeholder: String, placeholderColor: String = c000_22, text: String? = nil,  maxLines: Int = 0, size: CGFloat = 17, textColor: String = cMainBlack, weight: UIFont.Weight = .regular, alignment: NSTextAlignment = .left, lineHeight: CGFloat = 1.4) {
        
        self.placeholder = placeholder
        self.placeholderColor = .hex(placeholderColor)
        self.text = text
        // self.isUserInteractionEnabled = true
        superview.addSubview(self)
        self.textContainer.maximumNumberOfLines = maxLines
        
        // self.setLineHeight(multiple: 2)
        
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = .hex(textColor)
        self.textAlignment = alignment
        self.textContainerInset = UIEdgeInsets(top: -0.5*size*(lineHeight - 1.194), left: -5, bottom: 0, right: -5)
        
        // 使用通知监听文字改变
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
}
