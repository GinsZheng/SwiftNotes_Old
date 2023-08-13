//
//  AddStyleAttribute.swift
//  MySwift
//
//  Created by GinsMac on 2019/6/2.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /* @objc
     1.加上@objc后，extesion中的函数才可被子类override
     2.加上@objc修饰后的类型,可以直接供Objective-C调用
     */
    @objc func set(superview: UIView) {
        superview.addSubview(self)
    }
    
    func set(superview: UIView, backgroundColor: String) {
        superview.addSubview(self)
        self.setBackgroundColor(color: backgroundColor)
    }
    
    func setShadow(color: String = cShadowColor, x: CGFloat = 0, y: CGFloat, radius: CGFloat) {
        self.layer.shadowColor = UIColor.hex(color).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = radius / 2.1
    }
    
    func setBorder(color: String, borderWidth: CGFloat) {
        self.layer.borderColor = UIColor.hex(color).cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func setCornerRadiusWithMask(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setCellCornerRadius(radius: CGFloat, index: Int, maxIndex: Int) {
        if index == 0 {
            self.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        }
        else if index == maxIndex {
            self.setEachCornerRadiusWithMask(radius: 10, corners: [.bottomLeft, .bottomRight])
        }
        else {
            return
        }
    }
    
    func setEachCornerRadiusWithMask(radius: CGFloat, corners: UIRectCorner) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        // 注：单独设置4个角时必须加mask，否则不生效
        // 必须写在setFrame之后
    }
    
    func setBackgroundColor(color: String) {
        self.backgroundColor = UIColor.hex(color)
    }
    
    func setSeparator(leftInset: CGFloat, rightInset: CGFloat, color: String = c000820_10_separator) {
        let separator = UIView()
        self.addSubview(separator)
        separator.setFrame(left: leftInset, bottom: 0, width: kScreenWidth - leftInset - rightInset, height: kSeparatorHeight)
        separator.backgroundColor = UIColor.hex(color)
    }
    
    func setGradientLayer(colors: [CGColor]?, locations: [NSNumber]?, startPoint: CGPoint, endPoint: CGPoint, zIndex: UInt32 = 0) {
        /* eg:
         colors: [UIColor.hex(cBlue_5393FF).cgColor, UIColor.hex(cPurple_BF62F8).cgColor,  UIColor.hex(cRed_FF635A).cgColor]
         locations: [0, 0.3, 1]
         startPoint: CGPoint.init(x: 0, y: 0)
         endPoint: CGPoint.init(x: 1, y: 1)
         注：要写在setFrame之后
         */
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint  = endPoint
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: self.width, height: self.height)
        self.layer.insertSublayer(gradientLayer, at: zIndex)
    }
    
    func removeGradientLayer() {
        self.layer.sublayers?[0].removeFromSuperlayer()
    }
    
    func resetGradientLayer(colors: [CGColor]?, locations: [NSNumber]?, startPoint: CGPoint, endPoint: CGPoint, zIndex: UInt32 = 0) {
        self.removeGradientLayer()
        self.setGradientLayer(colors: colors, locations: locations, startPoint: startPoint, endPoint: endPoint, zIndex: zIndex)
    }
    
    func removeAllSubviews() {
        _ = self.subviews.map {
            $0.removeFromSuperview()
        }
    }
    
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set {
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set {
            self.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        } set {
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        } set {
            self.frame.size.height = newValue
        }
    }
    
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        } set {
            self.frame.origin.x = newValue
        }
    }
    
    var top: CGFloat {
        get {
            return self.frame.origin.y
        } set {
            self.frame.origin.y = newValue
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        } set {
            self.center.x = newValue
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        } set {
            self.center.y = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        } set {
            self.frame.origin.x = self.superview!.width - self.width - newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return y + height
        } set {
            self.frame.origin.y = self.superview!.height - self.height - newValue
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame.size = newValue
        }
    }
    
    var point: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame.origin = newValue
        }
    }
    
    func touchesMovedUp(touches: Set<UITouch>, action: () -> Void) {
        for touch in touches {
            let previousPoint = touch.previousLocation(in: self)
            let point = touch.location(in: self)
            let pointsGap = point.y - previousPoint.y
            
            if pointsGap < 0 {
                action()
            }
        }
    }
    
    func touchesMovedDown(touches: Set<UITouch>, action: () -> Void) {
        for touch in touches {
            let previousPoint = touch.previousLocation(in: self)
            let point = touch.location(in: self)
            let pointsGap = point.y - previousPoint.y
            
            if pointsGap > 0 {
                action()
            }
        }
    }
    
    func touchesMovedUpOrDwon(touches: Set<UITouch>, action: () -> Void) {
        for touch in touches {
            let previousPoint = touch.previousLocation(in: self)
            let point = touch.location(in: self)
            let pointsGap = point.y - previousPoint.y
            
            if pointsGap != 0 {
                action()
            }
        }
    }

    func touchesMovedLeft(touches: Set<UITouch>, action: () -> Void) {
        for touch in touches {
            let previousPoint = touch.previousLocation(in: self)
            let point = touch.location(in: self)
            let pointsGap = point.x - previousPoint.x
            
            if pointsGap < 0 {
                action()
            }
        }
    }
    
    func touchesMovedRight(touches: Set<UITouch>, action: () -> Void) {
        for touch in touches {
            let previousPoint = touch.previousLocation(in: self)
            let point = touch.location(in: self)
            let pointsGap = point.x - previousPoint.x
            
            if pointsGap > 0 {
                action()
            }
        }
    }
    
    func touchesMovedLeftOrRight(touches: Set<UITouch>, action: () -> Void) {
        for touch in touches {
            let previousPoint = touch.previousLocation(in: self)
            let point = touch.location(in: self)
            let pointsGap = point.x - previousPoint.x
            
            if pointsGap != 0 {
                action()
            }
        }
    }
    
    func getTouchPoint(touches: Set<UITouch>) -> CGPoint {
        var point = CGPoint(x: 0, y: 0)
        for touch in touches {
            point = touch.location(in: self)
            print("point \(point)")
        }
        return point
    }
    
    func sendToback() {
        self.superview?.sendSubviewToBack(self)
    }
    
    func bringToFront() {
        self.superview?.bringSubviewToFront(self)
    }
}




