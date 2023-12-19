//
//  PinchGesturePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSPinchGesturePage: UIViewController {
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        setupPinch()
    }
    
    
    // MARK: - func
    func setupPinch() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture))
        view.addGestureRecognizer(pinch)
    }
    
    
    // MARK: - @objc func
    @objc func pinchGesture() {
        print("Pinch")
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch: AnyObject in touches {
//            let t: UITouch = touch as! UITouch
//            print(t.location(in: self.view))
//        }
//    }
}

