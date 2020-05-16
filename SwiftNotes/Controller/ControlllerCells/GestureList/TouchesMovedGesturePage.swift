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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        myView.set(superview: view, backgroundColor: cBlue_2C9EFF)
        myView.setCornerRadius(radius: 4)
        myView.setFrame(left: 20, top: 20, width: 44, height: 44)
    }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let point = t.location(in: self.view)
            myView.point = point
            print(point)
        }
    }
    
}

