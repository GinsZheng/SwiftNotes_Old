//
//  ScrollViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ScrollViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.makeConstraints(left: 0, top: kNavBarHeight, width: kScreenWidth, height: 400)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenWidth/375*812)
        
        let image = UIImageView()
        image.set(superview: scrollView, imageName: "iPhoneX")
        image.makeConstraints(left: 0, top: 0, width: kScreenWidth, height: kScreenWidth/375*812)
        
    }
    
    
}

