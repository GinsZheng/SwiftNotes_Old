//
//  TouchGesturePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/13.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSTouchesBeganGesturePage: UIViewController {
    
    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        myView.set(superview: view, backgroundColor: cBlue_5393FF)
        myView.setCornerRadius(radius: 4)
        myView.setFrame(left: 20, top: 20, width: 44, height: 44)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取点击的坐标位置
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let point = t.location(in: self.view)
            myView.point = point
            print(point)
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            print("点击结束\(t.location(in: self.view))")
        }
    }
    
    
}

