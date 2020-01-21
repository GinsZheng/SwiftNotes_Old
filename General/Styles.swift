//
//  Styles.swift
//  SnailProgress
//
//  Created by GinsMac on 2019/11/28.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

extension UIView {
    
    func setStyleCellShadow() {
        self.setShadow(color: c133660_15_shadow, x: 0, y: 4, radius: 20)
        self.setBackgroundColor(color: cFFF)
        self.setCornerRadiusWithoutMask(radius: 8)
    }
    
    func setStyleCellCard() {
        self.setCornerRadius(radius: 8)
        self.setBackgroundColor(color: cFFF)
    }
    
    func setStyleProgressBarBg() {
        self.setBackgroundColor(color: cF0F1F3)
        self.setCornerRadius(radius: 8)
    }
    
    func setStyleProgressBar(color: String) {
        self.setCornerRadius(radius: 8)
        self.setBackgroundColor(color: color)
    }
    
    func setStylePresentView() {
        self.setBackgroundColor(color: cFFF)
        self.setCornerRadius(radius: 16, corners: [.topLeft, .topRight])
    }
    
    func setStyleChartBg() {
        self.setBackgroundColor(color: cFFF)
        self.setShadow(color: c133660_15_shadow, x: 0, y: 2, radius: 10)
        self.setCornerRadiusWithoutMask(radius: 8)
        self.setBorder(color: c000_5_border, borderWidth: kSeparatorHeight)
    }
    
}



extension UILabel {
    func setStyle34pt222Med() {
        self.setFontStyle(size: 34, color: c222, weight: .medium)
    }
    
    func setStyle24pt222Med() {
        self.setFontStyle(size: 24, color: c222, weight: .medium)
    }
    
    func setStyle24pt222MedCenter() {
        self.setFontStyle(size: 24, color: c222, weight: .medium, alignment: .center)
    }
    
    func setStyle24pt222MedRight() {
        self.setFontStyle(size: 24, color: c222, weight: .medium, alignment: .right)
    }
    
    func setStyle18pt222Med() {
        self.setFontStyle(size: 18, color: c222, weight: .medium)
    }
    
    func setStyle17pt888() {
        self.setFontStyle(size: 17, color: c888, weight: .medium)
    }
    
    func setStyle17pt999() {
        self.setFontStyle(size: 17, color: c999)
    }
    
    func setStyle14pt999() {
        self.setFontStyle(size: 14, color: c999)
    }
    
    func setStyle12pt222() {
        self.setFontStyle(size: 12, color: c222)
    }
    
    func setStyle12pt999() {
        self.setFontStyle(size: 12, color: c999)
    }
    
    func setStyle12pt999MedRight() {
        self.setFontStyle(size: 12, color: c999, weight: .medium, alignment: .right)
    }
    
    func setStyle12ptFFFMedCenter() {
        self.setFontStyle(size: 12, color: cFFF, weight: .medium, alignment: .center)
    }
}



extension UITextView {
    
    func setStyle34pt222Med() {
        self.setFontStyle(size: 34, color: c222, weight: .medium)
    }
    
    func setStyle24pt222Med() {
        self.setFontStyle(size: 24, color: c222, weight: .medium)
    }
    
    func setStyle24pt222MedCenter() {
        self.setFontStyle(size: 24, color: c222, weight: .medium, alignment: .center)
    }
    
    func setStyle24pt222MedRight() {
        self.setFontStyle(size: 24, color: c222, weight: .medium, alignment: .right)
    }
    
    func setStyle18pt222Med() {
        self.setFontStyle(size: 18, color: c222, weight: .medium)
    }
    
    func setStyle17pt888() {
        self.setFontStyle(size: 17, color: c888, weight: .medium)
    }
    
    func setStyle17pt999() {
        self.setFontStyle(size: 17, color: c999)
    }
    
    func setStyle14pt999() {
        self.setFontStyle(size: 14, color: c999)
    }
    
    func setStyle12pt222() {
        self.setFontStyle(size: 12, color: c222)
    }
    
