//
//  Formatter.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSFormatter {
    
    static func getMinites(fromSeconds seconds: Int, decimalPlaces: Int = 0) -> Double {
        // seconds可从两个时间戳的差值获取
        return round(Double(seconds)/60, decimalPlaces: decimalPlaces)
    }
    
    static func getHours(fromSeconds seconds: Int, decimalPlaces: Int = 0) -> Double {
        return round(Double(seconds)/3600, decimalPlaces: decimalPlaces)
    }

}

extension CSFormatter {
    
    static func getDurationStr1(fromSeconds seconds: Int) -> String {
        var result = ""
        switch seconds {
        case 0..<60:
            result = "<1分钟"
        case 60..<3600:
            result = "\(seconds/60)分钟"
        default:
            result = "\(getHours(fromSeconds: seconds, decimalPlaces: 1))小时"
        }
        return result
    }
    
    static func getPercentageStr1(percentage: Double) -> String {
        var result = "\(Int(percentage*100))%"
        if percentage < 0.01 {
            result = "<1%"
        }
        return result
    }
    

}
