//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestVC: UIViewController {

    let pickerView = UIPickerView()
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        self.title = "Test"
        
//        // 时间转时间戳
//        //获取当前时间
//        let now = NSDate()
//
//        // 创建一个日期格式器
//        let dformatter = DateFormatter()
//        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
//        print("当前日期时间：\(dformatter.string(from: now as Date))")
//
//        //当前时间的时间戳
//        let timeInterval:TimeInterval = now.timeIntervalSince1970
//        let timeStamp = Int(timeInterval)
//        print("当前时间的时间戳：\(timeStamp)")
//
//
//        // 时间戳转时间
//        //时间戳
//        let timeStamp2 = 1463637809
//        print("时间戳：\(timeStamp)")
//
//        //转换为时间
//        let timeInterval2:TimeInterval = TimeInterval(timeStamp2)
//        let date = NSDate(timeIntervalSince1970: timeInterval2)
//
//        //格式话输出
//        let dformatter2 = DateFormatter()
//        dformatter2.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
//        print("对应的日期时间：\(dformatter.string(from: date as Date))")
//
//        // 打印
//        print("viewDidAppear")
        

        
        //        - (UIImage *)dc_stretchLeftAndRightWithContainerSize:(CGSize)size
        //        {
        //            CGSize imageSize = self.size;
        //            CGSize bgSize = size;
        //
        //            //1.第一次拉伸右边 保护左边
        //            UIImage *image = [self stretchableImageWithLeftCapWidth:imageSize.width *0.8 topCapHeight:imageSize.height * 0.5];
        //
        //            //第一次拉伸的距离之后图片总宽度
        //            CGFloat tempWidth = (bgSize.width)/2 + imageSize.width/2;
        //
        //            UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth, imageSize.height), NO, [UIScreen mainScreen].scale);
        //
        //            [image drawInRect:CGRectMake(0, 0, tempWidth, bgSize.height)];
        //
        //            //拿到拉伸过的图片
        //            UIImage *firstStrechImage = UIGraphicsGetImageFromCurrentImageContext();
        //            UIGraphicsEndImageContext();
        //
        //            //2.第二次拉伸左边 保护右边
        //            UIImage *secondStrechImage = [firstStrechImage stretchableImageWithLeftCapWidth:firstStrechImage.size.width *0.1 topCapHeight:firstStrechImage.size.height*0.5];
        //
        //            return secondStrechImage;
        
        //    }
        
        
//        let stretchImage = UIImageView()
//        stretchImage.set(superview: view)
//        stretchImage.setFrame(left: 20, top: 20, width: 390, height: 300)
//        stretchImage.stretchMiddle(imageName: "stretchRect", left: 15, top: 15, right: 15, bottom: 15)
//        stretchImage.stretchLeftAndRight()
        
//        let middleimage = getImageFromView(view: stretchImage)
        
//        let finalImage = UIImageView()
//        finalImage.set(superview: view, image: middleimage)
//        finalImage.setFrame(left: 20, top: 400, width: 280, height: 280)
        
        
//        let middleImageView = UIImageView()
//        middleImageView.set(superview: view)
//        middleImageView.setFrame(left: 20, top: 0, width: (335/2 + 76/2 + 52), height: 84)
//        let middleImage = UIImage(named: "stretchLeftAndRight")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 76 + 52, bottom: 0, right: 0), resizingMode: .stretch)
//        middleImageView.image = middleImage
//
//        let imageTrans = getImageFromView(view: middleImageView)
//
//        let finalImageView = UIImageView()
//        finalImageView.set(superview: view)
//        finalImageView.setFrame(left: 20, top: 200, width: 335, height: 84)
//        let finalImage = imageTrans.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 335/2 + 76/2), resizingMode: .stretch)
//        finalImageView.image = finalImage
        
    }
    
}
