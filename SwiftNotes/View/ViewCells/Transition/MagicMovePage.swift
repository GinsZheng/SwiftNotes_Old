//
//  TransitionListPage.swift
//  HeroTest
//
//  Created by FDM on 2019/10/17.
//  Copyright © 2019 发抖喵. All rights reserved.
//

import UIKit
import Hero

// 转场1 神奇移动 FromView
class MagicMoveFromVC: UIViewController {
    
    let grayView = UIView()
    let blueView = UIView()
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 2. 设置跳转
        let toVC = MagicMoveToVC()
        toVC.hero.isEnabled = true
        self.presentFullScreen(targetVC: toVC)
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        grayView.setup(superview: view, backgroundColor: c000_22)
        grayView.setCornerRadiusWithMask(radius: 15)
        grayView.setFrame(left: 40, top: 180, width: kScreenWidth - 80, height: 56)
        
        blueView.setup(superview: view, backgroundColor: cF0F1F3)
        blueView.setCornerRadiusWithMask(radius: 10)
        blueView.setFrame(left: 90, top: 270, width: kScreenWidth - 180, height: 260)
        
        // 1. 设置UIView的id，要与第二个页面相同的UIView的id名相同
        grayView.hero.id = "grayView"
        blueView.hero.id = "blueView"
    }
}



// 转场1 神奇移动 toView
class MagicMoveToVC: UIViewController {
    
    let grayView = UIView()
    let blueView = UIView()
    let whiteView = UIView() // 新增UIView
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        // 设置终态的View
        blueView.setup(superview: view, backgroundColor: cF0F1F3)
        blueView.setCornerRadiusWithMask(radius: 0) // 这句可以省略，只需给出始态与终态
        blueView.setFrame(allEdges: 0)
        
        grayView.setup(superview: view, backgroundColor: cOrange_F9AD18)
        grayView.setCornerRadiusWithMask(radius: 15)
        grayView.setFrame(centerX: view.centerX, top: 100, width: 100, height: 100)
        
        // 新增的UIView也为终态
        whiteView.setup(superview: view, backgroundColor: cBlue_5393FF_40)
        whiteView.setCornerRadiusWithMask(radius: 15)
        whiteView.setFrame(centerX: view.centerX, top: 400, width: 300, height: 400)
        
        // 3. 设置id，与FromVC对应
        grayView.hero.id = "grayView"
        blueView.hero.id = "blueView"
        
        // 4. 设置新增的whiteView的始态，只需在数组中加入有差异的部分：
        // translate(y:500) - 设置view是从y = 500的位置向y = 300的位置移动，
        // useGlobalCoordinateSpace设置为独立的View(不设置的话效果差)
        // 数组内常用的动画，见底部笔记
        whiteView.hero.modifiers = [.translate(y: 500), .useGlobalCoordinateSpace]
    }
}


/*
 whiteView.hero.modifiers = [.translate(y:500), .useGlobalCoordinateSpace]
 
 .translate 为动画参数，等位的有：
 
 动画参数：
 .scale(x: CGFloat = 1, y: CGFloat = 1, z: CGFloat = 1)
 .scale(_ xy: CGFloat) // 等比例缩放
 .translate(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) // 平移
 .rotate(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0)
 .opacity(_ opacity: CGFloat)
 .backgroundColor(_ backgroundColor: UIColor)
 .cornerRadius(_ cornerRadius: CGFloat)
 
 时长等属性
 .duration(_ duration: TimeInterval)
 .delay(_ delay: TimeInterval)
 
 
 */
