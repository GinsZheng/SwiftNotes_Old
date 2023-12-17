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

class CameraAndPhotosPage: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // 1. 如上行，增加代理：UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
    let imageAddingBtn = UIButton()
    let imageView = UIImageView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        imageAddingBtn.setup(superview: view, target: self, action: #selector(addImage))
        imageAddingBtn.setStyleSolid17ptFgWhiteThemeButton(title: "添加")
        imageAddingBtn.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 56)
        
        imageView.setup(superview: view, image: getImageWithColor(color: cDDDEE0))
        imageView.setCornerRadius(radius: kRadius)
        imageView.setFrame(centerX: view.centerX, top: 100, width: 200, height: 200)
    }
    
    
    
    // MARK: - 代理方法

    // 2.在代理中设置拍照/调用相册后的照片怎么用(和tableview代理一样的固定句式)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 获取编辑后的照片
        // let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        // 其中的editedImage要求代码中的⌜cameraPicker.allowsEditing⌟一定为true，否则将没有编辑后的照片，会崩
        
        // 获取原始照片
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //显示设置的照片
        imageView.image = originalImage
        
        
        // 相册上传：需要将相册图片先保存图片到Document目录下，生成文件url，再上传
        let uploadImageAPI = "https://go.ginkgeek.com/upload"
        let parameterName = "image"
        
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/image.jpg"
        let imageData = originalImage.jpegData(compressionQuality: 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)

        if (fileManager.fileExists(atPath: filePath)){
            //取得NSURL
            let imageNSURL = NSURL.init(fileURLWithPath: filePath) as URL
            
            struct ImageUploadResponse: Decodable {
                let code: String
                let message: String
                let imageURL: String
            }

            guard let fileURL = Bundle.main.url(forResource: "StarryNight", withExtension: "jpg") else { return }

            let url = "https://go.ginkgeek.com/upload"
            
            AF.upload(multipartFormData: { data in
                data.append(fileURL, withName: "image")
            }, to: url)
            .responseDecodable(of: ImageUploadResponse.self) { response in
                if let value = response.value {
                    let imageURL = value.imageURL
                    print("上传成功，图片URL：", imageURL)
                } else {
                    print("上传失败：", response.error!)
                }
            }
            
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - @objc func

    // 3.在选项表中调用函数 callCamera() callPhoto()
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
    
    // 4. 在info.plist中增加一行⌜Privacy - Camera Usage Description⌟并填上描述，否则会崩溃
    
}


