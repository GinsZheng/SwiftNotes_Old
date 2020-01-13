//
//  HandyJSONPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/13.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON
import Alamofire

class HandyJSONPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 解析变量
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
        if let object = HandyModel1.deserialize(from: jsonString) {
            print(object.int)
            print(object.double)
            print(object.stringImplicitlyUnwrapped)
        }
        
        // 解析本地文件
        
        
        
    }
    
    
}



class HandyModel1: HandyJSON {
    var int: Int = 0
    var double: Double = 0.0
    var stringImplicitlyUnwrapped = ""

    required init() {}
}
