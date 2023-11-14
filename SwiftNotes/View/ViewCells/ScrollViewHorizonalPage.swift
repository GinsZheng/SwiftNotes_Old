//
//  ScrollViewHorizonalPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/9.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class ScrollViewHorizonalPage: UIViewController {
    
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

        let buttonList = CSHorizonalScrollingButtonList(target: self, action: #selector(pushToTest), frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 48))
        buttonList.set(superview: groupBg)
    }
    
    
    // MARK: - @objc func
    @objc func pushToTest() {
        self.push(toTarget: CSGeneralSubpage())
    }
    
    
}



// MARK: - scrollView 横滑按钮列表View
class CSHorizonalScrollingButtonList: UIView {
    // ❓下一步：把buttonTitles加入init的参数
    let scrollView = UIScrollView()
    var buttons: [UIButton] = []
    
    var target: UIViewController
    var action: Selector

    init(target: UIViewController, action: Selector, forEvent: UIControl.Event = UIControl.Event.touchUpInside, frame: CGRect) {
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
        let buttonTitles = ["默认", "今天", "Button 3", "Button 4", "Button 5",
                            "Button 6", "Button 7", "Button 8", "Button 9", "Button 10",
                            "Button 11", "Button 12", "Button 13", "Button 14", "Button 15"]
        
        var frameRight: CGFloat = 0
        
        for (i, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .custom)
            button.set(superview: scrollView, target: target, action: action)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.hex(c666), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
            button.setBackgroundColor(color: cF0F1F3)
            button.setCornerRadiusWithMask(radius: 14)
            button.setBackgroundImage(getImageWithColor(color: cDDDEE0), for: .highlighted)
            

            let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
            if i == 0 {
                button.setFrame(left: 10, centerY: scrollView.centerY, width: labelWidth + 24, height: 28)
            } else {
                button.setFrame(left: frameRight, centerY: scrollView.centerY, width: labelWidth + 24, height: 28)
            }
            
            frameRight = button.right + 6
            
            buttons.append(button)
        }
        
        scrollView.contentSize = CGSize(width: frameRight + 4, height: 48)
    }
    
}

