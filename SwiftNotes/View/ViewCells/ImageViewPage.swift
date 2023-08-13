//
//  CSImageViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
// 含UIImage的笔记

class CSImageViewPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let image = UIImageView()
        image.set(superview: view, imageName: "big_MacStudio")
        image.setStyleNote()
        image.setFrame(left: 20, top: 20, right: 20, height: 300)
        
        let stretchMiddleImage = UIImageView()
        stretchMiddleImage.set(superview: view)
        stretchMiddleImage.setFrame(left: 20, top: 340, width: 78, height: 84)
        stretchMiddleImage.stretchMiddle(imageName: "stretchRect", left: 15, top: 15, right: 15, bottom: 15)
        /*
         以九宫格为参考，九宫格各区域：
         1  2  3
         4  5  6
         7  8  9
         left值，相当于1和2区域间划条竖线，1区域不拉伸
         right值，相当于2和3区域间划条竖线，3区域不拉伸
         top值，相当于1和4区域间划条横线，1区域不拉伸
         如left = 15，表示竖线左边(1/4/7)不提拉伸区域宽度为15pt
         */

        let stretchLeftAndRightImage = UIImageView()
        stretchLeftAndRightImage.set(superview: view)
        stretchLeftAndRightImage.setFrame(left: 20, top: stretchMiddleImage.bottom + 20, width: kScreenWidth - 40, height: 84)
        stretchLeftAndRightImage.stretchLeftAndRight(imageName: "stretchNotEqual", left: 0, top: 0, right: 0, bottom: 0, middleFixedWidth: 78, imageWidth: 232, ratio: 0.5)


        let stretchFiveSegmentImage = UIImageView()
        stretchFiveSegmentImage.set(superview: view)
        stretchFiveSegmentImage.setFrame(left: 20, top: stretchLeftAndRightImage.bottom + 20, width: kScreenWidth - 40, height: 84)
        stretchFiveSegmentImage.stretchLeftAndRight(imageName: "stretchFiveSegment", left: 10, top: 10, right: 10, bottom: 10, middleFixedWidth: 78, imageWidth: 222, ratio: 0.5)

        // 图片降分辨率 & 图片压缩
        let compressedImage = resetSizeOfImageData(UIImage(named: "big_MacStudio")!, maxSize: 100000)
    }
    
    
}

/*
 图片视图：
 默认会把图片内容拉伸以填满图片视图
 */


// 图片压缩
func resetSizeOfImageData(_ sourceImage: UIImage, maxSize: NSInteger) -> Data? {
    //先判断当前质量是否满足要求，不满足再进行压缩
    var finalImageData = sourceImage.jpegData(compressionQuality: 1.0)
    guard let sizeOrigin = finalImageData?.count else {
        return nil
    }
    let sizeOriginKB = sizeOrigin  / 1000
    if sizeOriginKB <= maxSize {
        return finalImageData
    }
    // 获取原图片宽高比
    let sourceImageAepectRatio = sourceImage.size.width / sourceImage.size.height
    // 先调整分辨率
    var defaultSize = CGSize(width: 1024, height: 1024 / sourceImageAepectRatio)
    guard let newImage = newSizeImage(defaultSize, sourceImage: sourceImage) else { return nil }
    finalImageData = newImage.jpegData(compressionQuality: 1.0)
    
    // 保存压缩系数
    var compressionQualityArr: [CGFloat] = []
    let avg: CGFloat = 1.0 / 250
    var value = avg
    for i in (1...250).reversed() {
        value = CGFloat(i) * avg
        compressionQualityArr.append(value)
    }
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    guard let imageData = halfFunction(compressionQualityArr, image: newImage, finalImageData: finalImageData, maxSize: maxSize) else {
        return nil
    }
    //如果还是未能压缩到指定大小，则进行降分辨率
    while imageData.count == 0 {
        // 每次降100分辨率
        let reduceW: CGFloat = 100.0
        let reduceH = 100.0 / sourceImageAepectRatio
        if defaultSize.width - reduceW <= 0 || defaultSize.height - reduceH <= 0 {
            break
        }
        defaultSize = CGSize(width: defaultSize.width - reduceW, height: defaultSize.height - reduceH)
        guard let last = compressionQualityArr.last,
            let imgData = newImage.jpegData(compressionQuality: last),
            let img = UIImage(data: imgData) else {
            break
        }
        
        let image = newSizeImage(defaultSize, sourceImage: img)
        finalImageData = halfFunction(compressionQualityArr, image: image, finalImageData: image?.jpegData(compressionQuality: 1.0), maxSize: maxSize)
    }
    return finalImageData
}

// 调整图片分辨率/尺寸（等比例缩放）
func newSizeImage(_ size: CGSize, sourceImage: UIImage) -> UIImage? {
    var newSize = CGSize(width: sourceImage.size.width, height: sourceImage.size.height)
    let tempH = newSize.height / size.height
    let tempW = newSize.width / size.width
    if tempW > 1.0, tempW > tempH {
        newSize = CGSize(width: sourceImage.size.width / tempW, height: sourceImage.size.height / tempW)
    } else if tempH > 1.0, tempW < tempH {
        newSize = CGSize(width: sourceImage.size.width / tempH, height: sourceImage.size.height / tempH)
    }
    UIGraphicsBeginImageContext(newSize)
    sourceImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}

