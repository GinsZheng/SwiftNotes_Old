//
//  SwipeGesture.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSSwipeGesturePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        let swipeUp = UISwipeGestureRecognizer(target:self, action:#selector(swipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
          
        let swipeDown = UISwipeGestureRecognizer(target:self, action:#selector(swipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    //滑动手势
    @objc func swipeGesture(_ swip: UISwipeGestureRecognizer) {
        print("开始滑动")
        if swip.direction == UISwipeGestureRecognizer.Direction.up {
            print("向上滑动")
        }else if swip.direction == UISwipeGestureRecognizer.Direction.down {
            print("向下滑动")
        }
    }
}

/*
 在 present = .automitic 之下，自定义的滑动手势被屏蔽
 */
