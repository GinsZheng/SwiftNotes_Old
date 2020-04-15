//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let picker = CSDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        let calendar = NSCalendar.current
        var componts = calendar.dateComponents([.weekday, .year, .month, .day], from: Date())
        componts.day = componts.day!
          
        let tomorrowInterval = calendar.date(from: componts)?.timeIntervalSince1970
        print(tomorrowInterval)
        print(getTimeStrWithTimeStamp(timeStamp: tomorrowInterval ?? 0))
        
    }

//    func getTimeStampOfTheBeginingToday() -> 
    
}

//1586853159
