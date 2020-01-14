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
        if let jsonData = HandyModel1.deserialize(from: jsonString) {
            print(jsonData.int)
            print(jsonData.double)
            print(jsonData.stringImplicitlyUnwrapped)
        }
        
        // 解析本地文件
//        let jsonFile = FileManager.readLocalFile(fileNameStr: "TestJSON", type: "json")
//        let str = String(data: jsonFile as! Data, encoding: .utf8)
//
//        if let jsonData2 = HandyModel2.deserialize(from: str) {
//            print(jsonData2.id)
//        }

        
        // 序列化
        let model1 = HandyModel1()
        model1.int = 1
        model1.double = 2.2
        model1.stringImplicitlyUnwrapped = "heihei"
        
        print(model1.toJSON()!)
        
//        let itemsModel = ItemsModel()
//        itemsModel.rowid =

        
    }
    
    
}



class HandyModel1: HandyJSON {
    var int: Int = 0
    var double: Double = 0.0
    var stringImplicitlyUnwrapped = ""

    required init() {}
}

