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
        
        
        // MARK: - 上传文件(如上传图片)
        print("上传图片")
        
        // Bundle.main.url 可查到可以在工程文件->Build Phases->Copy Bundle Resource中看到
        let fileURL = Bundle.main.url(forResource: "StarryNight", withExtension: "jpg")!
        
        AF.upload(multipartFormData: { (mutidata) in
            mutidata.append(fileURL, withName: "file")
        },
                  to: "http://127.0.0.1:5000/upload_image").responseJSON { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                // print("json", json)
                let image_url = json["image_url"].string ?? "(空)"
                print("post 返回结果", "image_url =", image_url)
            }
        }
        
        
        
        
    }
    
    
    // MARK: - obj
    @objc func uploadData() {
        print("上传中...")
        
    }
    
    
}
