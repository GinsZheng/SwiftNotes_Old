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
    static func getDurationStrDefault(fromSeconds seconds: Int) -> String {
        var result = ""
        switch seconds {
        case ..<30:
            result = "<1分钟"
        case 30..<3570:
            result = "\(seconds/60)分钟"
        default:
            result = "\(getHours(fromSeconds: seconds, decimalPlaces: 1))小时"
        }
        return result
    }
    
    // 时长 mm:ss H:mm:ss
    static func getDurationStrHMMSS(fromSeconds secounds: Int) -> String {
        if secounds <= 0 {
            return "00:00"
        }
        var min = Int(secounds / 60)
        let sec = secounds % 60
        var hour = 0
        if min >= 60 {
            hour = Int(min / 60)
            min = min - hour*60
            return String(format: "%d:%02d:%02d", hour, min, sec)
        }
        return String(format: "%02d:%02d", min, sec)
    }
    
    // 比例 <1%，Int(N%)
    static func getPercentageStr1(percentage: Double) -> String {
        var result = "\(Int(percentage*100))%"
        if percentage < 0.01 {
            result = "<1%"
        } else if percentage > 1 {
            result = ">100%"
        }
        return result
    }
    
    static func getDateStrDefault(timeStamp: Int) -> String {
        var result = ""
        let theBeginingTomorrow = getTimeStampOfTheBeginingToday() + 86400
        let theBeginingToday = getTimeStampOfTheBeginingToday()
        let theBeginingYestoday = getTimeStampOfTheBeginingToday() - 86400
        let theBeginingTwoDaysBefore = getTimeStampOfTheBeginingToday() - 86400*2
        
        switch timeStamp {
        case theBeginingToday..<theBeginingTomorrow:
            result = "今天"
        case theBeginingYestoday..<theBeginingToday:
            result = "昨天"
        case theBeginingTwoDaysBefore..<theBeginingYestoday:
            result = "前天"
        default:
            result = getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: "yy/M/d")
        }
        return result
    }
    
    static func getDateStrMD(timeStamp: Int) -> String {
        return getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: "M/d")
    }
    
    // 时间 HH:mm
    static func getTimeStrDefault(timeStamp: Int) -> String {
        let result = getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: "HH:mm")
        return result
    }
    
    static func getTimeStr12Hour(timeStamp: Int) -> String {
        let result = getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: "a h:mm")
        return result
    }
    
    // 日期+时间 默认日期 + 默认时间
    static func getDateAndTimeStrDefault(timeStamp: Int) -> String {
        let date = getDateStrDefault(timeStamp: timeStamp)
        let time = getTimeStrDefault(timeStamp: timeStamp)
        return "\(date) \(time)"
    }
    
    // 日期+时间 M/d HH:mm
    static func getDateAndTimeStrMdHHmm(timeStamp: Int) -> String {
        let result = getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: "M/d HH:mm")
        return result
    }
    
    static func getWeekOfYear(timeStamp: Int) -> String {
        let result = getTimeStrWithTimeStamp(timeStamp: timeStamp, dateFormat: "w")
        return result
    }

}
