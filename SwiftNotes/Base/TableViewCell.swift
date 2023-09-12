//
//  TableViewCell.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/24.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let nextIcon = UIImageView()
    let separator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.set(superview: contentView)
        titleLabel.setStyle17pt222()
        titleLabel.setFrame(left: 16, centerY: contentView.centerY)
        
        nextIcon.set(superview: contentView, imageName: "next")
        nextIcon.setFrame(right: 16, centerY: contentView.centerY, width: 18, height: 18)

        separator.set(superview: contentView, backgroundColor: cSeparator)
        separator.setSeparatorFrame(left: 16, right: 16)
    }
    
    
}

