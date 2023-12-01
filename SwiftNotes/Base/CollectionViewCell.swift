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
    
//    weak var delegate: AutoLayoutCollectionViewCellDelegate?
//    
//    var titleOffset: CGFloat {
//        return delegate?.fetchTitleOffset() ?? 0
//    }
    
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
        button.setStyleSolid14pt666LightGrayRoundedButton(title: title)
        button.setFrame(left: 0, top: 10, width: 10, height: 28)
    }
    
    func resetWidth() {
//        button.width = (button.titleLabel?.getLabelWidth() ?? 10) + titleOffset
    }
    
    
    // MARK: - @objc func
    @objc func pushToTest() {
        print("done")
    }
    
    
}

