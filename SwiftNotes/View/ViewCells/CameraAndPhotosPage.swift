//
//  CameraAndPhotos.swift
//  SwiftNotes
//
//  Created by GinsMac on 2022/9/13.
//  Copyright © 2022 GinsMac. All rights reserved.
//

import UIKit

class CSCameraAndPhotosPage: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // 1. 如上行，增加代理：UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
    let imageAddingBtn = UIButton()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        imageAddingBtn.set(superview: view, target: self, action: #selector(addImage))
        imageAddingBtn.setStyleAddingImage()
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
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //显示设置的照片
        imageView.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // 4. 在info.plist中增加一行⌜Privacy - Camera Usage Description⌟并填上描述，否则会崩溃
    
}


