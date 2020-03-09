//
//  TimePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/2/28.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class TimePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let getTimeStr = UILabel()
        getTimeStr.set(superview: view, text: getTimeStrWithTimeStamp(timeStamp: 1463637807, dateFormat: "yyyy/M/d HH:mm:ss"))
        getTimeStr.setStyle17pt222()
        getTimeStr.setFrame(left: 20, top: 20)
        
        let getTimeStamp = UILabel()
        getTimeStamp.set(superview: view, text: String(getTimeStampWithTimeStr(timeStr: "2018/2/2 10:10:11", dateFormat: "yyyy/M/d HH:mm:ss")))
        getTimeStamp.setStyle17pt222()
        getTimeStamp.setFrame(left: 20, top: getTimeStr.bottom + 20)
    }
    
}

