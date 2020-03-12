//
//  PresentNav.swift
//  SnailProgress
//
//  Created by GinsMac on 2020/3/1.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class UIPresentNav {
    
    let closeButton = UIButton(type: .custom)
    let titleLabel = UILabel()
    
    func setCloseButton(superview: UIView, target: Any?, action: Selector) {
        closeButton.set(superview: superview, target: target, action: action)
        closeButton.setFrame(right: 20, top: 19, width: 18, height: 18)
        closeButton.setImage(UIImage(named: "nav_close"), for: .normal)
        closeButton.extendTouchArea()
    }
    
    func setTitleLabel(superview: UIView, title: String) {
        titleLabel.set(superview: superview, text: title)
        titleLabel.setStyle24pt222Med()
        titleLabel.setFrame(left: 20, top: 44)
    }
    
    
}
