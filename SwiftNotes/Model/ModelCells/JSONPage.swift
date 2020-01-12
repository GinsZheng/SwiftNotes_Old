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

class JSONPage: UIViewController {
    
    // 读取本地JSON文件

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 解析JSON数组|字典
        let baseInfo: [String : Any] = ["build_name":"置信·原墅",
                                        "build_address":"学院中路与金桥路交汇处东北侧",
                                        "build_num": 12,
                                        "room_num": 588,
                                        "area_address":"浙江省温州市鹿城区五马街道"]
        let jsonData = JSON(baseInfo)
        let model = Model(jsonData: jsonData)
        print("Model2 id \(model.build_name)")
        
        
        // 解析JSON本地文件
        let file = FileManager.readLocalFile(fileNameStr: "TestJSON", type: "json")
        let jsonData2 = JSON(file ?? "")
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
    }
    

}


// 解析JSON(单数据)
struct Model {
    var build_name: String
    var build_address: String
    var build_num: Int
    var room_num: Int
    var area_address: String
    
    init(jsonData: JSON) {
        build_name    = jsonData["build_name"].string ?? ""
        build_address = jsonData["build_address"].string ?? ""
        room_num      = jsonData["room_num"].int ?? 0
        build_num     = jsonData["build_num"].int ?? 0
        area_address  = jsonData["area_address"].string ?? ""
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