func halfFunction(_ arr: [CGFloat], image: UIImage?, finalImageData: Data?, maxSize: NSInteger) -> Data? {
    var tempData = Data.init()
    var start = 0
    var end = arr.count - 1
    var index = 0
    var difference = NSInteger.max
    while start <= end {
        index = start + (end - start) / 2
        if let img = image, let finalImageData = img.jpegData(compressionQuality: arr[index]) {
            let sizeOrigin = finalImageData.count
            let sizeOriginKB = sizeOrigin / 1024
            print("当前降到质量\(sizeOriginKB)")
            print("\nstart：\(start)\nend：\(end)\nindex：\(index)\n压缩系数：\(String(format: "%.1f", arr[index]))")
            if sizeOriginKB > maxSize {
                start = index + 1
            } else if sizeOriginKB < maxSize {
                if maxSize - sizeOriginKB < difference {
                    difference = maxSize - sizeOriginKB
                    tempData = finalImageData
                }
                if index <= 0 {
                    break
                }
                end = index - 1
            }
        } else {
            break
        }
    }
    return tempData
}



//
//// 图片压缩
//func resetSizeOfImageData(_ sourceImage: UIImage, maxSize: NSInteger) -> Data? {
//    //先判断当前质量是否满足要求，不满足再进行压缩
//    var finalImageData = sourceImage.jpegData(compressionQuality: 1.0)
//    guard let sizeOrigin = finalImageData?.count else {
//        return nil
//    }
//    let sizeOriginKB = sizeOrigin  / 1000
//    if sizeOriginKB <= maxSize {
//        return finalImageData
//    }
//    // 获取原图片宽高比
//    let sourceImageAepectRatio = sourceImage.size.width / sourceImage.size.height
//    // 先调整分辨率
//    var defaultSize = CGSize(width: 1024, height: 1024 / sourceImageAepectRatio)
//    guard let newImage = newSizeImage(defaultSize, sourceImage: sourceImage) else { return nil }
//    finalImageData = newImage.jpegData(compressionQuality: 1.0)
//
//    // 保存压缩系数
//    var compressionQualityArr: [CGFloat] = []
//    let avg: CGFloat = 1.0 / 250
//    var value = avg
//    for i in (1...250).reversed() {
//        value = CGFloat(i) * avg
//        compressionQualityArr.append(value)
//    }
//    /*
//     调整大小
//     说明：压缩系数数组compressionQualityArr是从大到小存储。
//     */
//    //思路：使用二分法搜索
//    guard let imageData = halfFunction(compressionQualityArr, image: newImage, finalImageData: finalImageData, maxSize: maxSize) else {
//        return nil
//    }
//    //如果还是未能压缩到指定大小，则进行降分辨率
//    while imageData.count == 0 {
//        // 每次降100分辨率
//        let reduceW: CGFloat = 100.0
//        let reduceH = 100.0 / sourceImageAepectRatio
//        if defaultSize.width - reduceW <= 0 || defaultSize.height - reduceH <= 0 {
//            break
//        }
//        defaultSize = CGSize(width: defaultSize.width - reduceW, height: defaultSize.height - reduceH)
//        guard let last = compressionQualityArr.last,
//            let imgData = newImage.jpegData(compressionQuality: last),
//            let img = UIImage(data: imgData) else {
//            break
//        }
//
//        let image = newSizeImage(defaultSize, sourceImage: img)
//        finalImageData = halfFunction(compressionQualityArr, image: image, finalImageData: image?.jpegData(compressionQuality: 1.0), maxSize: maxSize)
//    }
//    return finalImageData
//}
//
//// 调整图片分辨率/尺寸（等比例缩放）
//func newSizeImage(_ size: CGSize, sourceImage: UIImage) -> UIImage? {
//    var newSize = CGSize(width: sourceImage.size.width, height: sourceImage.size.height)
//    let tempH = newSize.height / size.height
//    let tempW = newSize.width / size.width
//    if tempW > 1.0, tempW > tempH {
//        newSize = CGSize(width: sourceImage.size.width / tempW, height: sourceImage.size.height / tempW)
//    } else if tempH > 1.0, tempW < tempH {
//        newSize = CGSize(width: sourceImage.size.width / tempH, height: sourceImage.size.height / tempH)
//    }
//    UIGraphicsBeginImageContext(newSize)
//    sourceImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return newImage
//}
//
//func halfFunction(_ arr: [CGFloat], image: UIImage?, finalImageData: Data?, maxSize: NSInteger) -> Data? {
//    var tempData = Data.init()
//    var start = 0
//    var end = arr.count - 1
//    var index = 0
//    var difference = NSInteger.max
//    while start <= end {
//        index = start + (end - start) / 2
//        if let img = image, let finalImageData = img.jpegData(compressionQuality: arr[index]) {
//            let sizeOrigin = finalImageData.count
//            let sizeOriginKB = sizeOrigin / 1024
//            print("当前降到质量\(sizeOriginKB)")
//            print("\nstart：\(start)\nend：\(end)\nindex：\(index)\n压缩系数：\(String(format: "%.1f", arr[index]))")
//            if sizeOriginKB > maxSize {
//                start = index + 1
//            } else if sizeOriginKB < maxSize {
//                if maxSize - sizeOriginKB < difference {
//                    difference = maxSize - sizeOriginKB
//                    tempData = finalImageData
//                }
//                if index <= 0 {
//                    break
//                }
//                end = index - 1
//            }
//        } else {
//            break
//        }
//    }
//    return tempData
//}
