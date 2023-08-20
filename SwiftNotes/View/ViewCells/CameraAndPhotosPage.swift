//
//  CameraAndPhotos.swift
//  SwiftNotes
//
//  Created by GinsMac on 2022/9/13.
//  Copyright © 2022 GinsMac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CSCameraAndPhotosPage: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // 1. 如上行，增加代理：UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
    let imageAddingBtn = UIButton()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        imageAddingBtn.set(superview: view, target: self, action: #selector(addImage))
        imageAddingBtn.setStyleSolid17ptWhiteThemeButton(title: "添加")
        imageAddingBtn.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 56)
        
        imageView.set(superview: view, image: getImageWithColor(color: cDDDEE0))
        imageView.setCornerRadius(radius: 8)
        imageView.setFrame(centerX: view.centerX, top: 100, width: 200, height: 200)
        
    }
    
    // 2，在选项表中调用函数 callCamera() callPhoto()
    @objc func addImage() {
        actionSheet(actionsTitle: ["拍照", "从相册选取图片"], actionsStyle: [.default, .default], actionsHandler: [
            { _ in
                self.callCamera(allowsEditing: false, delegate: self)
            },
            
            { _ in
                self.callPhoto(allowsEditing: false, delegate: self)
            }
        ])
    }
    
    @objc func submit() {
        
    }
    
    // 3.在代理中设置拍照/调用相册后的照片怎么用(和tableview代理一样的固定句式)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 获取编辑后的照片
        // let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        // 其中的editedImage要求代码中的⌜cameraPicker.allowsEditing⌟一定为true，否则将没有编辑后的照片，会崩
        
        // 获取原始照片
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //显示设置的照片
        imageView.image = originalImage
        
        
        // 相册上传：需要将相册图片先保存图片到Document目录下，生成文件url，再上传
        let uploadImageAPI = "http://127.0.0.1:5000/upload_image"
        let parameterName = "file"
        
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/image.jpg"
        let imageData = originalImage.jpegData(compressionQuality: 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)

        if (fileManager.fileExists(atPath: filePath)){
            //取得NSURL
            let imageNSURL = NSURL.init(fileURLWithPath: filePath) as URL
            
//            AF.upload(multipartFormData: { (mutidata) in
//                mutidata.append(imageNSURL, withName: parameterName) // "file"是上传文件时参数的key
//            },
//                      to: uploadImageAPI).responseJSON { (response) in
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    // print("json", json)
//                    let image_url = json["image_url"].string ?? "(空)"
//                    print("上传文件(如上传图片) post 返回结果:", "image_url =", image_url)
//                }
//            }
            
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // 4. 在info.plist中增加一行⌜Privacy - Camera Usage Description⌟并填上描述，否则会崩溃
    
}


