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
        self.setBackgroundColor(color: cFFF)
        self.setCornerRadius(radius: 8)
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
        self.setCornerRadiusWithMask(radius: 16, corners: [.topLeft, .topRight])
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
    
    func setStyle20pt222MedCenter() {
        self.setFontStyle(size: 20, color: c222, weight: .medium, alignment: .center)
    }
    
    func setStyle18pt222Med() {
        self.setFontStyle(size: 18, color: c222, weight: .medium)
    }
    
    func setStyle17pt888() {
        self.setFontStyle(size: 17, color: c888, weight: .medium)
    }
    
    func setStyle17pt222Med() {
        self.setFontStyle(size: 17, color: c222, weight: .medium)
    }
    
    func setStyle17pt222() {
        self.setFontStyle(size: 17, color: c222)
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
    
    func setStyle14ptFEFEFEMedCenter() {
        self.setFontStyle(size: 14, color: cFEFEFE, weight: .medium, alignment: .center)
    }
    
    func setStyle12pt222() {
        self.setFontStyle(size: 12, color: c222)
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


