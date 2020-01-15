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
        wordButton.setStyleWordButton(title: "Word Button")
        wordButton.setFrame(left: 20, top: 20, right: 20, height: 44)
        
        let ghostButton = UIButton(type: .system)
        ghostButton.set(superview: view, target: self, action: #selector(pushWithParameter(_:)))
        ghostButton.setStyleGhostButton(title: "Ghost Button")
        ghostButton.setFrame(left: 20, top: wordButton.bottom + 20, right: 20, height: 44)
        
        let solidButton = UIButton(type: .custom)
        solidButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        solidButton.setStyleSolidButton(title: "Solid Button")
        solidButton.setFrame(left: 20, top: ghostButton.bottom + 20, right: 20, height: 44)
        
        let systemIconButton = UIButton(type: .system)
        systemIconButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        systemIconButton.setStyleSystemIconButton(imageName: "mine_item")
        systemIconButton.setFrame(centerX: view.centerX, top: solidButton.bottom + 20, width: 44, height: 44)
        
        let customIconButton = UIButton(type: .custom)
        customIconButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        customIconButton.setStyleCustomIconButton(imageName: "mine_item")
        customIconButton.setFrame(centerX: view.centerX, top: systemIconButton.bottom + 20, width: 44, height: 44)
        
        
    }
    
    
}

