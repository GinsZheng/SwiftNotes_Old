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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        myView.set(superview: view)
        myView.setFrame(centerX: view.centerX, top: 20, width: 100, height: 100)
        myView.backgroundColor = UIColor.hex(cBlue_2C9EFF)
        
        view.addSubview(solidButton)
        solidButton.setFrame(left: 20, bottom: 80, width: kScreenWidth - 40, height: 44)
        solidButton.setTitle("Start Animation", for: .normal)
        solidButton.setTitleColor(UIColor.white, for: .normal)
        solidButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        solidButton.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF), for: .normal)
        solidButton.setBackgroundImage(getImageWithColor(color: "992c9eff"), for: .highlighted)
        solidButton.setBackgroundImage(getImageWithColor(color: "662c9eff"), for: .disabled)
        solidButton.setCornerRadiusWithMask(radius: 4)
        solidButton.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        
        
        }
    
    @objc func startAnimation() {
        
        UIView.animate(withDuration: 4, delay: 0.4, options: [.autoreverse], animations: {
            self.myView.backgroundColor = UIColor.hex(cOrange_F9AD18)
            self.myView.alpha = 0.5
            self.myView.y = 300
            self.myView.width = 335
            self.myView.height = 150
            self.myView.centerX = self.view.centerX
            
        }) { (_) in
            // 回调：动画结束后执行
            self.myView.backgroundColor = UIColor.hex(cBlue_2C9EFF)
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
        
    }
    
    
}

