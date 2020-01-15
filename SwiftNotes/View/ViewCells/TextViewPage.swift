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
          
          textView.set(superview: view, text: "Hehedahehedahehedahehedahehedahehedahehedahehedahehedahehedaheheda", maxLines: 2)
          textView.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 100)
          textView.setFontStyle(size: 17, color: "222")
          textView.clearsOnInsertion = true
          textView.backgroundColor = .hex(cF5F6F8)
          
          textViewWitoutInteraction.set(superview: view, text: "在在在在在在在在在", maxLines: 0)
          textViewWitoutInteraction.setFontStyle(size: 400, color: c222)
          textViewWitoutInteraction.setFrame(left: 20, top: 240, right: 20, height: 10)
          
          
     }
     
     
}

