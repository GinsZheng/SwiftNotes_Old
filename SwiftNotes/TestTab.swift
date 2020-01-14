//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestTab: UIViewController {
    
    let solidButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        solidButton.set(superview: view)
        solidButton.setFrame(left: 20, top: 100, right: 20, height: 44)
        solidButton.setTitle("Solid Button", for: .normal)
        solidButton.setTitleColor(UIColor.white, for: .normal)
        solidButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        solidButton.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF), for: .normal)
        solidButton.setBackgroundImage(getImageWithColor(color: "992c9eff"), for: .highlighted)
        solidButton.setBackgroundImage(getImageWithColor(color: "662c9eff"), for: .disabled)
        solidButton.setCornerRadius(radius: 4)
        
        solidButton.addTarget(self, action: #selector(pushToGeneralPage), for: .touchUpInside)


    }

    @objc func pushToGeneralPage() {
        self.push(toTarget: GeneralSubpage())
    }

}

