//
//  GlobalClass.swift
//  MySwift
//
//  Created by GinsMac on 2019/8/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class Regex {
    static func test(pattern: String, testedText: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern)
        let resultNum = regex.numberOfMatches(in: testedText, range: NSRange(location: 0, length: testedText.count))
        
        if resultNum >= 1 {
            return true
        } else {
            return false
        }
    }
    
    static func matches(pattern: String, testedText: String) -> [NSTextCheckingResult] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let matchedResults = regex.matches(in: testedText, range: NSRange(location: 0, length: testedText.count))
        return matchedResults
    }
    
    static func replaceMatches(pattern: String, testedText: String, replaceWith: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern)
        let replacingResult = regex.stringByReplacingMatches(in: testedText, range: NSRange(location: 0, length: testedText.count), withTemplate: replaceWith)
        return replacingResult
    }

}
