//
//  CollectionViewCell.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/12.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// MARK: - 自定义 Cell

class AutoLayoutCollectionViewCell2: UICollectionViewCell {
    
    // 输出参数(用于代理传递信息)
    let fontsize: CGFloat = 17
    let weight: UIFont.Weight = .medium
    
    weak var delegate: AutoLayoutCollectionViewCellDelegate?
    
    var titleOffset: CGFloat {
        return delegate?.fetchTitleOffset() ?? 0
    }
    
    let scrollView = UIScrollView()
    let button = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    
    func setData(title: String) {
        setButton(title: title)
        resetWidth()
    }
    
    func setButton(title: String) {
        button.set(superview: contentView, target: target, action: #selector(pushToTest))
        button.setStyleSolidButton(title: title, titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
        button.setFrame(left: 0, top: 10, width: 10, height: 28)
    }
    
    func resetWidth() {
        button.width = (button.titleLabel?.getLabelWidth() ?? 10) + titleOffset
    }
    
    
    // MARK: - @objc func
    @objc func pushToTest() {
        print("done")
    }
    
    
}

//
//var frameRight: CGFloat = 0
//
//for (i, title) in buttonTitles.enumerated() {
//    let button = UIButton(type: .custom)
//    button.set(superview: scrollView, target: target, action: #selector(pushToTest))
//    button.setTitle(title, for: .normal)
//    button.setTitleColor(.hex(c666), for: .normal)
//    button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
//    button.setBackgroundColor(color: cF0F1F3)
//    button.setCornerRadiusWithMask(radius: 14)
//    button.setBackgroundImage(getImageWithColor(color: cDDDEE0), for: .highlighted)
//    
//
//    let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
//    if i == 0 {
//        button.setFrame(left: 10, centerY: scrollView.centerY, width: labelWidth + 24, height: 28)
//    } else {
//        button.setFrame(left: frameRight, centerY: scrollView.centerY, width: labelWidth + 24, height: 28)
//    }
//    
//    frameRight = button.right + 6
//    
//    buttons.append(button)
//}
//
//scrollView.contentSize = CGSize(width: frameRight + 4, height: 48)
