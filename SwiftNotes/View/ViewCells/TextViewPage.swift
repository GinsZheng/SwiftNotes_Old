//
//  CSTextViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSTextViewPage: UIViewController {
     
     let textView = UITextView()
     let textViewWitoutInteraction = UITextView()
     
     override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = UIColor.white
          
          textView.set(superview: view, text: "美国或将推出中东和平方案巴以危机出路何在何在何在在在", maxLines: 3)
          textView.setFontStyle(size: 17, color: c222)
          textView.setFrame(left: 20, top: 20, width: 139, height: 72)
          textView.setBackgroundColor(color: cF0F1F3)
          
          textViewWitoutInteraction.set(superview: view, text: "在在在在在在在在在", maxLines: 0, interaction: true)
          textViewWitoutInteraction.setFontStyle(size: 100, color: c222, lineHeight: 1.4)
          textViewWitoutInteraction.setFrame(left: 20, top: 220, right: 20, height: 420)
          textViewWitoutInteraction.setBackgroundColor(color: cBlue_5393FF_13)
          
          
     }
     
     
}

