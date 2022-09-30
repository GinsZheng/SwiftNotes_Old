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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.setBackgroundColor(color: cFFF)
        
        // MARK: - 获取文本, 方法为 get
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
        
        
        // MARK: - 获取文本，方法为 post
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

        
        // MARK: - 上传文本信息，方法为 post
        print("上传文本信息，方法为 post")
        let parameters = [
            "username": "GinsMac",
            "phone": "13311112222"
        ]
        
        AF.request("http://127.0.0.1:5000/feedback", method: .post, parameters: parameters).responseJSON { (response) in
            print("上传文本信息，返回结果", response)
        }

        
        // MARK: - 上传图片
        print("上传图片")
        
        
        
        
    }
    
}

