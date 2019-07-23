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
//        scrollView.makeConstraintsToLeftTop(left: 0, top: kNavBarHeight, width: view, height: 400)
        
        let viewContainer = UIView()
        scrollView.addSubview(viewContainer)
//        viewContainer.makeConstraintsToLeftTop(left: 0, top: 0, width: scrollView, height: scrollView)
        viewContainer.backgroundColor = UIColor.hex(colorF5F6F8)
        
        let image = createUIImageView(parentView: viewContainer, imageName: "iPhoneX")
        image.makeConstraintsToLeftTop(left: 0, top: 0, width: kScreenWidth, height: 1000)
//        image.makeConstraintsToBottom(bottom: viewContainer)
        
        
    }
    
    
}

