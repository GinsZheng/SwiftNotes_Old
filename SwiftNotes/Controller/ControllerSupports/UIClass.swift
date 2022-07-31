//
//  CSUIClass.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/21.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSUIClass: UIView {
    
    private var progressBarBg = UIView()
    private var progressBar = UIView()
    private var progressBarLabel = UILabel()
    
    private var innerPercentage: Double
    private var innerColor: String
    
    init(percentage : Double = 0.0, color: String = cBlue_5393FF) {
        innerPercentage = percentage
        innerColor = color
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(superview: UIView, percentage: Double) {
        innerPercentage = percentage
        progressBarBg.set(superview: superview)
        progressBar.set(superview: progressBarBg)
        progressBarLabel.set(superview: progressBar, text: "\(Int(innerPercentage*100))%")
    }
    
    func setStyles(color: String) {
        progressBarBg.setStyleProgressBarBg()
        progressBar.setStyleProgressBar(color: color)
        progressBarLabel.setStyle12ptFEFEFEMedCenter()
    }
    
    func setFrames(left: CGFloat, top: CGFloat, right: CGFloat, height: CGFloat) {
        
        progressBarBg.setFrame(left: left, top: top, right: right, height: height)
        
        if innerPercentage < 0.01 {
            progressBar.setFrame(left: 0, top: 0, width: 38, height: 16)
        } else {
            let progressBarWidth = 38 + (progressBarBg.width-38) * CGFloat(innerPercentage)
            progressBar.setFrame(left: 0, top: 0, width: progressBarWidth, height: 16)
        }
        
        progressBarLabel.setFrame(center: progressBar)
    }

}

