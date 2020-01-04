//
//  ButtonPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/11.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ButtonPage: UIViewController {
    
    @objc func pushToGeneralSubpage() {
        self.pushFromSecondaryPage(toTarget: GeneralSubpage())
    }
    
    @objc func pushWithParameter(_ button: UIButton) {
        self.pushFromSecondaryPage(toTarget: GeneralSubpage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let wordButton = UIButton(type: .system)
        wordButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        wordButton.setFrame(left: 20, top: 100, right: 20, height: 44)
        wordButton.setTitle("Word Button", for: .normal)
        wordButton.setTitleColor(UIColor.hex(cBlue_2C9EFF), for: .normal)
        wordButton.titleLabel?.setFontStyle(size: 17, color: cBlue_2C9EFF)
        
        let ghostButton = UIButton(type: .system)
        ghostButton.set(superview: view, target: self, action: #selector(pushWithParameter(_:)))
        ghostButton.setFrame(left: 20, top: wordButton.bottom + 20, right: 20, height: 44)
        ghostButton.setTitle("Ghost Button", for: .normal)
        ghostButton.setTitleColor(UIColor.hex(cBlue_2C9EFF), for: .normal)
        ghostButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular) // 这里设置UILabel的颜色值将无效
        ghostButton.setBorder(color: cBlue_2C9EFF, borderWidth: 0.5)
        ghostButton.setCornerRadius(radius: 4)
        
        let solidButton = UIButton(type: .custom)
        solidButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        solidButton.setFrame(left: 20, top: ghostButton.bottom + 20, right: 20, height: 44)
        solidButton.setTitle("Solid Button", for: .normal)
        solidButton.setTitleColor(UIColor.white, for: .normal)
        solidButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        solidButton.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF), for: .normal)
        solidButton.setBackgroundImage(getImageWithColor(color: "992c9eff"), for: .highlighted)
        solidButton.setBackgroundImage(getImageWithColor(color: "662c9eff"), for: .disabled)
        solidButton.setCornerRadius(radius: 4)
        
        let iconButton = UIButton(type: .custom)
        iconButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        iconButton.setFrame(centerX: view.centerX, top: solidButton.bottom + 20, width: 44, height: 44)
        iconButton.setImage(UIImage(named: "mine_item"), for: .normal)
        iconButton.adjustsImageWhenHighlighted = false
        iconButton.backgroundColor = UIColor.hex(cF5F6F8)
        iconButton.setCornerRadius(radius: 22)
        
        let iconButton2 = UIButton(type: .system)
        iconButton2.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        iconButton2.setFrame(centerX: view.centerX, top: iconButton.bottom + 20, width: 44, height: 44)
        iconButton2.setImage(UIImage(named: "mine_item"), for: .normal)
        iconButton2.tintColor = UIColor.hex(cBlue_2C9EFF)
        
        
    }
    
    
}