extension UILabel {
    
    func set(superview: UIView, text: String, numberOfLines: Int = 1) {
        self.text = text
        superview.addSubview(self)
        self.numberOfLines = numberOfLines
    }
    
    func setText(text: String, numberOfLines: Int = 1) {
        self.text = text
        self.numberOfLines = numberOfLines
    }
    
    func setFontStyle(size: CGFloat, color: String, weight: UIFont.Weight = .regular, alignment: NSTextAlignment = .left) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = UIColor.hex(color)
        self.textAlignment = alignment
    }
    
    func getTextHeight(withWidth width: CGFloat) -> CGFloat {
        _ = self.text! as NSString
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let height = self.sizeThatFits(size).height
        return CGFloat(Int(height) + 1)
    }
    
    func setLineHeight(multiple: CGFloat = 1.4) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = multiple / 1.194
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraph]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: attributes)
    }
    
    func getLabelWidth() -> CGFloat {
        let labelText = self.text as NSString? ?? ""
        let size = CGSize(width: CGFloat(MAXFLOAT), height: self.frame.size.height)
        let textSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!], context: nil).size
        return CGFloat(Int(textSize.width) + 1)
    }
    
    func getLabelWidth(withMaxWidth maxWidth: CGFloat) -> CGFloat {
        let labelText = self.text as NSString? ?? ""
        let size = CGSize(width: CGFloat(MAXFLOAT), height: self.frame.size.height)
        let textSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!], context: nil).size
        var labelWidth = CGFloat(Int(textSize.width) + 1)
        if labelWidth > maxWidth {
            labelWidth = maxWidth
        }
        return labelWidth
    }
    
    func getDefaultLineheight() -> CGFloat {
        return round(self.font.pointSize * 1.4)
    }
    
    func setAsMultipleLines(numberOfLines: Int, lineMultiple: CGFloat = 1.4) {
        self.numberOfLines = numberOfLines
        self.lineBreakMode = .byWordWrapping
        self.setLineHeight(multiple: lineMultiple)
    }
    
    func setKern(wordSpace: CGFloat) {
        guard let content = self.text else {return}
        let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: content)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: wordSpace, range: NSMakeRange(0, (content.count)))
        self.attributedText = attributedString
    }
    
    func setMultiStyle(specialText: String, size: CGFloat, color: String, weight: UIFont.Weight = .regular, baselineOffset: CGFloat) {
        let string = self.text ?? ""
        let ranStr = specialText
        let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:string)
        let str = NSString(string: string)
        let theRange = str.range(of: ranStr)
        attrstring.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.hex(color), range: theRange)
        attrstring.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: size, weight: weight), range: theRange)
        attrstring.addAttribute(NSAttributedString.Key.baselineOffset, value: baselineOffset, range: theRange)
        self.attributedText = attrstring
    }
    
}



