//
//  JSONPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/26.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SwiftyJSON
import Alamofire
import UIKit
import Foundation

class SwiftyJSONPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 解析变量 (解析也叫反序列化)
        let baseInfo: [String : Any] = ["build_name":"置信·原墅",
                                        "build_address":"学院中路与金桥路交汇处东北侧",
                                        "build_num": 12,
                                        "room_num": 588,
                                        "area_address":"浙江省温州市鹿城区五马街道"]
        let jsonData = JSON(baseInfo) // 先序列化再解析
        let model = Model(jsonData: jsonData)
        print("Model name \(model.build_name)")
        
        
        // 解析本地文件
        let jsonFile = FileManager.readLocalFile(fileNameStr: "TestJSON", type: "json")
        let jsonData2 = JSON(jsonFile ?? "")
        let model2 = Model2(jsonData: jsonData2)
        print("Model2 id \(model2.id)")
        
        
        // 解析http传输的JSON
        let url = "https://httpbin.org/json"
        AF.request(url).responseJSON { (response) in
            if let value = response.result.value {
                let jsonData3 = JSON(value)
                let model3 = Model3(jsonData: jsonData3)
                print("Model3 slidesTitle \(model3.slidesTitle)")
            }
        }
        
        
        
        /*
         序列化：解析的第一步就是完成序列化，如：
         let jsonData = JSON(baseInfo)
         let jsonData2 = JSON(jsonFile ?? "")
         let jsonData3 = JSON(value)
         */

    }
    

}

// 建模
struct Model {
    var build_name: String
    var build_address: String
    var build_num: Int
    var room_num: Int
    var area_address: String
    
    init(jsonData: JSON) {
        build_name    = jsonData["build_name"].stringValue
        build_address = jsonData["build_address"].string ?? ""
        room_num      = jsonData["room_num"].intValue
        build_num     = jsonData["build_num"].int ?? 0
        area_address  = jsonData["area_address"].stringValue
        // .stringValue 等价于 .string ?? "" ，即自动填充默认值""
        // .intValue 等价于 .int ?? 0
        // .arrayValue 等价于 .array ?? []
    }
}


struct Model2 {
    var id: [String]
    var arrivalTime: [String]
    var name: [String]
    
    init(jsonData: JSON) {
        id          = jsonData["result"].arrayValue.map {$0["id"].stringValue}
        arrivalTime = jsonData["result"].arrayValue.map {$0["arrivalTime"].stringValue}
        name        = jsonData["result"].arrayValue.map {$0["name"].stringValue}
    }
}


struct Model3 {
    var author: String
    var date: String
    var slidesTitle: [String]
    var slidesType: [String]
    
    init(jsonData: JSON) {
        author = jsonData["slideshow"]["author"].string ?? ""
        date = jsonData["slideshow"]["date"].string ?? ""
        slidesTitle = jsonData["slideshow"]["slides"].arrayValue.map {$0["title"].stringValue}
        slidesType = jsonData["slideshow"]["slides"].arrayValue.map {$0["type"].stringValue}
    }
}
