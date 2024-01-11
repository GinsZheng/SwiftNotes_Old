//
//  SliderPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/17.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class SliderPage: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let slider = UISlider()
        slider.setup(superview: view)
        slider.setFrame(left: 50, top: 20, right: 50, height: 40)
        slider.setThumbImage(UIImage(named: "tickets-refund-reason-s"), for: .normal)
        slider.setMinimumTrackImage(getImageWithColor(color: cBlue_5393FF), for: .normal)
        slider.setMaximumTrackImage(getImageWithColor(color: c999), for: .normal)
        
    }
}


