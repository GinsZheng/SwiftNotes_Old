//
//  PinchGesturePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSPinchGesturePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture))
        view.addGestureRecognizer(pinch)
    }
    
    @objc func pinchGesture() {
        print("Pinch")
    }
}

