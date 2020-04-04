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
    // 时长 <1分钟，Int(M分钟)，H小时
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
    
    // 时长 Int(M分钟)
    static func getDurationStr2(fromSeconds seconds: Int) -> String {
        return "\(Int(getMinites(fromSeconds: seconds)))分钟"
    }

    // 时长 mm:ss H:mm:ss
    static func getDurationStrHMMSS(secounds: TimeInterval) -> String {
        if secounds.isNaN {
            return "00:00"
        }
        var Min = Int(secounds / 60)
        let Sec = Int(secounds.truncatingRemainder(dividingBy: 60))
        var Hour = 0
        if Min >= 60 {
            Hour = Int(Min / 60)
            Min = Min - Hour*60
            return String(format: "%d:%02d:%02d", Hour, Min, Sec)
        }
        return String(format: "%02d:%02d", Min, Sec)
    }
    
    // 比例 <1%，Int(N%)
    static func getPercentageStr1(percentage: Double) -> String {
        var result = "\(Int(percentage*100))%"
        if percentage < 0.01 {
            result = "<1%"
        }
        return result
    }
    
    // 时间 HH:mm
    static func getTimeStrHHmm(timeStamp: Double) -> String {
        var result = getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: "HH:mm")
        return result
    }
    
    // 日期+时间 M/d HH:mm
    static func getDateAndTimeStrMdHHmm(timeStamp: Double) -> String {
        var result = getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: "M/d HH:mm")
        return result
    }
}
