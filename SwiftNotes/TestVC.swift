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
        
        let result = CSFormatter.getDurationStrConfig(fromSeconds: 6000, type: DurationFormat(rawValue: 1) ?? .defaultType)
        print("时长", result)
        
//        var x = [1,2,3,4,5]
//        x[5] = 6
    }
    
    @objc func presentNext() {
        print("pressed")
    }
    
    
}


