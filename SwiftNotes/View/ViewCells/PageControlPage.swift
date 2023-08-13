//
//  CSPageControlPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSPageControlPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hex(c999)
        
        let pageControl = UIPageControl()
        pageControl.set(superview: view, numberOfPages: 3)
        pageControl.setFrame(left: 0, top: 0, width: kScreenWidth, height: 100)
        
    }
    

}

