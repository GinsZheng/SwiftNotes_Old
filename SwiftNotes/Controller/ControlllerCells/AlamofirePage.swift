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

class CSAlamofirePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let titleArray: [String] = ["获取文本 get", "获取文本 post", "上传文本信息", "上传文件(如上传图片)"]
    
    let tableView = UITableView()
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
    }
    
    
    // MARK: - tableview 代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
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
            
        case "获取文本 post":
            // MARK: - 获取文本 post
            let url = "https://httpbin.org/post"
            AF.request(url, method: .post).responseDecodable(of: httpbinPost.self) { response in
                if let httpbinPost = response.value {
                    let origin = httpbinPost.origin
                    let url = httpbinPost.url
                    print("获取文本 post 返回结果:", "origin =", origin, ", url =", url)
                } else {
                    print(response.error!)
                }
            }
            
        case "上传文本信息":
            let url = "https://go.ginkgeek.com/feedbackInsert"
            let parameters = [
                "content": "我没意见",
                "modelType": kModelType,
                "systemVersion": kSystemVersion,
                "deviceModel": kDeviceModel,
                "appVersion": kAppVersion,
                "imageURLArray": "go.ginkgeek.com/uploaded/1b826e39-5439-11ee-befb-5254007b214e.png",
                "createdTime": getTimeStampNow()
            ]
            
            AF.request(url, method: .post, parameters: parameters).responseDecodable(of: SimpleResponse.self) { response in
                if let value = response.value {
                    let code = value.code
                    let message = value.message
                    print("获取结果:", "code =", code, ", message =", message)
                } else {
                    print(response.error!)
                }
            }
            
        case "上传文件(如上传图片)":
            // Bundle.main.url 可查到可以在工程文件->Build Phases->Copy Bundle Resource中看到
            guard let fileURL = Bundle.main.url(forResource: "StarryNight", withExtension: "jpg") else { return }
            let url = "https://go.ginkgeek.com/upload"
            
            AF.upload(multipartFormData: { data in
                data.append(fileURL, withName: "image") // 将图片文件添加到表单数据
            }, to: url)
            .responseDecodable(of: UploadResponse.self) { response in
                if let value = response.value {
                    let imageURL = value.imageURL
                    print("上传成功，图片URL：", imageURL)
                } else {
                    print("上传失败：", response.error!)
                }
            }
            
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(left: 20, right: 0)
        
        let cellTitle = UILabel()
        cellTitle.setup(superview: cell, text: titleArray[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.setup(superview: cell, imageName: kIconNext)
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
}



// MARK: - 建模
private struct HttpbinGet: Decodable {
    let origin: String
    let url: String
    let headers: HttpbinGetHeaders
}

private struct HttpbinGetHeaders: Decodable {
    let Accept: String
    let Host: String
}

private struct httpbinPost: Decodable {
    let origin: String
    let url: String
}


/*
 Post:文本替换原型
 
 let url = <#T##String#>
 let parameters = [
     "createdTime": getTimeStampNow()
 ]
 
 AF.request(url, method: .post, parameters: parameters).responseDecodable(of: SimpleResponse.self) { response in
     if let value = response.value {
         let code = value.code
         let message = value.message
         print("获取结果:", "code =", code, ", message =", message)
     } else {
         print(response.error!)
     }
 }
 */
