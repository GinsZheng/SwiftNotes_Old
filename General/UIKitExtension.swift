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
    
    func set(superview: UIView) {
        superview.addSubview(self)
    }
    
    func set(superview: UIView, backgroundColor: String) {
        superview.addSubview(self)
        self.setBackgroundColor(color: backgroundColor)
    }
    
    func setShadow(color: String, x: CGFloat, y: CGFloat, radius: CGFloat) {
        self.layer.shadowColor = UIColor.hex(color).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = radius
    }
    
    func setBorder(color: String, borderWidth: CGFloat) {
        self.layer.borderColor = UIColor.hex(color).cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCornerRadiusWithoutMask(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setCornerRadius(radius: CGFloat, corners: UIRectCorner) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
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
        }
    }
    
    var bottom: CGFloat {
        get {
            return y + height
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
}




extension UILabel {
    
    func set(superview: UIView, text: String) {
        self.text = text
        superview.addSubview(self)
    }
    
    func setFontStyle(size: CGFloat, color: String, weight: UIFont.Weight = .regular, alignment: NSTextAlignment = .left) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = UIColor.hex(color)
        self.textAlignment = alignment
    }
    
    func setLineHeight(multiple: CGFloat = 1.4) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = multiple / 1.194
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraph]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: attributes)
    }
    
    func getLabelWidth() -> CGFloat {
        let labelText = self.text! as NSString
        let size = CGSize(width: CGFloat(MAXFLOAT), height: self.frame.size.height)
        let textSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!], context: nil).size
        return CGFloat(Int(textSize.width) + 1)
    }
    
    func getLabelWidth(withMaxWidth maxWidth: CGFloat) -> CGFloat {
        let labelText = self.text! as NSString
        let size = CGSize(width: CGFloat(MAXFLOAT), height: self.frame.size.height)
        let textSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!], context: nil).size
        var labelWidth = CGFloat(Int(textSize.width) + 1)
        if labelWidth > maxWidth {
            labelWidth = maxWidth
        }
        return labelWidth
    }
    
    func getTextHeight(withWidth width: CGFloat) -> CGFloat {
        _ = self.text! as NSString
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let height = self.sizeThatFits(size).height
        return CGFloat(Int(height) + 1)
    }
    
    func getDefaultLineheight() -> CGFloat {
        return round(self.font.pointSize * 1.4)
    }
    
    func setAsMultipleLines(numberOfLines: Int, lineMultiple: CGFloat = 1.4) {
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.setLineHeight(multiple: lineMultiple)
    }
    
    func setKern(wordSpace: CGFloat) {
        guard let content = self.text else {return}
        let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: content)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: wordSpace, range: NSMakeRange(0, (content.count)))
        self.attributedText = attributedString
    }
    
}



extension UITextView {
    
    func set(superview: UIView, text: String, maxLines: Int, lineHeight: CGFloat = 1.4, interaction: Bool = false) {
        self.text = text
        setLineHeight(multiple: lineHeight)
        self.isUserInteractionEnabled = interaction
        superview.addSubview(self)
        self.textContainer.maximumNumberOfLines = maxLines
        self.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    func setFontStyle(size: CGFloat, color: String, weight: UIFont.Weight = UIFont.Weight.regular, alignment: NSTextAlignment = .left) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = UIColor.hex(color)
        self.textAlignment = alignment
        self.textContainerInset = UIEdgeInsets(top: -0.10*(size), left: -5, bottom: -0.10*(size), right: -5)
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
    
    func set(superview: UIView, placeholder: String, delegate: UITextFieldDelegate) {
        self.placeholder = placeholder
        superview.addSubview(self)
        self.delegate = delegate
    }
    
    var placeholderColor:UIColor {
        get{
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;
        } set{
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
}



extension UIImageView {
    
    func set(superview: UIView, imageName: String) {
        self.image = UIImage(named: imageName)
        superview.addSubview(self)
    }
    
    func set(superview: UIView, image: UIImage) {
        self.image = image
        superview.addSubview(self)
    }
    
    func setStyleImageView(cornerRadius: CGFloat, conteneMode: UIView.ContentMode = .scaleAspectFill) {
        self.setCornerRadius(radius: cornerRadius)
        self.contentMode = conteneMode
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
    func setOverlay(color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return tintedImage
      }

}



extension UIButton {
    func set(superview: UIView, target: Any?, action: Selector, forEvent: UIControl.Event = UIControl.Event.touchUpInside) {
        superview.addSubview(self)
        self.addTarget(target, action: action, for: forEvent)
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
    
    // present()为从下向上滑入页面，dismiss()为从向上向下滑出页面
    func present(toTarget: UIViewController, completion: @escaping () -> Void = {}) {
        self.present(toTarget, animated: true, completion: completion)
    }
    
    func unpresent(completion: @escaping () -> Void = {}) {
        self.dismiss(animated: true, completion: completion)
    }
    
    func hideNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getTabBarHeight() -> CGFloat {
        return self.tabBarController?.tabBar.bounds.size.height ?? 0
    }
    
    func getSafeAreaHeight(inset: CGFloat = 0) -> CGFloat {
        return kScreenHeight - kNavBarHeight - self.getTabBarHeight() - inset
    }
    
}


extension String {
    func removeFirstCharacter() -> String {
        return String(self[self.index(after: self.startIndex)...])
    }
    
    func removeFrontCharacters(length: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: length-1)])
    }
    
}


extension UIImageView {
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
}


extension UITableView {
    func set(superview: UIView, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        superview.addSubview(self)
        self.delegate = delegate
        self.dataSource = dataSource
        self.separatorColor = .hex(cNoColor)
    }
    
}