extension UITextView {
    
    func set(superview: UIView, text: String, maxLines: Int, interaction: Bool = false) {
        self.text = text
        self.isUserInteractionEnabled = interaction
        superview.addSubview(self)
        self.textContainer.maximumNumberOfLines = maxLines
        self.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    func setFontStyle(size: CGFloat, color: String, weight: UIFont.Weight = UIFont.Weight.regular, alignment: NSTextAlignment = .left, lineHeight: CGFloat = 1.4) {
        self.setLineHeight(multiple: lineHeight)
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = UIColor.hex(color)
        self.textAlignment = alignment
        self.textContainerInset = UIEdgeInsets(top: -0.5*size*(lineHeight - 1.194), left: -5, bottom: 0, right: -5)
    }
    
    func setLineHeight(multiple: CGFloat = 1.4) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = multiple / 1.194
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraph]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: attributes)
    }
    
    func setKern(wordSpace: CGFloat) {
        guard let content = self.text else {return}
        let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: content)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: wordSpace, range: NSMakeRange(0, (content.count)))
        self.attributedText = attributedString
    }
    
    func setLineHeightAndKern(lineHeight: CGFloat = 1.4, kern: CGFloat = -0.4) {
        guard let content = self.text else {return}
        let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: content)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = lineHeight / 1.194
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraph, range: NSMakeRange(0, (content.count)))
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kern, range: NSMakeRange(0, (content.count)))
        self.attributedText = attributedString
    }
    
    func getTextHeight(withWidth width: CGFloat) -> CGFloat {
        _ = self.text! as NSString
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let height = self.sizeThatFits(size).height
        return CGFloat(Int(height) + 1)
    }
    

    
}



extension UITextField {
    
    func set(superview: UIView, placeholder: String, delegate: UITextFieldDelegate?, text: String? = nil, textColor: String = cMainBlack, isUserInteractionEnabled: Bool = true) {
        self.placeholder = placeholder
        self.delegate = delegate
        self.text = text
        self.textColor = .hex(textColor)
        self.isUserInteractionEnabled = isUserInteractionEnabled
        superview.addSubview(self)
    }
    
    var placeholderColor:UIColor {
        get {
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;
        } set {
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    func setTextLeftPadding(left: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.height))
        self.leftViewMode = .always
    }
    
    func setTextRightPadding(right: CGFloat) {
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.height))
        self.rightViewMode = .always
    }
    
    func setTextPadding(left: CGFloat, right: CGFloat) {
        self.setTextLeftPadding(left: left)
        self.setTextRightPadding(right: right)
    }
    
    func isTextValueGreaterThan(_ comparedValue: Int) -> Bool {
        let textValue = Int(self.text ?? "")
        if textValue != nil {
            if textValue! > comparedValue {
                return true
            }
        }
        return false
    }
    
    func isTextValueGreaterThanOrEqualTo(_ comparedValue: Int) -> Bool {
        let textValue = Int(self.text ?? "")
        if textValue != nil {
            if textValue! >= comparedValue {
                return true
            }
        }
        return false
    }
    
    func isTextValueLessThan(_ comparedValue: Int) -> Bool {
        let textValue = Int(self.text ?? "")
        if textValue != nil {
            if textValue! < comparedValue {
                return true
            }
        }
        return false
    }
    
    func isTextValueLessThanOrEqualTo(_ comparedValue: Int) -> Bool {
        let textValue = Int(self.text ?? "")
        if textValue != nil {
            if textValue! <= comparedValue {
                return true
            }
        }
        return false
    }

    func isInputtedIntValue() -> Bool {
        guard let text = self.text else {
            return false
        }

        guard let _ = Int(text) else {
            return false
        }
        return true
    }
    
}



extension UIImageView {
    
    func set(superview: UIView, imageName: String, cornerRadius: CGFloat = 0, conteneMode: UIView.ContentMode = .scaleAspectFill) {
        self.image = UIImage(named: imageName)
        superview.addSubview(self)
        self.contentMode = conteneMode
        if cornerRadius > 0 {
            self.setCornerRadiusWithMask(radius: cornerRadius)
        }
    }
    
