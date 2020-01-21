//
//  TextViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TextViewPage: UIViewController {
     
     let textView = UITextView()
     let textViewWitoutInteraction = UITextView()
     
     override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = UIColor.white
          
          
          textViewWitoutInteraction.set(superview: view, text: "在在在在在在在在在", maxLines: 0)
          textViewWitoutInteraction.setFontStyle(size: 100, color: c222)
          textViewWitoutInteraction.setFrame(left: 20, top: 20, right: 20, height: 420)
          textViewWitoutInteraction.setBackgroundColor(color: cBlue_2C9EFF_13)
          
          
     }
     
     
}

