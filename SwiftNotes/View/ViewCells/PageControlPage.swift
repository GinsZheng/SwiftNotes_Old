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
        pageControl.set(superview: view)
        pageControl.setFrame(left: 50, top: 20, right: 50, height: 44)
        pageControl.numberOfPages = 5
        pageControl.hidesForSinglePage = true
    }
    
    
}

