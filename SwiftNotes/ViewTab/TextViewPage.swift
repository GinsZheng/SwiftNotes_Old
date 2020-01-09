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
          
          textView.set(superview: view)
          textView.setFrame(left: 20, top: 100, width: kScreenWidth - 40, height: 100)
          textView.text = "Hehedahehedahehedahehedahehedahehedahehedahehedahehedahehedaheheda"
          textView.setFontStyle(size: 17, color: "222")
          textView.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
          textView.clearsOnInsertion = true
          textView.backgroundColor = UIColor.hex(cF5F6F8)
          
          textViewWitoutInteraction.set(superview: view, text: "在在在在在在在在在", maxLines: 0)
          textViewWitoutInteraction.setFontStyle(size: 400, color: c222)
          textViewWitoutInteraction.setFrame(left: 20, top: 240, right: 20, height: 10)
          
          
     }
     
     
}

