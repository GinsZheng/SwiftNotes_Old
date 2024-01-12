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
class CSDissolveFromVC: UIViewController {
    
    let button = UIButton()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        button.setup(superview: view, target: self, action: #selector(goNext))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "渐隐渐现")
        button.setCornerRadiusWithMask(radius: 50)
        button.setFrame(centerX: view.centerX, top: 200, width: 100, height: 100)
        
    }
    
    // MARK: - @objc func
    @objc func goNext() {
        let vc = DissolveToVC()
        vc.hero.isEnabled = true
        self.presentFullScreen(targetVC: vc)
    }
}



class DissolveToVC: UIViewController {
    
    let button = UIButton()
    let blackView = UIView()
    let bgImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        blackView.setup(superview: view, backgroundColor: c000_97)
        blackView.setFrame(allEdges: 0)
        
        bgImage.setup(superview: view, imageName: "adding_background")
        bgImage.setFrame(allEdges: 0)
        
        blackView.hero.modifiers = [.opacity(0), .duration(1), .useGlobalCoordinateSpace]
        bgImage.hero.modifiers = [.opacity(0), .duration(1), .delay(0.5), .useGlobalCoordinateSpace]
        
    }
}