    func setStyle12pt999() {
        self.setFontStyle(size: 12, color: c999)
    }
    
    func setStyle12pt999MedRight() {
        self.setFontStyle(size: 12, color: c999, weight: .medium, alignment: .right)
    }
    
    func setStyle12ptFFFMedCenter() {
        self.setFontStyle(size: 12, color: cFFF, weight: .medium, alignment: .center)
    }
}



extension UITextField {
    func setStyleOneLineTextField() {
        self.backgroundColor = .hex(cF0F1F3)
        self.setCornerRadius(radius: 8)
        self.setTextPadding(left: 12, right: 12)
    }
}



extension UIButton {
    func setStyleCloseBtn() {
        self.setImage(UIImage(named: "nav_close"), for: .normal)
    }
    
    func setStyleSolidAddingBtn(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cFFF), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        self.setImage(UIImage(named: "general_adding_btn"), for: .normal)
        self.setImage(UIImage(named: "general_adding_btn"), for: .highlighted)
        self.setImage(UIImage(named: "general_adding_btn"), for: .disabled)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        self.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF_40), for: .disabled)
        self.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF_60), for: .highlighted)
        self.setCornerRadius(radius: 8)
        
    }
    
    func setStyleSolidBtn(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cFFF), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF_40), for: .disabled)
        self.setBackgroundImage(getImageWithColor(color: cBlue_2C9EFF_60), for: .highlighted)
        self.setCornerRadius(radius: 8)
    }
    
    func setStyleGhostBtn(title: String) {
        self.setStyleGhostButton(title: title, borderWidth: 1, cornerRadius: 8)
    }
    
    func setStyleAddItemBarBtn() {
        self.setTitle("添加一个学习项目", for: .normal)
        self.setTitleColor(.hex(cAAA), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        self.setImage(UIImage(named: "progress_adding"), for: .normal)
        self.setImage(UIImage(named: "progress_adding"), for: .highlighted)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        self.setBackgroundImage(getImageWithColor(color: cF0F1F3), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cDDDEE0), for: .highlighted)
        self.setCornerRadius(radius: 8)
    }
}



extension UIStackView {
    func setStyleColorCircleStack(spacing: CGFloat) {
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = spacing
    }
}



// ————————————————
// SwiftNotes

extension UIButton {
    func setStyleWordButton(title: String, titleSize: CGFloat = 17, titleColor: String = cThemeWord, titleWeight: UIFont.Weight = .medium) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.hex(titleColor), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: titleSize, weight: titleWeight)
    }
    
    func setStyleGhostButton(title: String, titleSize: CGFloat = 17, titleColor: String = cThemeWord, titleWeight: UIFont.Weight = .medium, borderColor: String = cThemeBorder, borderWidth: CGFloat = 0.5, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.hex(titleColor), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight) // 这里设置UILabel的颜色值将无效
        self.setBorder(color: cThemeBorder, borderWidth: borderWidth)
        self.setCornerRadius(radius: cornerRadius)
    }
    
    func setStyleSolidButton(title: String, titleSize: CGFloat = 17, titleColor: String = cFFF, titleWeight: UIFont.Weight = .medium, fillColor: String = cThemeFill, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(titleColor), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight)
        self.setBackgroundImage(getImageWithColor(color: cThemeFill), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cThemeHightlightedFill), for: .highlighted)
        self.setBackgroundImage(getImageWithColor(color: cThemeDisabledFill), for: .disabled)
        self.setCornerRadius(radius: cornerRadius)
    }
    
    func setStyleSystemIconButton(imageName: String) {
        self.tintColor = .hex(c222)
        self.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func setStyleCustomIconButton(imageName: String) {
        self.setImage(UIImage(named: imageName), for: .normal)
    }
}


extension UIImageView {
    func setStyleNote() {
        self.setStyleImageView(cornerRadius: 8)
        self.setBorder(color: cBlue_2C9EFF, borderWidth: 1)
    }
}
