//
//  Extension.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/25.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation

extension String {
    func removeFirstCharacter() -> String {
        return String(self[self.index(after: self.startIndex)...])
    }
    
    func removeFrontCharacters(length: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: length-1)])
    }
    
}

