//
//  ImageViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
// 含UIImage的笔记

class ImageViewPage: UIViewController {
    
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let image = UIImageView()
        image.setup(superview: view, imageName: "big_MacStudio")
        image.setFrame(left: 20, top: 20, right: 20, height: 300)
        
        let stretchMiddleImage = UIImageView()
        stretchMiddleImage.setup(superview: view)
        stretchMiddleImage.setFrame(left: 20, top: 340, width: 78, height: 84)
        stretchMiddleImage.stretchMiddle(imageName: "stretchRect", left: 15, top: 15, right: 15, bottom: 15)
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
        
        let stretchLeftAndRightImage = UIImageView()
        stretchLeftAndRightImage.setup(superview: view)
        stretchLeftAndRightImage.setFrame(left: 20, top: stretchMiddleImage.bottom + 20, width: kScreenWidth - 40, height: 84)
        stretchLeftAndRightImage.stretchLeftAndRight(imageName: "stretchNotEqual", left: 0, top: 0, right: 0, bottom: 0, middleFixedWidth: 78, imageWidth: 232, ratio: 0.5)
        
        
        let stretchFiveSegmentImage = UIImageView()
        stretchFiveSegmentImage.setup(superview: view)
        stretchFiveSegmentImage.setFrame(left: 20, top: stretchLeftAndRightImage.bottom + 20, width: kScreenWidth - 40, height: 84)
        stretchFiveSegmentImage.stretchLeftAndRight(imageName: "stretchFiveSegment", left: 10, top: 10, right: 10, bottom: 10, middleFixedWidth: 78, imageWidth: 222, ratio: 0.5)
        
        // 图片降分辨率 & 图片压缩
        _ = resetSizeOfImageData(UIImage(named: "big_MacStudio")!, maxSize: 100000)
    }
    
}

/*
 图片视图：
 默认会把图片内容拉伸以填满图片视图
 */
