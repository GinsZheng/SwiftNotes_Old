//
//  Dissolve.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/10.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import Hero

// 转场2 渐隐渐现
class DissolveFromVC: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        button.set(superview: view, target: self, action: #selector(goNext))
        button.setStyleSolidBtn(title: "渐隐渐现")
        button.setCornerRadiusWithMask(radius: 50)
        button.setFrame(centerX: view.centerX, top: 200, width: 100, height: 100)
        
    }
    
    @objc func goNext() {
        let vc = DissolveToVC()
        vc.hero.isEnabled = true
        self.presentFullScreen(toTarget: vc)
    }
}

class DissolveToVC: UIViewController {
    
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
        self.dismiss()
    }
    
}
