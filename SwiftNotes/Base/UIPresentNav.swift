//
//  PresentNav.swift
//  SnailProgress
//
//  Created by GinsMac on 2020/3/1.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSPresentNavView: UIView {
    var onCloseButtonTap: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton(type: .custom)
    
    func setup(superview: UIView, title: String) {
        self.setup(superview: superview)
        self.setFrame(left: 0, top: 0, right: 0, height: 56)
        
        titleLabel.setup(superview: self, text: title)
        titleLabel.setStyle24pt222Med()
        titleLabel.setFrame(left: 20, centerY: self.centerY)
        
        closeButton.setup(superview: self)
        closeButton.setStyleIconButton(imageName: "nav_close")
        closeButton.setFrame(right: 20, centerY: self.centerY, width: 18, height: 18)
        closeButton.extendTouchArea()
        closeButton.setEvent {
            self.onCloseButtonTap?()
        }
    }
    
}
