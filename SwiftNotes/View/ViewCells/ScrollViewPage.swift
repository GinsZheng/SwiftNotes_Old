//
//  ScrollViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ScrollViewPage: UIViewController {
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        let scrollView = UIScrollView()
        scrollView.setup(superview: view)
        scrollView.setFrame(left: 0, top: 0, width: kScreenWidth, height: 400)
        scrollView.OptimizeEdgePanGesture(of: self)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenWidth/375*812)
        
        let image = UIImageView()
        image.setup(superview: scrollView, imageName: "iPhoneX")
        image.setFrame(left: 0, top: 0, width: kScreenWidth, height: kScreenWidth/375*812)
    }
}


