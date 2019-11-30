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

class JSONPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let baseInfo: [String : Any] = ["build_name":"置信·原墅",
                                        "build_address":"学院中路与金桥路交汇处东北侧",
                                        "build_num": 12,
                                        "room_num": 588,
                                        "area_address":"浙江省温州市鹿城区五马街道"]
        
        let jsonData = JSON(baseInfo)
        // 会得到创建好的 BuildBaseInfoModel类型的 对象model
        let model = BuildBaseInfoModel(jsonData: jsonData)
        print(model.build_name)
        print(model.build_address)
        print(model.build_num)
    }
    
    
}


struct BuildBaseInfoModel {
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

//struct BuildBaseInfoModel {
//    var build_name: String?
//    var build_address: String?
//    var build_num: String?
//    var room_num: String?
//    var area_address: String?
//
//    init(jsonData: JSON) {
//        build_name    = jsonData["build_name"].stringValue
//        build_address = jsonData["build_address"].stringValue
//        area_address  = jsonData["area_address"].stringValue
//        room_num      = jsonData["room_num"].stringValue
//        build_num     = jsonData["build_num"].stringValue
//    }
//}
