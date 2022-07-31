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
        
        let timeStamp = 8888888
        let value = CSFormatter.getDurationStrHMMSS(fromSeconds: timeStamp)

        button.set(superview: view, target: self, action: #selector(presentNext))
        button.setStyleSolidBtn(title: value)
//        button.setBackgroundImage(getImageWithColor(color: cRed_FF635A), for: .normal)
        button.setFrame(left: 20, top: 200, right: 20, height: 44)
        
//        print(getTimeStampWithTimeStr(timeStr: <#T##String#>, dateFormat: <#T##String#>)"1644488762")
        print(CSFormatter.getTimeStr12Hour(timeStamp: 1644488762))
        
        
        let activity = UIActivityIndicatorView()
        activity.style = .medium
        activity.setFrame(left: 100, top: 400, width: 20, height: 20)
        activity.hidesWhenStopped = false
        activity.color = .white
        activity.startAnimating()
        
        let x = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: "Cal"))
        
        let colorArr = [UIColor.hex(cRed_FF635A).cgColor, UIColor.hex(cBlue_5393FF).cgColor, UIColor.hex(cPurple_BF62F8).cgColor]
        let gradientView = UIView()
//        let locationArr = NSNumber[0, 0.3, 1]
        
        gradientView.set(superview: view)
        gradientView.setFrame(left: 10, top: 100, width: 160, height: 80)
        gradientView.setGradientLayer(colors: colorArr, locations: [0, 0.5, 1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1,y: 0))
        
        
        
    }
    
    @objc func presentNext() {
        print("pressed")
    }
    
    
}