    func set(superview: UIView, image: UIImage, cornerRadius: CGFloat = 0, conteneMode: UIView.ContentMode = .scaleAspectFill) {
        self.image = image
        superview.addSubview(self)
        self.contentMode = conteneMode
        if cornerRadius > 0 {
            self.setCornerRadiusWithMask(radius: cornerRadius)
        }
    }
    
    // 拉伸图片中部，需写在setFrame之后
    func stretchMiddle(imageName: String, left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        let image = UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right), resizingMode: .stretch)
        self.image = image
    }
    
    // 五段式拉伸：图片从左到右分五段，拉伸2、4两段
    func stretchLeftAndRight(imageName: String, left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat, middleFixedWidth: CGFloat, imageWidth: CGFloat, ratio: CGFloat) {
        // ratio 如：ratio = 2 指：左边拉伸宽度/右边拉伸宽度 = 2
        // ratio = 2时，需要设计图上拉伸区域的比例也是 2:1
        let iW = imageWidth
        let sW = self.width
        let L = left
        let R = right
        let M = middleFixedWidth
        let r = ratio
        let LB = (iW - L - M - R) / (1 + 1/r) // leftWidthBeforeStretch
        let LA = (sW - L - M - R) / (1 + 1/r) // leftWidthAfterStretch
        let RA = (sW - L - M - R) / (1 + r) // rightWidthAfterStretch
        
        let middleImageView = UIImageView()
        middleImageView.setFrame(left: 0, top: 0, width: sW - (LA - LB), height: self.height)
        let middleImage = UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets(top: top, left: L + LB + M, bottom: bottom, right: right), resizingMode: .stretch) // 左边固定，拉伸右边
        middleImageView.image = middleImage
        let translatedMiddleImage = getImageFromView(view: middleImageView)

        let finalImage = translatedMiddleImage.resizableImage(withCapInsets: UIEdgeInsets(top: top, left: left, bottom: bottom, right: R + RA + M), resizingMode: .stretch) // 右边固定，拉伸左边
        self.image = finalImage
        
    }
        
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
    // 横向虚线
    func setDashedLine(color: String, dash: CGFloat, gap: CGFloat, lineCap: CGLineCap = .butt) {
        // 前置：setFrame
        UIGraphicsBeginImageContextWithOptions(self.size, false, kScale)
        self.image?.draw(in: self.bounds)
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.setLineCap(lineCap)
        
        let lengths:[CGFloat] = [dash, gap] // 绘制 跳过 无限循环
        
        var phase: CGFloat {
            if lineCap == .butt {
                return 0
            } else {
                return -height/2
            }
        }
        
        context.setStrokeColor(UIColor.hex(color).cgColor)
        context.setLineWidth(self.height)
        context.setLineDash(phase: phase, lengths: lengths)
        context.move(to: CGPoint(x: 0, y: self.height/2))
        context.addLine(to: CGPoint(x: self.width, y: self.height/2))
        context.strokePath()
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}



extension UIImage {
   /* 限定图片的大小 */
    func resize(width:CGFloat, height:CGFloat) -> UIImage {
        let myImageSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(myImageSize, false, 0.0)
        let myImageRect = CGRect(x: 0, y: 0, width: myImageSize.width, height: myImageSize.height)
        self.draw(in: myImageRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
      }

    /*  压缩图片，最大为1M  */
    func compressImage(maxImageSize: CGFloat, maxSizeWithKB: CGFloat) -> NSData {
        var maxImgWithKB = maxSizeWithKB
        var maxImgSize = maxImageSize

        if maxImgWithKB <= 0 {
            maxImgWithKB = 1024
        }

        if maxImgSize <= 0 {
            maxImgSize = 1024
        }

        // 调整分辨率
        var newSize = CGSize(width: self.size.width, height: self.size.height)
        let tempHeight = newSize.height / maxImgSize
        let tempWidth = newSize.width / maxImgSize

        if (tempWidth > 1.0 && tempWidth > tempHeight) {
            newSize = CGSize(width: self.size.width / tempWidth, height: self.size.height / tempHeight)
        } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
            newSize = CGSize(width: self.size.width / tempHeight, height: self.size.width / tempHeight)
        }

        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // 调整大小
        var imageData = newImage!.jpegData(compressionQuality: 1.0)
        var sizeOriginKB = CGFloat(imageData!.count) / 1024

        var resizeRate: CGFloat = 0.9
        while (sizeOriginKB > maxImgWithKB && resizeRate > 1.0) {
            imageData = newImage!.jpegData(compressionQuality: resizeRate)
            sizeOriginKB = CGFloat(imageData!.count) / 1024
            resizeRate -= 0.1
        }

        return imageData! as NSData
      }


