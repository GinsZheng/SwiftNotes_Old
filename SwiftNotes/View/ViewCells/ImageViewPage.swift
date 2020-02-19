//
//  ImageViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ImageViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let image = UIImageView()
        image.set(superview: view, imageName: "iPhoneX")
        image.setStyleNote()
        image.setFrame(left: 20, top: 20, right: 20, height: 300)
        
        let stretchImage = UIImageView()
        stretchImage.set(superview: view)
        stretchImage.setFrame(left: 20, top: 340, width: 300, height: 300)
        stretchImage.stretchMiddle(imageName: "stretchRect", left: 15, top: 15, right: 15, bottom: 15)
        /*
         以九宫格为参考，九宫格各区域：
         1  2  3
         4  5  6
         7  8  9
         left值，相当于1和2区域间划条竖线，1区域不拉伸
         right值，相当于2和3区域间划条竖线，3区域不拉伸
         top值，相当于1和4区域间划条横线，1区域不拉伸
         如left = 15，表示竖线左边(1/4/7)不提拉伸区域宽度为15pt
         */
        
    }
    
    
}

