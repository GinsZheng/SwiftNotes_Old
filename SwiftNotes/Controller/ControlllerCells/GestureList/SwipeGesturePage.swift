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
        
        setupSwipeGesture()
    }
    
    
    // MARK: - func
    func setupSwipeGesture() {
        let swipeUp = UISwipeGestureRecognizer(target:self, action:#selector(swipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
          
        let swipeDown = UISwipeGestureRecognizer(target:self, action:#selector(swipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
    }
    
    // MARK: - @objc func

    //滑动手势
    @objc func swipeGesture(_ swip: UISwipeGestureRecognizer) {
        if swip.direction == UISwipeGestureRecognizer.Direction.up {
            print("向上滑动")
        }else if swip.direction == UISwipeGestureRecognizer.Direction.down {
            print("向下滑动")
        }
    }
    

}
