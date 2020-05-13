//
//  TouchGesturePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/13.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSTouchGesturePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取点击的坐标位置
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            print(t.location(in: self.view))
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取手指滑动时的当前坐标位置(持续刷新，刷新频率大概就是屏幕的解控采样率)
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            print(t.location(in: self.view))
        }
    }
    
}

