//
//  TransitionPage.swift
//  HeroTest
//
//  Created by FDM on 2019/10/17.
//  Copyright © 2019 发抖喵. All rights reserved.
//

import UIKit
import Hero
import SnapKit

// 转场1 神奇移动 FromView
class Transition1FromVC: UIViewController {
    
    let grayView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        grayView.set(superview: view, backgroundColor: cCCC)
        grayView.setCornerRadius(radius: 15)
        grayView.setFrame(left: 40, top: 180, width: kScreenWidth - 80, height: 56)
        
        blueView.set(superview: view, backgroundColor: cF0F1F3)
        blueView.setCornerRadius(radius: 10)
        blueView.setFrame(left: 90, top: 270, width: kScreenWidth - 180, height: 260)
        
        // 1. 设置UIView的id，要与第二个页面相同的UIView的id名相同
        grayView.hero.id = "grayView"
        blueView.hero.id = "blueView"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 2. 设置跳转
        let toVC = Transition1ToVC()
        toVC.hero.isEnabled = true
        self.presentFullScreen(toTarget: toVC)
    }
}

// 转场1 神奇移动 toView
class Transition1ToVC: UIViewController {
    
    let grayView = UIView()
    let blueView = UIView()
    let whiteView = UIView() // 新增UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 设置终态的View
        blueView.set(superview: view, backgroundColor: cF0F1F3)
        blueView.setCornerRadius(radius: 0) // 这句可以省略，只需给出始态与终态
        blueView.setFrame(allEdges: 0)
        
        grayView.set(superview: view, backgroundColor: cOrange_F7AD18)
        grayView.setCornerRadius(radius: 15)
        grayView.setFrame(centerX: view.centerX, top: 100, width: 100, height: 100)
        
        // 新增的UIView也为终态
        whiteView.set(superview: view, backgroundColor: cBlue_2C9EFF_40)
        whiteView.setCornerRadius(radius: 15)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}



// 转场2 渐隐渐现
class Transition2FromVC: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        button.set(superview: view, target: self, action: #selector(goNext))
        button.setStyleSolidBtn(title: "渐隐渐现")
        button.setCornerRadius(radius: 50)
        button.setFrame(centerX: view.centerX, top: 200, width: 100, height: 100)
        
    }
    
    @objc func goNext() {
        let vc = Transition2ToVC()
        vc.hero.isEnabled = true
        self.presentFullScreen(toTarget: vc)
    }
}

class Transition2ToVC: UIViewController {
    
    let button = UIButton()
    let blackView = UIView()
    let bgImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        blackView.set(superview: view, backgroundColor: c000_97)
        blackView.setFrame(allEdges: 0)
        
        bgImage.set(superview: view, imageName: "adding_background")
        bgImage.setStyleImageView(cornerRadius: 0)
        bgImage.setFrame(allEdges: 0)
        
        blackView.hero.modifiers = [.opacity(0), .duration(1), .useGlobalCoordinateSpace]
        bgImage.hero.modifiers = [.opacity(0), .duration(1), .delay(0.5), .useGlobalCoordinateSpace]
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.unpresent()
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
