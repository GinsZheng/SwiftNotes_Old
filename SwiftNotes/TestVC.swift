//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON

class TestVC: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let img = UIImageView()
        img.set(superview: view, image: UIImage(named: "adding_background")?.withFilter(c000_10) ?? getImageWithColor(color: cF0F1F3))
        img.setStyleImageView(cornerRadius: 10)
        img.setFrame(left: 0, top: 0, right: 0, height: 667)
        
//        let lbl = UILabel()
        let time = CSFormatter.getDateAndTimeStrYYYYMDHHmmInThePastYear(timeStamp: 1360211688)
        
        print("打印日期", time)
    }
    
    @objc func presentNext() {
        print("pressed")
    }
    
    
}