    /*图片着色*/
    func setOverlay(color: UIColor, blendMode: CGBlendMode = .normal) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return tintedImage
    }
    
    // 增加不透明度
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
    
    // 增加遮罩
    func withFilter(_ maskColor: String = c000_10) -> UIImage {
        let myView = UIView()
        myView.size = self.size
        let imageView = UIImageView()
        imageView.set(superview: myView,image: self)
        imageView.setFrame(allEdges: 0)
        
        let mask = UIView()
        mask.set(superview: myView, backgroundColor: maskColor)
        mask.setFrame(allEdges: 0)

        let image = getImageFromView(view: myView)
        return image
    }
    
    // 图片宽|高>2560px时降低图片分辨率
    func resizeImageIfTooLarge() -> UIImage? {
        // 获取图片的原始分辨率
        let originalSize = self.size
        print("原始分辨率", originalSize)
        
        
        // 取图片宽与高的最大值
        let maxDimension = max(originalSize.width, originalSize.height)
        
        // 如果最大值小于等于2560px，则不降低图片分辨率，直接返回原始图片对象
        if maxDimension <= 2560 {
            return self
        }
        
        // 如果最大值大于2560px，则降低图片分辨率
        // 把最大值设为2560px，然后计算新的宽和高，保持原始比例不变
        let newMaxDimension: CGFloat = 2560
        let ratio = newMaxDimension / maxDimension
        let newWidth = originalSize.width * ratio
        let newHeight = originalSize.height * ratio
        
        // 设置新的分辨率
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        // 开始绘图上下文
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        
        // 绘制图片到新的上下文中
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        // 获取新的图片对象
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 结束绘图上下文
        UIGraphicsEndImageContext()
        
        // 返回新的图片对象
        return newImage
    }

}


// 扩大响应区域辅助项
var kExpandSizeKey = "expandSizeKey"


extension UIButton {
    func set(superview: UIView, target: Any?, action: Selector, forEvent: UIControl.Event = UIControl.Event.touchUpInside) {
        superview.addSubview(self)
        self.addTarget(target, action: action, for: forEvent)
    }

    // 扩大响应区域 (把宽高44pt以下的部分扩大到44pt)
    public func expendTouchArea(size: CGFloat = 44) {
        // size: 最小响应区域的宽/高
        let padding = max((size - self.height) / 2, (size - self.width) / 2)
        objc_setAssociatedObject(self, &kExpandSizeKey, padding,  objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    
    // 扩大响应区域辅助项
    func expandRect() -> CGRect {
        let expandSize = objc_getAssociatedObject(self, &kExpandSizeKey)
        let size: CGFloat = 44  // 最小响应区域的宽/高
         if (expandSize != nil) {
             if self.height >= size {
                 return CGRect(x: bounds.origin.x - (expandSize as! CGFloat), y: bounds.origin.y, width: bounds.size.width + 2*(expandSize as! CGFloat), height: bounds.size.height)
             } else if self.width >= size {
                 return CGRect(x: bounds.origin.x, y: bounds.origin.y - (expandSize as! CGFloat), width: bounds.size.width, height: bounds.size.height + 2*(expandSize as! CGFloat))
             } else {
                 return CGRect(x: bounds.origin.x - (expandSize as! CGFloat), y: bounds.origin.y - (expandSize as! CGFloat), width: bounds.size.width + 2*(expandSize as! CGFloat), height: bounds.size.height + 2*(expandSize as! CGFloat))
             }
         }
         return bounds
    }
    
    // 扩大响应区域辅助项
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
         let buttonRect = expandRect()
         if (buttonRect.equalTo(bounds)) {
             return super.point(inside: point, with: event)
         }
         return buttonRect.contains(point)
    }
    
    // 调整带图标按钮的偏移位置 (默认图标在左，与按钮紧贴)
    func setRightIconOffset(iconWidth: CGFloat, insetOfLabelAndIcon: CGFloat) {
        let leftOffset = self.titleLabel?.getLabelWidth() ?? 0
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: leftOffset + insetOfLabelAndIcon/2, bottom: 0, right: -(leftOffset + insetOfLabelAndIcon/2))
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(iconWidth + insetOfLabelAndIcon/2), bottom: 0, right: iconWidth + insetOfLabelAndIcon/2)
    }
    
    func setLeftIconOffset(insetOfLabelAndIcon: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetOfLabelAndIcon/2, bottom: 0, right: insetOfLabelAndIcon/2)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetOfLabelAndIcon/2, bottom: 0, right: -insetOfLabelAndIcon/2)
    }

}


