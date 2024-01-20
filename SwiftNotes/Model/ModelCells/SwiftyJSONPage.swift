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

class CSSwiftyJSONPage: UIViewController {
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 解析变量 (解析也叫反序列化)
        let baseInfo: [String : Any] = ["build_name":"置信·原墅",
                                        "build_address":"学院中路与金桥路交汇处东北侧",
                                        "build_num": 12,
                                        "room_num": 588,
                                        "area_address":"浙江省温州市鹿城区五马街道"]
        let jsonData = JSON(baseInfo) // 先序列化再解析
        let model = CSSwiftyModel1(jsonData: jsonData)
        print("Model itemName \(model.build_name)")
        
        
        // 解析本地文件
        let jsonFile = CSFileManager.readFileAsData(fileNameStr: "TestJSON", type: "json")
        let jsonData2 = JSON(jsonFile ?? "")
        let model2 = CSSwiftyModel2(jsonData: jsonData2)
        print("CSSwiftyModel2 id \(model2.id)")
        
        
        // 解析http传输的JSON
        let url = "https://httpbin.org/json"
        AF.request(url).responseDecodable(of: HttpbinJson.self) { response in
            if let value = response.value {
                let slideshow = value.slideshow
                let author = slideshow.author
                let title = slideshow.title
                print("获取结果:", "author =", author, ", slidesTitle =", title)
            } else {
                print(response.error!)
            }
        }
        
        struct HttpbinJson: Decodable {
            let slideshow: Slideshow
        }
        
        struct Slideshow: Decodable {
            let author: String
            let date: String
            let title: String
        }
        

        // 解析本地数据库的JSON
//        let itemTable = ItemTable()
//        let result = itemTable.getJSONOneRow(id: 10)
//        print(result)
//        let model4 = CSSwiftyModel4(jsonData: result)
//        print("CSSwiftyModel4 itemName \(model4.itemName)")
        
        
        
        /*
         序列化：解析的第一步就是完成序列化，如：
         let jsonData = JSON(baseInfo)
         let jsonData2 = JSON(jsonFile ?? "")
         let jsonData3 = JSON(value)
         */

    }
    

}

// 建模
struct CSSwiftyModel1 {
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


struct CSSwiftyModel2 {
    var id: [String]
    var arrivalTime: [String]
    var itemName: [String]
    
    init(jsonData: JSON) {
        id          = jsonData["result"].arrayValue.map {$0["id"].stringValue}
        arrivalTime = jsonData["result"].arrayValue.map {$0["arrivalTime"].stringValue}
        itemName        = jsonData["result"].arrayValue.map {$0["itemName"].stringValue}
    }
}


struct CSSwiftyModel4 {
    var id: Int
    var itemName: String
    var resume: String
    var totalProgress: Int
    var color: Int
    
    init(jsonData: JSON) {
        id = jsonData["id"].intValue
        itemName = jsonData["itemName"].stringValue
        resume = jsonData["resume"].stringValue
        totalProgress = jsonData["totalProgress"].intValue
        color = jsonData["color"].intValue
    }
}
/*
 数据结构如下：
 {
 "resume" : "4",
 "totalProgress" : 2,
 "color" : 3,
 "id" : 10,
 "itemName" : "Are you OK?"
 }
 */

