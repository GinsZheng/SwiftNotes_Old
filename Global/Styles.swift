//
//  Styles.swift
//  SnailProgress
//
//  Created by GinsMac on 2019/11/28.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

extension UIView {
    
    func setStyleCellShadowLight() {
        self.setShadow(color: c00244F_4_shadow, x: 0, y: 2, radius: 10)
        self.setBackgroundColor(color: cFFF) // 设置shadow时需要有背景色才生效
        self.setCornerRadius(radius: 8) // 设shadow要设不带遮罩的圆角
    }
    
    func setStyleProgressBarBg() {
        self.setBackgroundColor(color: cF0F1F3)
        self.setCornerRadiusWithMask(radius: 8)
    }
    
    func setStyleProgressBar(color: String) {
        self.setCornerRadiusWithMask(radius: 8)
        self.setBackgroundColor(color: color)
    }
    
    func setStylePresentView() {
        self.setBackgroundColor(color: cFFF)
        self.setEachCornerRadiusWithMask(radius: 16, corners: [.topLeft, .topRight])
    }
    
    func setStyleChartBg() {
        self.setBackgroundColor(color: cFFF)
        self.setShadow(color: c00244F_14_shadow, x: 0, y: 2, radius: 10)
        self.setCornerRadius(radius: 8)
        self.setBorder(color: c000_5, borderWidth: kSeparatorHeight)
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
    
    func setStyle20pt222Med() {
        self.setFontStyle(size: 20, color: c222, weight: .medium, alignment: .left)
    }
    
    func setStyle20pt222MedCenter() {
        self.setFontStyle(size: 20, color: c222, weight: .medium, alignment: .center)
    }
    
    func setStyle18pt222Med() {
        self.setFontStyle(size: 18, color: c222, weight: .medium)
    }
    
    func setStyle17pt000_22() {
        self.setFontStyle(size: 17, color: c000_22)
    }
    
    func setStyle17pt222Med() {
        self.setFontStyle(size: 17, color: c222, weight: .medium)
    }
    
    func setStyle17pt222() {
        self.setFontStyle(size: 17, color: c222)
    }
    
    func setStyle17pt888() {
        self.setFontStyle(size: 17, color: c888, weight: .medium)
    }
    
    func setStyle17pt999() {
        self.setFontStyle(size: 17, color: c999)
    }
    
    func setStyle17ptCCC() {
        self.setFontStyle(size: 17, color: c000_22)
    }
    
    func setStyle16pt222() {
        self.setFontStyle(size: 16, color: c222)
    }
    
    func setStyle16pt00022() {
        self.setFontStyle(size: 16, color: c000_22)
    }
    
    func setStyle15ptFEFEFE85Center() {
        self.setFontStyle(size: 15, color: cFEFEFE_85, alignment: .center)
    }
    
    func setStyle15pt999() {
        self.setFontStyle(size: 15, color: c999)
    }
    
    func setStyle14pt666Center() {
        self.setFontStyle(size: 14, color: c666, alignment: .center)
    }
    
    func setStyle14pt888() {
        self.setFontStyle(size: 14, color: c888)
    }
    
    func setStyle14pt999() {
        self.setFontStyle(size: 14, color: c999)
    }
    
    func setStyle14pt999Right() {
        self.setFontStyle(size: 14, color: c999, alignment: .right)
    }
    
    func setStyle14ptFEFEFEMedCenter() {
        self.setFontStyle(size: 14, color: cFEFEFE, weight: .medium, alignment: .center)
    }
    
    func setStyle12pt222() {
        self.setFontStyle(size: 12, color: c222)
    }
    
    func setStyle12pt888Med() {
        self.setFontStyle(size: 12, color: c888, weight: .medium)
    }
    
    func setStyle12pt999() {
        self.setFontStyle(size: 12, color: c999)
    }
    
    func setStyle12pt999Right() {
        self.setFontStyle(size: 12, color: c999, alignment: .right)
    }
    
    func setStyle12ptFEFEFE45Center() {
        self.setFontStyle(size: 12, color: cFEFEFE_45, alignment: .center)
    }
    
    func setStyle12pt999MedCent() {
        self.setFontStyle(size: 12, color: c999, weight: .medium, alignment: .center)
    }
    
    func setStyle12pt999MedRight() {
        self.setFontStyle(size: 12, color: c999, weight: .medium, alignment: .right)
    }
    
    func setStyle12ptFEFEFEMedCenter() {
        self.setFontStyle(size: 12, color: cFEFEFE, weight: .medium, alignment: .center)
    }
    
    func setStyle80ptFFF75ThinCenter() {
        self.setFontStyle(size: 80, color: cFFF_75, weight: .thin, alignment: .center)
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
    
    func setStyle17pt000_22() {
        self.setFontStyle(size: 17, color: c000_22)
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
    
    func setStyle12ptFEFEFEMedCenter() {
        self.setFontStyle(size: 12, color: cFEFEFE, weight: .medium, alignment: .center)
    }
}



extension UITextField {
    func setStyleOneLineTextField() {
        self.backgroundColor = .hex(cF0F1F3)
        self.setCornerRadiusWithMask(radius: 8)
        self.setTextPadding(left: 12, right: 12)
    }
}



extension UIButton {
    func setStyleCloseBtn() {
        self.setImage(UIImage(named: "nav_close"), for: .normal)
    }
    
    func setStyleSolidAddingBtn(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cFEFEFE), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        self.setImage(UIImage(named: "general_adding_btn"), for: .normal)
        self.setImage(UIImage(named: "general_adding_btn"), for: .highlighted)
        self.setImage(UIImage(named: "general_adding_btn"), for: .disabled)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF_40), for: .disabled)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF_60), for: .highlighted)
        self.setCornerRadiusWithMask(radius: 8)
        
    }
    
    func setStyleSolidBtn(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cFEFEFE), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF_40), for: .disabled)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF_60), for: .highlighted)
        self.setCornerRadiusWithMask(radius: 8)
    }
    
    func setStyleGhostBtn(title: String) {
        self.setStyleGhostButton(title: title, borderWidth: 1, cornerRadius: 8)
    }
    
    func setStyleAddItemBarBtn(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(c999), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        self.setImage(UIImage(named: "progress_adding"), for: .normal)
        self.setImage(UIImage(named: "progress_adding"), for: .highlighted)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        self.setBackgroundImage(getImageWithColor(color: cE6E7E9), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cE6E7E9).withFilter(), for: .highlighted)
        self.setCornerRadiusWithMask(radius: 8)
    }
    
    func setStyleCutsomCancelBtn(title: String) {
        self.setStyleWordButton(title: title, titleSize: 14, normalTitleColor: c999, highlightedTitleColor: cBBB, titleWeight: .regular)
    }
    
    func setStyleArrow(title: String, imageName: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cBlue_5393FF), for: .normal)
        self.setTitleColor(.hex(cBlue_5393FF_60), for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        self.contentHorizontalAlignment = .left  // 文本左对齐
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -18, bottom: 0, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.width - 1 - 18, bottom: 0, right: 0)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setImage(UIImage(named: imageName)?.withAlpha(0.6), for: .highlighted)
    }
    
    func setStyleTintTitleGrayBg(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cBlue_5393FF), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        self.setBackgroundImage(getImageWithColor(color: cF0F1F3), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cF0F1F3).withFilter(), for: .highlighted)
        
        self.setCornerRadiusWithMask(radius: 14)
    }
    
    func setStyleCellWhiteBg(radius: CGFloat = 8) {
        self.setBackgroundImage(getImageWithColor(color: cFFF), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cFFF).withFilter(c000_10), for: .highlighted)
        self.setCornerRadiusWithMask(radius: radius)
    }
    
    func setStyleAddingImage(normalImageName: String = "mine_addPhoto", hightlightedImageName: String = "mine_addPhoto_h", bgColor: String = cF0F1F3, radius: CGFloat = 7) {
        self.setImage(UIImage(named: normalImageName), for: .normal)
        self.setImage(UIImage(named: hightlightedImageName), for: .highlighted)
        self.setBackgroundImage(getImageWithColor(color: bgColor), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: bgColor).withFilter(), for: .highlighted)
        self.setCornerRadiusWithMask(radius: radius)
    }
    
    func setStyleEditingImage(normalImage: UIImage, hightlightedImageName: UIImage, radius: CGFloat = 7) {
        self.setImage(normalImage, for: .normal)
        self.setImage(hightlightedImageName, for: .highlighted)
        self.setCornerRadiusWithMask(radius: radius)
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
    func setStyleWordButton(title: String, titleSize: CGFloat = 17, normalTitleColor: String = cThemeWord, highlightedTitleColor: String = cThemeHightlightedFill, titleWeight: UIFont.Weight = .medium) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.hex(normalTitleColor), for: .normal)
        self.setTitleColor(UIColor.hex(highlightedTitleColor), for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: titleSize, weight: titleWeight)
        // UIButton可以设置字号字重，不可设置颜色，颜色必须用setTitleColor来设置
    }
    
    func setStyleGhostButton(title: String, titleSize: CGFloat = 17, normalTitleColor: String = cThemeWord, highlightedTitleColor: String = cThemeHightlightedFill, titleWeight: UIFont.Weight = .medium, borderColor: String = cThemeBorder, borderWidth: CGFloat = 0.5, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.hex(normalTitleColor), for: .normal)
        self.setTitleColor(UIColor.hex(highlightedTitleColor), for: .highlighted)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight) // 这里设置UILabel的颜色值将无效
        self.setBorder(color: cThemeBorder, borderWidth: borderWidth)
        self.setCornerRadius(radius: cornerRadius)
    }
    
    func setStyleSolidButton(title: String, titleSize: CGFloat = 17, titleColor: String = cFEFEFE, titleWeight: UIFont.Weight = .medium, fillColor: String = cThemeFill, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(titleColor), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight)
        self.setBackgroundImage(getImageWithColor(color: cThemeFill), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cThemeHightlightedFill), for: .highlighted)
        self.setBackgroundImage(getImageWithColor(color: cThemeDisabledFill), for: .disabled)
        self.setCornerRadiusWithMask(radius: cornerRadius)
    }
    
    func setStyleSolidButton2(title: String, titleSize: CGFloat = 17, titleColor: String = cFEFEFE, titleWeight: UIFont.Weight = .medium, fillColor: String = cThemeFill, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(titleColor), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight)
        self.setBackgroundImage(getImageWithColor(color: cThemeFill), for: .normal)
        self.setCornerRadiusWithMask(radius: cornerRadius)
    }
    
    func setStyleSolidWithIconButton(title: String, titleSize: CGFloat = 17, titleColor: String = cFEFEFE, titleWeight: UIFont.Weight = .medium, fillColor: String = cThemeFill, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(titleColor), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight)
        self.setBackgroundImage(getImageWithColor(color: cThemeFill), for: .normal)
        self.setCornerRadiusWithMask(radius: cornerRadius)
        // 设置图片
        self.setImage(UIImage(named: "tickets_refund_toast_comfirm"), for: .normal)
        self.setRightIconOffset(iconWidth: 24, insetOfLabelAndIcon: 13) // 右icon
        // self.setLeftIconOffset(insetOfLabelAndIcon: 13) // 左icon
        
        // 示例图：tickets_refund_toast_comfirm ，尺寸为24*24
        // 注意要是 UIButton(type: .custom) ，否则图片颜色会变蓝
    }
    
    func setStyleSystemIconButton(imageName: String, backgroundImage: UIImage = getImageWithColor(color: cNoColor), cornerRadius: CGFloat = 0) {
        self.tintColor = .hex(c222)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setCornerRadiusWithMask(radius: cornerRadius)
    }
    
    func setStyleCustomIconButton(imageName: String) {
        self.setImage(UIImage(named: imageName), for: .normal)
    }
    
}


extension UIImageView {
    func setStyleNote() {
        self.setCornerRadiusWithMask(radius: 8)
        self.setBorder(color: cBlue_5393FF, borderWidth: 1)
    }
}

