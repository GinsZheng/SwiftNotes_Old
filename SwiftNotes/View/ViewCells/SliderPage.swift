//
//  CSSliderPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/17.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSSliderPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let slider = UISlider()
        slider.set(superview: view)
        slider.setFrame(left: 50, top: 20, right: 50, height: 40)
        slider.setThumbImage(UIImage(named: "tickets-refund-reason-s"), for: .normal)
        slider.setMinimumTrackImage(getImageWithColor(color: cBlue_5393FF), for: .normal)
        slider.setMaximumTrackImage(getImageWithColor(color: c999), for: .normal)
        
        

    }
    
    
}

