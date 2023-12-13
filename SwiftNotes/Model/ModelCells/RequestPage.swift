//
//  CSRequestPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/13.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class CSRequestPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var slidesTitle = [String]()
    var slidesType = [String]()
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        simpleRequest() // MARK: - 简单请求
        normalRequest() // MARK: - 常见请求
        
    }
    
    
    // MARK: - func
    
    func simpleRequest() {
        let url = "https://go.ginkgeek.com/firstRequest"
        AF.request(url).responseDecodable(of: Slides.self) { response in
            if let slides = response.value {
                let code = slides.code
                let message = slides.message
                print("code", code, "message", message)
            } else {
                print(response.error!)
            }
        }
        
        /*
         新的请求方式的好处：简化了许多操作：1. struct无需初始化 2. AF的代码简化了许多
         新请求的构成：1. struct 2. AF.request
         */
        
        /*
         User.self是啥，为什么不是User：
         1. responseDecodable需要一个明确的类型参数,直接传递User会被当成实例而不是类型。
         2. 使用User.self可以获取User类型的元类型,让Alamofire知道需要解析成User类型的实例。
         3. Type.self在Swift中是一个常见的用法,用来表示一个明确的类型,而不是该类型的实例。
         */
    }
    
    func normalRequest() {
        let url2 = "https://httpbin.org/json"
        AF.request(url2).responseDecodable(of: SlideshowResponse.self) { response in
            if let slideshow = response.value {
                let slides = slideshow.slideshow.slides
                
                for slide in slides {
                    let title = slide.title
                    let type = slide.type
                    print("Title: \(title), Type: \(type)")
                }
            } else {
                print("Error:", response.error!)
            }
        }
        
        /*
         多层级的请求：
         1. 建立多个struct，每层一个。从最子层开始建立。父层使用子层的Struct，如上面的[Slide]
         2. AF中多层调用，如 slideshow.slideshow.slides
         */
        
    }
    
    
    // MARK: - tableView代理方法
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(left: 20, right: 0)
        cell.selectionStyle = .none // 无按下效果
        
        let cellTitle = UILabel()
        cellTitle.setup(superview: cell, text: slidesTitle[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.setup(superview: cell, imageName: "next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slidesTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: CSGeneralSubpage())
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



// MARK: - 建模

private struct Slides: Decodable {
    let code: String // 注意，这里的 code 与 json 中的key要完全相等，否则报错(即就是用这个code值来判断要匹配哪个value)
    let message: String
}

private struct SlideshowResponse: Decodable {
    let slideshow: Slideshow
}

private struct Slideshow: Decodable {
    let author: String
    let date: String
    let slides: [Slide]
    let title: String
}

private struct Slide: Decodable {
    let title: String
    let type: String
}



// MARK: - 旧的请求方式如下

/*
 let url = "https://httpbin.org/json"
 AF.request(url).responseJSON { (response) in
     if let value = response.result.value {
         let jsonData3 = JSON(value)
         let model3 = CSSwiftyModel3(jsonData: jsonData3)
         self.slidesTitle = model3.slidesTitle
         self.slidesType = model3.slidesType
         print("CSSwiftyModel3 slidesTitle \(model3.slidesTitle)")

         self.tableView.setup(superview: self.view, delegate: self, dataSource: self, viewController: self)
         self.tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
         self.tableView.contentSize = CGSize(width: kScreenWidth, height: kCellHeight * CGFloat(self.slidesTitle.count))
     }

 }

 */
