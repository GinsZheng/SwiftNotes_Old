//
//  DisabledDismissPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/7/22.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSDisabledDismissParentPage: UIViewController {

    let button = UIButton()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)

        button.setup(superview: view, target: self, action: #selector(presentNext))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "Present")
        button.setFrame(left: 20, top: 10, right: 20, height: 44)
    }
    
    @objc func presentNext() {
        // 禁用子页面下滑手势
        let vc = CSDisabledDismissChildPage()
        self.present(targetVC: vc, completion: {
            vc.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
        })
        
        
    }
}


class CSDisabledDismissChildPage: UIViewController {
    
    // 必备3参数
    var touchesBeganPoint = CGPoint(x: 0, y: 0)
    var isClosing = false
    var dampingDegree: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
    }
    
    // 获取滑动距离
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesBeganPoint = view.getTouchPoint(touches: touches)
    }
    
    // 滑动距离判断与跟手动画
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let previousPoint = touch.previousLocation(in: view)
            let point = touch.location(in: view)
            let pointsGap = point.y - previousPoint.y
            let swipeDistance = point.y - touchesBeganPoint.y

            dampingDegree += 1/2
            if pointsGap > 0 {
                view.y += pointsGap / CGFloat(dampingDegree)
                view.setCornerRadius(radius: 10)
            }
            
            if swipeDistance > 80 {
                isClosing = true
            }
        }
    }
    
    // 弹出操作表与复位
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
            self.view.y = 0
            if self.isClosing {
                self.confirmCancel()
                self.isClosing = false
            }
        })
        dampingDegree = 2
    }
    
    // 弹出操作表
    func confirmCancel() {
        actionSheet(title: "确定要放弃上次进度列表吗？", actionsTitle: ["放弃上次记录"], actionsStyle: [.destructive], actionsHandler: [
            { (x) in
                self.dismiss()
            }
        ])
    }
    
}


/*
 在iOS13的默认的 present 为 .automatic 样式下:
 ‣ present后的页面：view的高度为全屏高度，y=0值则为卡片的顶端(iPhoneX为全屏的y=54)
 ‣ 如果有滑动，则touchesMoved只能获取前面滑动的约10pt的点
 ‣ 如果有滑动，则touchesEnded无法获取
 ‣ 一种处理方法见上：让子页面的下滑手势失效
 */
