//
//  Formatter.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSFormatter {

    static func getMinite(fromSecond second: Int) -> Int {
        return Int(round(Double(second) / 60))
    }

    
}

