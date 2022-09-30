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
//        let image = UIImage(named: "adding_background")
        
        let fileURL = Bundle.main.url(forResource: "iPhone7", withExtension: "png")!
//        AF.upload(fileURL, to: "https://httpbin.org/post").responseDecodable { (response) in
//            print("上传图片返回结果：", response)
//        }
        
        AF.upload(fileURL, to: "https://httpbin.org/post")
        
    }
    
    
    // MARK: - obj
    @objc func uploadData() {
        print("上传中...")
        
    }
    
    
}

//
//typealias UploadUserIconSuccess = (_ dict:[String : Any]) -> Void//成功block
//    
//    func uploadUserIcon(fileName: String, imgData: NSData, success:@escaping UploadUserIconSuccess, fail:@escaping FailedBlock ) {
//        let urlStr = HttpConfig.RequestUrlHeader.httpRequestUrlHeader + HttpConfig.RequestApi.uploadUserIconApi
//        
//     //请求头
//        let localToken = Tools.readFromUserDefault(key: localToken)!
//        // 头部需要的内容包装
//        let headers: HTTPHeaders = [
//            "Accept": "application/json;charset=utf-8",
//            "lang":"en-US",
//            "token": localToken
//        ]
//
//        Alamofire.upload(multipartFormData: { (formData) in
//            // 参数解释：
//            //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
//            formData.append(imgData as Data, withName: "fname", fileName: fileName, mimeType:"image/jpeg")
//            //如果需要上传多个文件,就多添加几个append,或则for-in语句进行循环处理
//// formData.append(imgData as Data, withName: "fname", fileName: fileName, mimeType:"image/jpeg")
////  formData.append(imgData as Data, withName: "fname", fileName: fileName, mimeType:"image/jpeg")
//        }, usingThreshold: (10*1024*1024), to: URL.init(string: urlStr)!, method: HTTPMethod.post, headers: headers) { (encodingResult) in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    if let jsonValue = response.result.value {
//                        let json = JSON(jsonValue)
//                        print("上传头像json:\(json)")
//                        let code = json["code"].int
//                        
//                        if code == HttpConfig.ErrorCode.HttpOK {
//                            let dict = json["data"].dictionaryObject
//                            success(dict!)
//                        } else {
//                            let msg = json["msg"].string
//                            HudToast.toastError(error: msg!)
//                        }
//                    }
//                }
//            case .failure(_):
//                self.networkErrorHint()
//            }
//        }
//    }
