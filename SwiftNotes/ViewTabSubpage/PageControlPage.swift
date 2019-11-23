//
//  PageControlPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class PageControlPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.hex("999")
        
        let pageControl = UIPageControl()
        view.addSubview(pageControl)
        pageControl.makeConstraints(left: 50, top: 100, right: 50, height: 44)
        pageControl.numberOfPages = 5
        pageControl.hidesForSinglePage = true
    }
    
    
}

