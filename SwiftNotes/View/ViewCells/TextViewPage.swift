//
//  CSTextViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSTextViewPage: UIViewController, UITextViewDelegate {
     
     let textView = UITextView()
     let textViewWithInteraction = UITextView()
     
     override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = UIColor.white
          
          textView.set(superview: view, text: "美国或将推出中东和平方案巴以危机出路何在何在何在在在", maxLines: 3)
          textView.setFontStyle(size: 17, color: c222)
          textView.setFrame(left: 20, top: 20, width: 139, height: 72)
          textView.setBackgroundColor(color: cF0F1F3)
          
          
          // MARK: - 视为多行TextField，可监听文本改变
          /*
           需要3步：
           1.VC类继承UITextViewDelegate
           2.textViewWithInteraction.delegate = self
           3.把事件写进固有代理方法⌜func textViewDidChange(_ textView: UITextView) {}⌟
           */
          textViewWithInteraction.set(superview: view, text: "在在在在在在在在在", maxLines: 0, interaction: true)
          textViewWithInteraction.setFontStyle(size: 100, color: c222, lineHeight: 1.4)
          textViewWithInteraction.setFrame(left: 20, top: 220, right: 20, height: 420)
          textViewWithInteraction.setBackgroundColor(color: cBlue_5393FF_13)
          textViewWithInteraction.delegate = self
          
     }
     
     // 监听到文本改变时，要做什么操作
     func textViewDidChange(_ textView: UITextView) {
          if textView.text.lengthOfBytes(using: .utf8) > 0 {
               //文本框内有文字个数大于0 进行相应操作
               print("非空")
          }else{
               //文本框内有文字个数等于0 进行相应操作
               print("空")
          }
     }
}