extension UIViewController {
    // depreciated ➤ push指从右向左滑入页面
    func pushFromRootPage(toTarget: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toTarget, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    // depreciated ➤ push from secondary or deeper page
    func pushFromSecondaryPage(toTarget: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toTarget, animated: true)
    }
    
    func push(toTarget: UIViewController) {
        self.navigationController?.pushViewController(toTarget, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToRootVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // present()为从下向上滑入页面，dismiss()为从向上向下滑出页面
    func present(toTarget: UIViewController, completion: @escaping () -> Void = {}) {
        self.present(toTarget, animated: true, completion: completion)
    }
    
    func presentFullScreen(toTarget: UIViewController, animated: Bool = true, completion: @escaping () -> Void = {}) {
        toTarget.modalPresentationStyle = .fullScreen
        self.present(toTarget, animated: animated, completion: completion)
    }
    
    func dismiss(completion: @escaping () -> Void = {}) {
        self.presentingViewController?.dismiss(animated: true, completion: completion)
    }
    
    func hideNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getNavView() -> UIView {
        return self.navigationController?.navigationBar ?? self.view
    }
    
    func hideBackBtn() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    // 测试 有效
    func dismissAll()  {
        //1.2循环调用 presentingViewController 获取根VC，再dissmiss
        //获取根VC
        var rootVC = self.presentingViewController
        while let parent = rootVC?.presentingViewController {
            rootVC = parent
        }
        //释放所有下级视图
        rootVC?.dismiss(animated: true, completion: nil)
    }
    
    func dismissTwice(animated: Bool = true) {
        // presentingViewController可获取父级ViewController
        self.presentingViewController?.presentingViewController?.dismiss(animated: animated, completion: nil)
    }
    
    
    // 弹窗
    func alertOneBtn(title: String?, message: String? = nil, btnTitle: String?, btnStyle: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: btnTitle, style: btnStyle, handler: handler)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertTwoBtn(title: String?, message: String? = nil, cancelBtnTitle: String? = "取消", cancelBtnStyle: UIAlertAction.Style = .default, okBtnTitle: String?, okBtnStyle: UIAlertAction.Style = .default, okBtnHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: cancelBtnStyle, handler: nil)
        let okAction = UIAlertAction(title: okBtnTitle, style: okBtnStyle, handler: okBtnHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 选项表
    func actionSheet(title: String? = nil, cancelBtnTitle: String? = "取消", cancelBtnHandler: ((UIAlertAction) -> Void)? = nil, actionsTitle: [String?], actionsStyle: [UIAlertAction.Style], actionsHandler: [((UIAlertAction) -> Void)?]) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .cancel, handler: cancelBtnHandler)
        alertController.addAction(cancelAction)
        
        for i in 0..<actionsTitle.count {
            let selection = UIAlertAction(title: actionsTitle[i], style: actionsStyle[i], handler: actionsHandler[i])
            alertController.addAction(selection)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // 拍照
    func callCamera(allowsEditing: Bool, delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?){
                    
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = delegate
            cameraPicker.allowsEditing = allowsEditing
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            print("不支持拍照")
        }
        
    }

    // 相册
    func callPhoto(allowsEditing: Bool, delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?){
        // 参数 delegate：一般填⌜self⌟
        // 参数 wherePresent：一般填⌜self⌟
        
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = delegate
        photoPicker.allowsEditing = allowsEditing
        photoPicker.sourceType = .photoLibrary
        //在需要的地方present出来
        self.present(photoPicker, animated: true, completion: nil)
        
    }

    // 屏蔽侧滑返回：1.在viewDidAppear屏蔽
    func popGestureClose() {
        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = false
            }
        }
    }
    
    // 屏蔽侧滑返回：2.在viewWillDisappear中恢复
    func popGestureOpen() {
        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = true
            }
        }
    }
    
    func getNavBar() -> UINavigationBar? {
        return self.navigationController?.navigationBar
    }

}




