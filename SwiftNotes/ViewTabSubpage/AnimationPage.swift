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
        myView.makeConstraints(centerX: view.centerX, top: 100, width: 100, height: 100)
        myView.backgroundColor = UIColor.hex(color2C9EFF)
        
        view.addSubview(solidButton)
        solidButton.makeConstraints(left: 20, bottom: 80, width: kScreenWidth - 40, height: 44)
        solidButton.setTitle("Start Animation", for: .normal)
        solidButton.setTitleColor(UIColor.white, for: .normal)
        solidButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        solidButton.setBackgroundImage(getImageWithColor(color: color2C9EFF), for: .normal)
        solidButton.setBackgroundImage(getImageWithColor(color: "992c9eff"), for: .highlighted)
        solidButton.setBackgroundImage(getImageWithColor(color: "662c9eff"), for: .disabled)
        solidButton.setCornerRadius(radius: 4)
        solidButton.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        
        
        }
    
    @objc func startAnimation() {
//        UIView.animate(withDuration: 4) {
//            self.myView.backgroundColor = UIColor.hex(colorF7AD18)
//            self.myView.alpha = 0.5
//            self.myView.x = 20
//            self.myView.y = 300
//            self.myView.width = 335
//            self.myView.height = 150
//        }
        
        UIView.animate(withDuration: 4, delay: 0.4, options: [.autoreverse], animations: {
            self.myView.backgroundColor = UIColor.hex(colorF7AD18)
            self.myView.alpha = 0.5
            self.myView.y = 300
            self.myView.width = 335
            self.myView.height = 150
            self.myView.centerX = self.view.centerX

        }) { (_) in
            self.myView.backgroundColor = UIColor.hex(color2C9EFF)
            self.myView.alpha = 1
            self.myView.y = 100
            self.myView.width = 100
            self.myView.height = 100
            self.myView.centerX = self.view.centerX
            
            
        }
        
        
        
        }
    

}

