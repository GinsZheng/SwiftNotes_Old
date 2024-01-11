//
//  PageControlPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class PageControlPage: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .hex(c999)
        
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        let pageControl = UIPageControl()
        pageControl.setup(superview: view, numberOfPages: 3)
        pageControl.setFrame(left: 0, top: 0, width: kScreenWidth, height: 100)
    }

}