extension UITableView {
    func set(superview: UIView, delegate: UITableViewDelegate, dataSource: UITableViewDataSource, viewController: UIViewController) {
        superview.addSubview(self)
        self.delegate = delegate
        self.dataSource = dataSource
        self.separatorColor = .hex(cNoColor)
        self.OptimizeEdgePanGesture(of: viewController)
        setAutoHeight()
    }
    
    func setAutoHeight() {
        self.estimatedRowHeight = 44.0
        self.rowHeight = UITableView.automaticDimension
    }
    
}




extension UIScrollView {
    func OptimizeEdgePanGesture(of viewController: UIViewController) {
        let gestureArray = viewController.navigationController?.view.gestureRecognizers
        if gestureArray != nil {
            for gesture in gestureArray! {
                if gesture.isKind(of: UIScreenEdgePanGestureRecognizer.self) {
                    self.panGestureRecognizer.require(toFail: gesture)
                }
            }
        } else {
            print("no gesture")
        }
    }
}




extension UIStackView {
    func setStyleStackView(spacing: CGFloat, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fillEqually) {
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}


extension UIPageControl {
//    func set()
    func set(superview: UIView, numberOfPages: Int, hidesForSinglePage: Bool = true) {
        superview.addSubview(self)
        self.numberOfPages = numberOfPages
        self.hidesForSinglePage = true
    }
}


extension UISegmentedControl {
    func set(superview: UIView, selectedSegmentIndex: Int = 0, target: Any?, action: Selector, for controlEvents: UIControl.Event = .valueChanged) {
        self.set(superview: superview)
        self.selectedSegmentIndex = selectedSegmentIndex
        self.addTarget(target, action: action, for: controlEvents)
    }
}


extension UIDevice {
    class var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
            //TODO:iPod touch
        case "iPod1,1":                                       return "iPod touch"
        case "iPod2,1":                                       return "iPod touch (2nd generation)"
        case "iPod3,1":                                       return "iPod touch (3rd generation)"
        case "iPod4,1":                                       return "iPod touch (4th generation)"
        case "iPod5,1":                                       return "iPod touch (5th generation)"
        case "iPod7,1":                                       return "iPod touch (6th generation)"
        case "iPod9,1":                                       return "iPod touch (7th generation)"
            
            //TODO:iPad
        case "iPad1,1":                                       return "iPad"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
        case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
        case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
        case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
        case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
        case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
        case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
            
            //TODO:iPad Air
        case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
        case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
        case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
        case "iPad13,1", "iPad13,2":                          return "iPad Air (4rd generation)"
            
            //TODO:iPad Pro
        case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
        case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch)"
        case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
        case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch)"
        case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
        case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
            
            //TODO:iPad mini
        case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                            return "iPad Mini 4"
        case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
        case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
            
            //TODO:iPhone
        case "iPhone1,1":                               return "iPhone"
        case "iPhone1,2":                               return "iPhone 3G"
        case "iPhone2,1":                               return "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE (1st generation)"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
        case "iPhone12,8":                              return "iPhone SE (2nd generation)"
        case "iPhone13,1":                              return "iPhone 12 mini"
        case "iPhone13,2":                              return "iPhone 12"
        case "iPhone13,3":                              return "iPhone 12 Pro"
        case "iPhone13,4":                              return "iPhone 12 Pro Max"
        case "iPhone14,4":                              return "iPhone 13 mini"
        case "iPhone14,5":                              return "iPhone 13"
        case "iPhone14,2":                              return "iPhone 13 Pro"
        case "iPhone14,3":                              return "iPhone 13 Pro Max"
        case "iPhone14,6":                              return "iPhone SE (3rd generation)"
            
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "iPhone Simulator"
        default:                                        return identifier
        }
    }
}


extension UIStepper {
    
    func set(superview: UIView, target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) {
        self.set(superview: superview)
        self.addTarget(target, action: action, for: controlEvents)
    }
}


extension UISwitch {
    func set(superview: UIView, setOn: Bool, animated: Bool = false, onTintColor: UIColor = .hex(cThemeFill), target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) {
        self.set(superview: superview)
        self.setOn(setOn, animated: animated)
        self.onTintColor = onTintColor
        self.addTarget(target, action: action, for: controlEvents)
    }
    
}


