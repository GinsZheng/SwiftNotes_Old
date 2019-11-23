//
//  SliderPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/17.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class SliderPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let slider = UISlider()
        view.addSubview(slider)
        slider.makeConstraints(left: 50, top: 100, right: 50, height: 40)
        slider.setThumbImage(UIImage(named: "tickets-refund-reason-s"), for: .normal)
        slider.setMinimumTrackImage(getImageWithColor(color: c2C9EFF), for: .normal)
        slider.setMaximumTrackImage(getImageWithColor(color: c999), for: .normal)
        
        

    }
    
    
}

