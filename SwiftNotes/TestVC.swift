//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TestVC: UIViewController {
    // 两件事：1.学着用Alamofire 。2.上传图片
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let image = UIImageView()
        image.set(superview: view, imageName: "iPhoneX")
        image.setStyleNote()
        image.setFrame(left: 20, top: 20, right: 20, height: 500)
        
        let btn = UIButton()
        btn.set(superview: view, target: self, action: #selector(uploadData))
        btn.setStyleSolidBtn(title: "上传")
        btn.setFrame(left: 20, top: image.bottom + 12, right: 20, height: 48)
        
        
        // 获取文本
        AF.request("https://httpbin.org/get").responseJSON { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                print("json", json)
                let origin = json["origin"].string ?? "(空)"
                let url = json["url"].string ?? "(空)"
                let headers = json["headers"]
                let userAgent = json["headers"]["User-Agent"].string ?? "(空)"
                let host = headers["Host"].string ?? "(空)"
                print("返回结果", "origin =", origin, ", url =", url, "userAgent =", userAgent, "host =", host)
            }
        }
     
//        // 获取文本
//        AF.request("https://httpbin.org/get").responseJSON { (response) in
//            if let value = response.result.value {
//                let json = JSON(value)
//                let probability = json["probability"].string ?? "0"
//                let link = json["link"].string ?? ""
//                let word = json["word"].string ?? ""
//            }
//        }
        
    }
    
    
    // MARK: - obj
    @objc func uploadData() {
        print("上传中...")
        
    }
    
    
}

