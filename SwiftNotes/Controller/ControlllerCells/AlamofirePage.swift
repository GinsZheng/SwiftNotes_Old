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

import UIKit

class CSAlamofirePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct HttpbinGet: Decodable {
        let origin: String
        let url: String
        let headers: HttpbinGetHeaders
    }

    struct HttpbinGetHeaders: Decodable {
        let Accept: String
        let Host: String
    }

    
    let titleArray: [String] = ["获取文本 get", "获取文本 post", "上传文本信息", "上传文件(如上传图片)"]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)

        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
        
    }
    
    
    // MARK: - tableview 代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch titleArray[indexPath.row] {
        case "获取文本 get":
            // MARK: - 获取文本 get
            let url = "https://httpbin.org/get"
            AF.request(url).responseDecodable(of: HttpbinGet.self) { response in
                if let httpbinGet = response.value {
                    let origin = httpbinGet.origin
                    let url = httpbinGet.url
                    let headers = httpbinGet.headers
                    let accept = headers.Accept
                    let host = headers.Host
                    print("请求成功", origin, url, accept, host)
                    print("请求成功", headers)
                } else {
                    print(response.error!)
                }
            }
            
//        case "获取文本 post":
//            AF.request("https://httpbin.org/post", method: .post).responseJSON { (response) in
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    // print("json", json)
//                    let origin = json["origin"].string ?? "(空)"
//                    let url = json["url"].string ?? "(空)"
//                    print("获取文本 post 返回结果:", "origin =", origin, ", url =", url)
//                }
//            }
//        case "上传文本信息":
//            let parameters = [
//                "username": "GinsMac",
//                "phone": "13311112222"
//            ]
//            
//            AF.request("http://127.0.0.1:5000/feedback", method: .post, parameters: parameters).responseJSON { (response) in
//                print("上传文本信息，返回结果:", response)
//            }
//            
//        case "上传文件(如上传图片)":
//            
//            // Bundle.main.url 可查到可以在工程文件->Build Phases->Copy Bundle Resource中看到
//            let fileURL = Bundle.main.url(forResource: "StarryNight", withExtension: "jpg")!
//            
//            AF.upload(multipartFormData: { (mutidata) in
//                mutidata.append(fileURL, withName: "file") // "file"是上传文件时参数的key
//            },
//                      to: "http://127.0.0.1:5000/upload_image").responseJSON { (response) in
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    // print("json", json)
//                    let image_url = json["image_url"].string ?? "(空)"
//                    print("上传文件(如上传图片) post 返回结果:", "image_url =", image_url)
//                }
//            }
//            
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(leftInset: 20, rightInset: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: titleArray[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
}

