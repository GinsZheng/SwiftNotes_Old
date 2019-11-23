//
//  LongPressCopyPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/8/3.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class MenuControllerPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = InteractiveUILabel()
        label.set(superview: view, text: "heheda")
        label.setFontStyle(color: c222, size: 17)
        label.makeConstraints(left: 20, top: 100)
        
        
    }
    
}

class InteractiveUILabel: UILabel {
    override var canBecomeFirstResponder: Bool { return true }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    // storyboard或xib创建控件的时候有效
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressLabel)))
    }
    
    @objc func longPressLabel() {
        becomeFirstResponder()
        
        let menu = UIMenuController.shared //创建菜单控件器单例
        let copy = UIMenuItem(title: "复制", action: #selector(copyText))
        let paste = UIMenuItem(title: "粘贴", action: #selector(pasteText))
        
        if UIPasteboard.general.hasStrings {
            menu.menuItems = [copy, paste]
        } else {
            menu.menuItems = [copy]
        }
        
        menu.setTargetRect(bounds, in: self)
        menu.setMenuVisible(true, animated: true)
    }
    
    @objc func copyText() {
        UIPasteboard.general.string = self.text
    }
    
    @objc func pasteText() {
        self.text = UIPasteboard.general.string
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copyText) {
            return true
        }
        return false
    }

}
