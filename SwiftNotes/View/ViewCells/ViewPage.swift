//
//  ViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/25.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewPage: UIViewController {
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        let myView = UIView()
        myView.setup(superview: view, backgroundColor: cF5F6F8)
        myView.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 100)
        
        // 定制圆角图层
        let multiCornersView = UIView()
        multiCornersView.setBackgroundColor(color: cBlue_5393FF)
        multiCornersView.setup(superview: view)
        multiCornersView.setFrame(left: 20, top: myView.bottom + 20, width: kScreenWidth - 40, height: 66)
        multiCornersView.setEachCornerRadiusWithMask(radius: 16, corners: [.topRight, .bottomRight])
        
        // 渐变图层
        let gradientView = UIView()
        gradientView.setup(superview: view)
        gradientView.setFrame(left: 20, top: multiCornersView.bottom + 20, width: kScreenWidth - 40, height: 100)
        gradientView.setGradientLayer(colors: [UIColor.hex(cBlue_5393FF).cgColor, UIColor.hex(cPurple_BF62F8).cgColor,  UIColor.hex(cRed_FF635A).cgColor], locations: [0, 0.3, 1], startPoint: CGPoint.init(x: 0, y: 0), endPoint: CGPoint.init(x: 1, y: 1))
        
        // 次像素测试
        let subpixelView = UIView()
        subpixelView.setup(superview: view)
        subpixelView.setFrame(left: 20, top: gradientView.bottom + 20, width: kScreenWidth - 40, height: 1.5)
        subpixelView.backgroundColor = .hex(cBlue_5393FF)
        // 结果：0.5pt在3倍屏下显示为1px，1.5pt在3倍屏下显示为4px
    }
    
}

