//
//  AlamofirePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2022/9/18.
//  Copyright © 2022 GinsMac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CSAlamofirePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 获取文本, 方法为 get
        AF.request("https://httpbin.org/get").responseJSON { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                // print("json", json)
                let origin = json["origin"].string ?? "(空)"
                let url = json["url"].string ?? "(空)"
                let headers = json["headers"]
                let userAgent = json["headers"]["User-Agent"].string ?? "(空)"
                let host = headers["Host"].string ?? "(空)"
                print("get 返回结果", "origin =", origin, ", url =", url, "userAgent =", userAgent, "host =", host)
            }
        }
        
        
        // 获取文本，方法为 post
        print("获取文本，post")
        AF.request("https://httpbin.org/post", method: .post).responseJSON { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                // print("json", json)
                let origin = json["origin"].string ?? "(空)"
                let url = json["url"].string ?? "(空)"
                print("post 返回结果", "origin =", origin, ", url =", url)
            }
        }

        
    }
    
    
}

