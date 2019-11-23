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
    
    func addShadow(color: String, x: CGFloat, y: CGFloat, radius: CGFloat) {
        self.layer.shadowColor = UIColor.hex(color).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowRadius = radius
    }
    
    func addBorder(color: String, borderWidth: CGFloat) {
        self.layer.borderColor = UIColor.hex(color).cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCornerRadius(radius: CGFloat, corners: UIRectCorner) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func setBackgroundColor(color: String) {
        self.backgroundColor = UIColor.hex(color)
    }
    
    func addSeparator(leftInset: CGFloat, rightInset: CGFloat, color: String = "1A000820") {
        let separator = UIView()
        self.addSubview(separator)
        separator.makeConstraints(left: leftInset, bottom: 0, width: kScreenWidth - leftInset - rightInset, height: kSeparatorHeight)
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
    
    func setFontStyle(color: String, size: CGFloat, weight: UIFont.Weight = UIFont.Weight.regular) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = UIColor.hex(color)
    }
    
    func setLineHeight(lineHeight: CGFloat = 1.4/1.2, text: String) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = lineHeight
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraph]
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    func getLabelWidth() -> CGFloat {
        let labelText = self.text! as NSString
        let size = CGSize(width: CGFloat(MAXFLOAT), height: self.frame.size.height)
        let textSize = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!], context: nil).size
        return CGFloat(Int(textSize.width) + 1)
    }
    
    func getLabelHeight(width: CGFloat) -> CGFloat {
        _ = self.text! as NSString
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let height = self.sizeThatFits(size).height
        return CGFloat(Int(height))
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
    
    func getDefaultLineheight() -> CGFloat {
        return self.font.pointSize * 1.4
    }
}



extension UITextView {
    
    func set(superview: UIView, text: String) {
        self.text = text
        superview.addSubview(self)
    }
    
    func setFontStyle(color: String, size: CGFloat, weight: UIFont.Weight = UIFont.Weight.regular) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = UIColor.hex(color)
    }
    
    func setLineHeight(lineHeight: CGFloat = 1.4/1.2, text: String) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = lineHeight
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraph]
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

}



extension UITextField {
    
    func set(superview: UIView, placeholder: String) {
        self.placeholder = placeholder
        superview.addSubview(self)
    }
}



extension UIImageView {
    
    func set(superview: UIView, imageName: String) {
        self.image = UIImage(named: imageName)
        superview.addSubview(self)
    }
}


extension UIImage {
    
    func changeColor(color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!);
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

    
extension UIButton {
    
}


extension UIViewController {
    // push指从右向左滑入页面
    func pushFromRootPage(toTarget: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toTarget, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    // push from secondary or deeper page
    func pushFromSecondaryPage(toTarget: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(toTarget, animated: true)
    }
    
    func backToSuperPage() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // present()为从下向上滑入页面，dismiss()为从向上向下滑出页面
    
    func hideNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getTabBarHeight() -> CGFloat {
        return self.tabBarController?.tabBar.bounds.size.height ?? 0
    }
    
    func getSafeAreaHeight() -> CGFloat {
        return kScreenHeight - kNavBarHeight - self.getTabBarHeight()
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

