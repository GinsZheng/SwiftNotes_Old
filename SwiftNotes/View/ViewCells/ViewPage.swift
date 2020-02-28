//
//  ViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/25.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let myView = UIView()
        myView.set(superview: view, backgroundColor: cF5F6F8)
        myView.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 100)
        
        let multiCornersView = UIView()
        multiCornersView.setBackgroundColor(color: cBlue_2C9EFF)
        multiCornersView.set(superview: view)
        multiCornersView.setFrame(left: 20, top: myView.bottom + 20, width: kScreenWidth - 40, height: 66)
        multiCornersView.setCornerRadius(radius: 16, corners: [.topRight, .bottomRight])
        
        let gradientView = UIView()
        gradientView.set(superview: view)
        gradientView.setFrame(left: 20, top: multiCornersView.bottom + 20, width: kScreenWidth - 40, height: 100)
        gradientView.setGradientLayer(colors: [UIColor.hex(cBlue_2C9EFF).cgColor, UIColor.hex(cPurple_BF62F8).cgColor,  UIColor.hex(cRed_FF5349).cgColor], locations: [0, 0.3, 1], startPoint: CGPoint.init(x: 0, y: 0), endPoint: CGPoint.init(x: 1, y: 1))
        
        
    }
    
    
}

