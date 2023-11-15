//
//  ScrollViewHorizonalPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/9.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class ScrollViewHorizonalPage: UIViewController {
    
    var titles = ["默认", "今天", "Button 3", "Button 4", "Button 5",
                  "Button 6", "Button 7", "Button 8", "Button 9", "Button 10",
                  "Button 11", "Button 12", "Button 13", "Button 14", "Button 15"]
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
        let groupBg = UIView()
        groupBg.set(superview: view, backgroundColor: cFFF)
        groupBg.setFrame(left: 0, top: 100, width: kScreenWidth, height: 48)
        
        let buttonList = CSHorizonalScrollingButtonList(titles: titles, target: self, action: #selector(pushToTest), frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 48))
        buttonList.set(superview: groupBg)
    }
    
    
    // MARK: - @objc func
    @objc func pushToTest() {
        self.push(toTarget: CSGeneralSubpage())
    }
    
    
}



// MARK: - scrollView 横滑按钮列表View
class CSHorizonalScrollingButtonList: UIView {
    let scrollView = UIScrollView()
    var buttons: [UIButton] = []
    
    var target: UIViewController
    var action: Selector
    var titles: [String]
    
    init(titles: [String], target: UIViewController, action: Selector, forEvent: UIControl.Event = UIControl.Event.touchUpInside, frame: CGRect) {
        self.titles = titles
        self.target = target
        self.action = action
        super.init(frame: frame)
        
        setupScrollView()
        createButtons()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView() {
        scrollView.set(superview: self)
        scrollView.setFrame(allEdges: 0)
        scrollView.OptimizeEdgePanGesture(of: target)
    }
    
    func createButtons() {
        
        var frameRight: CGFloat = 0 // 用于记录下一个按钮的左边界位置
        
        for (i, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.set(superview: scrollView, target: target, action: action)
            button.setStyleSolidButton(title: title, titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
            
            // 计算按钮frame的参数
            let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
            let buttonLeft = (i == 0) ? 10 : frameRight // 第一个按钮左边距为10，其他跟随上一个按钮的右边
            let buttonWidth = labelWidth + 24
            let buttonHeight: CGFloat = 28
            let buttonCenterY = scrollView.centerY
            // 设置按钮的frame
            button.setFrame(left: buttonLeft, centerY: buttonCenterY, width: buttonWidth, height: buttonHeight)
            
            // 更新frameRight以便下一个按钮使用
            frameRight = button.right + 6
            
            buttons.append(button)
        }
        
        scrollView.contentSize = CGSize(width: frameRight + 4, height: 48)
    }
    
}

