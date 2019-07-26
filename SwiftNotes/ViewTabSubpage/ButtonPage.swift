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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let wordButton = UIButton(type: .system)
        view.addSubview(wordButton)
        wordButton.makeConstraints(left: 20, top: 100, right: 20, height: 44)
        wordButton.setTitle("Word Button", for: .normal)
        wordButton.setTitleColor(UIColor.hex(color2C9EFF), for: .normal)
        wordButton.titleLabel?.setFontStyle(color: color2C9EFF, size: 17)
        wordButton.addTarget(self, action: #selector(pushToGeneralSubpage), for: .touchUpInside)
        
        let ghostButton = UIButton(type: .system)
        view.addSubview(ghostButton)
        ghostButton.makeConstraints(left: 20, top: wordButton.bottom + 20, right: 20, height: 44)
        ghostButton.setTitle("Ghost Button", for: .normal)
        ghostButton.setTitleColor(UIColor.hex(color2C9EFF), for: .normal)
        ghostButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular) // 这里设置UILabel的颜色值将无效
        ghostButton.addBorder(color: color2C9EFF, borderWidth: 0.5)
        ghostButton.setCornerRadius(radius: 4)
        ghostButton.addTarget(self, action: #selector(pushToGeneralSubpage), for: .touchUpInside)
        
        let solidButton = UIButton(type: .custom)
        view.addSubview(solidButton)
        solidButton.makeConstraints(left: 20, top: ghostButton.bottom + 20, right: 20, height: 44)
        solidButton.setTitle("Solid Button", for: .normal)
        solidButton.setTitleColor(UIColor.white, for: .normal)
        solidButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        solidButton.setBackgroundImage(getImageWithColor(color: color2C9EFF), for: .normal)
        solidButton.setBackgroundImage(getImageWithColor(color: "992c9eff"), for: .highlighted)
        solidButton.setBackgroundImage(getImageWithColor(color: "662c9eff"), for: .disabled)
        solidButton.setCornerRadius(radius: 4)
        solidButton.addTarget(self, action: #selector(pushToGeneralSubpage), for: .touchUpInside)
        
        let iconButton = UIButton(type: .custom)
        view.addSubview(iconButton)
        iconButton.makeConstraints(centerX: view.centerX, top: solidButton.bottom + 20, width: 44, height: 44)
        iconButton.setImage(UIImage(named: "mine_item"), for: .normal)
        iconButton.adjustsImageWhenHighlighted = false
        iconButton.addTarget(self, action: #selector(pushToGeneralSubpage), for: .touchUpInside)
        iconButton.backgroundColor = UIColor.hex(colorF5F6F8)
        iconButton.setCornerRadius(radius: 22)
        
        let iconButton2 = UIButton(type: .system)
        view.addSubview(iconButton2)
        iconButton2.makeConstraints(centerX: view.centerX, top: iconButton.bottom + 20, width: 44, height: 44)
        iconButton2.setImage(UIImage(named: "mine_item"), for: .normal)
        iconButton2.tintColor = UIColor.hex(color2C9EFF)
        iconButton2.addTarget(self, action: #selector(pushToGeneralSubpage), for: .touchUpInside)
        
        
    }
    
    
}

