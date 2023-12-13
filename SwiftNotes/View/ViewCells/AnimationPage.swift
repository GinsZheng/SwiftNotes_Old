//
//  AnimationPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/8/3.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class AnimationPage: UIViewController {
    
    let myView = UIView()
    let solidButton = UIButton(type: .custom)
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        myView.setup(superview: view, backgroundColor: cBlue_5393FF)
        myView.setFrame(centerX: view.centerX, top: 20, width: 100, height: 100)
        
        solidButton.setup(superview: view, target: self, action: #selector(startAnimation))
        solidButton.setStyleSolidButton(title: "Start Animation", titleSize: 17, titleColor: cFEFEFE, bgImage: getImageWithColor(color: cThemeFill), radius: 10)
        solidButton.setFrame(left: 20, bottom: 34, width: kScreenWidth - 40, height: 44)
    }
    
    
    // MARK: - @objc func
    
    @objc func startAnimation() {
        
        UIView.animate(withDuration: 4, delay: 0.4, options: [.autoreverse], animations: {
            self.myView.backgroundColor = UIColor.hex(cOrange_F9AD18)
            self.myView.alpha = 0.5
            self.myView.y = 300
            self.myView.width = 335
            self.myView.height = 150
            self.myView.centerX = self.view.centerX
            // self.myView.isHidden = true // 动画对isHidden无效(不能形成渐隐渐现效果)
            
        }) { (_) in
            // 回调：动画结束后执行
            self.myView.backgroundColor = UIColor.hex(cBlue_5393FF)
            self.myView.alpha = 1
            self.myView.y = 100
            self.myView.width = 100
            self.myView.height = 100
            self.myView.centerX = self.view.centerX
            
        }
        
        // 延迟执行的代码
        // 此处表示，延迟12秒后，移除myView
        DispatchQueue.main.asyncAfter(deadline: .now() + 12, execute: {
            self.myView.removeFromSuperview()
        })
        
        // ⚠️注意，此处函数参数一定要选对，多选了参数将达不到效果，如如果用以下函数(多了两个参数)，将达不到想要的动画效果
        //        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, usingSpringWithDamping: <#T##CGFloat#>, initialSpringVelocity: <#T##CGFloat#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
    }
    
    
}

