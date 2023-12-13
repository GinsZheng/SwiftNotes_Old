//
//  TouchMovedPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/16.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSTouchesMovedGesturePage: UIViewController {
    
    let myView = UIView()
    
    // MARK: - 生命周期方法

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.touchesMovedUpOrDwon(touches: touches) {
            print("uporDown")
        }
        view.touchesMovedUp(touches: touches) {
            print("up")
        }
        view.touchesMovedDown(touches: touches) {
            print("down")
        }
        view.touchesMovedLeft(touches: touches) {
            print("left")
        }
        view.touchesMovedRight(touches: touches) {
            print("right")
        }
        view.touchesMovedLeftOrRight(touches: touches) {
            print("leftOrRight")
        }
    }
    
    // 让myView跟手移动
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for touch: AnyObject in touches {
    //            let t: UITouch = touch as! UITouch
    //            let point = t.location(in: self.view)
    //            myView.point = point
    //            print(point)
    //        }
    //    }
    
    // 让view跟手上下滑动
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        for touch: AnyObject in touches {
    //            let t: UITouch = touch as! UITouch
    //            let previousPoint = t.previousLocation(in: self.view)
    //            let point = t.location(in: self.view)
    //            view.y += point.y - previousPoint.y // 通过前一点与后一点的差值，来设置view的y值，实现上下滑动
    //            view.y = 0
    //            view.setCornerRadius(radius: 10)
    //        }
    //    }
    
    
    // MARK: - func
    func setupUI() {
        view.backgroundColor = .white
        
        myView.setup(superview: view, backgroundColor: cBlue_5393FF)
        myView.setCornerRadius(radius: 4)
        myView.setFrame(left: 20, top: 20, width: 44, height: 44)
    }
    
}

/*
 在UITextField等已经有手势的控件里(很可能包括所有可交互的控件)，touchedMoved无效
 */
