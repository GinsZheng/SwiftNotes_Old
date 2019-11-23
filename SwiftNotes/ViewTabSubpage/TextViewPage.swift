//
//  TextViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TextViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let textView = UITextView()
        textView.set(superview: view)
        textView.makeConstraints(left: 20, top: 100, width: kScreenWidth - 40, height: 300)
        textView.text = "Hehedahehedahehedahehedahehedahehedahehedahehedahehedahehedaheheda"
        textView.setFontStyle(color: "222", size: 17)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        
        textView.clearsOnInsertion = true
        textView.backgroundColor = UIColor.hex(cF5F6F8)

        
    }
    
    
}

