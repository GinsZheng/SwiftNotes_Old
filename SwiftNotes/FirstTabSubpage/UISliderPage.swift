//
//  UISliderPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/17.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class UISliderPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let slider = UISlider()
        view.addSubview(slider)
        slider.makeConstraintsToLeftTopRight(left: 50, top: 100, right: -50, height: 40)
        slider.setThumbImage(UIImage(named: "tickets-refund-reason-s"), for: .normal)
        slider.setMinimumTrackImage(getImageWithColor(color: "ff7a00"), for: .normal)
        slider.setMaximumTrackImage(getImageWithColor(color: "999"), for: .normal)

    }
    
    
}

