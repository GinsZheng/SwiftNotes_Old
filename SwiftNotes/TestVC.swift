//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SwiftCSV
import SwiftyJSON

class TestVC: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        button.set(superview: view, target: self, action: #selector(presentNext))
        button.setStyleSolidBtn(title: "Present")
        button.setFrame(left: 20, top: 10, right: 20, height: 44)
    }
    
    @objc func presentNext() {
        // 禁用子页面下滑手势
        let vc = TestPresentedVC()
        self.present(toTarget: vc, completion: {
            vc.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
        })
        
        
    }
}

class TestPresentedVC: UIViewController {
    
    // 必备3参数
    var startTouchPoint = CGPoint(x: 0, y: 0)
    var isClosing = false
    var dampingDegree: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    // 获取滑动距离
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            startTouchPoint = touch.location(in: view)
        }
    }
    
    // 滑动距离判断与跟手动画
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let previousPoint = touch.previousLocation(in: view)
            let point = touch.location(in: view)
            let pointsGap = point.y - previousPoint.y
            let swipeDistance = point.y - startTouchPoint.y

            dampingDegree += 1/2 // 阻尼设计
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
