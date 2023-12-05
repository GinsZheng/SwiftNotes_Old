//
//  ScrollViewHorizonalPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/9.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class ScrollViewHorizonalPage: UIViewController, HorizonalScrollingButtonsDelegate {
    
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
        
        let buttons = CSHorizonalScrollingButtons(titles: titles, delegate: self, target: self)
        buttons.set(superview: groupBg)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupUI(showsHorizontalScrollIndicator: false)
    }
    
    
    // MARK: - 代理方法
    func buttons(_ buttons: CSHorizonalScrollingButtons, didSelectButtonAtIndex index: Int) {
        self.push(toTarget: CSGeneralSubpage())
    }
    
}



// MARK: - scrollView 横滑按钮列表View

class CSHorizonalScrollingButtons: UIView {
    let scrollView = UIScrollView()
    var buttons: [UIButton] = []
    
    var titles: [String]
    var target: UIViewController
    var forEvent: UIControl.Event
    
    weak var delegate: HorizonalScrollingButtonsDelegate?
    
    /// - 参数:
    ///   - titles: 每个按钮的标题
    ///   - target: 填self。用于处理scrollView侧滑冲突
    ///   - forEvent: 触发事件，默认为 touchUpInside
    ///   - delegate: 填self。为指定 HorizonalScrollingButtonsDelegate 的代理
    init(titles: [String], delegate: HorizonalScrollingButtonsDelegate, target: UIViewController, forEvent: UIControl.Event = .touchUpInside) {
        self.titles = titles
        self.target = target
        self.forEvent = forEvent
        self.delegate = delegate
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - func
    func setupUI(showsHorizontalScrollIndicator: Bool) {
        setupScrollView(showsHorizontalScrollIndicator: showsHorizontalScrollIndicator)
        createButtons()
    }
    
    func setupScrollView(showsHorizontalScrollIndicator: Bool) {
        scrollView.set(superview: self)
        scrollView.setFrame(allEdges: 0)
        scrollView.OptimizeEdgePanGesture(of: target)
        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    }
    
    func createButtons() {
        
        var buttonLeft: CGFloat = 10 // 用于记录下一个按钮的左边界位置
        let buttonHeight: CGFloat = 28
        let buttonCenterY = scrollView.centerY
        let titleOffset: CGFloat = 24
        let itemInterval: CGFloat = 6
        let scrollViewTailOffset: CGFloat = 4
        
        for (i, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = i // 用于标识是哪个button，以便在代理中赋值给didSelectButtonAtIndex，实现按不同按钮响应不同操作
            button.set(superview: scrollView, target: self, action: #selector(buttonTapped), forEvent: forEvent)
            button.setStyleSolid14pt666LightGrayRoundedButton(title: title)
            
            // 计算按钮frame的参数
            let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
            let buttonWidth = labelWidth + titleOffset
            // 设置按钮的frame
            button.setFrame(left: buttonLeft, centerY: buttonCenterY, width: buttonWidth, height: buttonHeight)
            
            // 更新buttonLeft以便下一个按钮使用
            buttonLeft = button.right + itemInterval
            
            buttons.append(button)
        }
        
        scrollView.contentSize = CGSize(width: buttonLeft + scrollViewTailOffset, height: 48)
    }
    
    
    // MARK: - 代理方法
    @objc private func buttonTapped(_ button: UIButton) {
        delegate?.buttons(self, didSelectButtonAtIndex: button.tag)
    }

}

/// 注：CSHorizonalScrollingButtons可以继续抽象出一个更通用的类，就像UITableView一样。比如把 createButtons() 抽象成一个像：
/// func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
/// 这样的函数




