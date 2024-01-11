//
//  CSTimePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/2/28.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSTimePage: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        let timeStrLabel = UILabel()
        timeStrLabel.setup(superview: view, text: getTimeStrWithTimeStamp(timeStamp: 1463637807, dateFormat: "yyyy/M/d HH:mm:ss"))
        timeStrLabel.setStyle17pt222()
        timeStrLabel.setFrame(left: 20, top: 20)
        
        let timeStampLabel = UILabel()
        timeStampLabel.setup(superview: view, text: String(getTimeStampWithTimeStr(timeStr: "2018/2/2 10:10:11", dateFormat: "yyyy/M/d HH:mm:ss")))
        timeStampLabel.setStyle17pt222()
        timeStampLabel.setFrame(left: 20, top: timeStrLabel.bottom + 20)
        
        let nowTimeStamp = getTimeStampNow()
        let nowLabel = UILabel()
        nowLabel.setup(superview: view, text: "\(nowTimeStamp)")
        nowLabel.setStyle17pt222()
        nowLabel.setFrame(left: 20, top: timeStampLabel.bottom + 20)
        
    }
    
}

