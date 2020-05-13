//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import Hero
 
class TestVC: UIViewController, UITextFieldDelegate {

    
    let textField2 = UITextField()
    
    let imgView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        if determinePanDirection(touchPoint: <#T##CGPoint#>, beginPoint: <#T##CGPoint#>)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取点击的坐标位置
        for touch:AnyObject in touches {
            let t:UITouch = touch as! UITouch
            print(t.location(in: self.view))
        }
    }
    
}

enum PanDirection {
    case unknown
    case horizontal
    case vertical
}

// 最小移动距离
private let leastDistance: Float = 15

/// 确定滑动方向
func determinePanDirection(touchPoint: CGPoint,
                           beginPoint: CGPoint) -> PanDirection {
    // 不确定方向，先判断滑动方向
    let dragX = touchPoint.x - beginPoint.x
    let dragY = touchPoint.y - beginPoint.y
    if fabsf(Float(dragX)) > leastDistance + 30 {
        return .horizontal
    }
    if fabsf(Float(dragY)) > leastDistance {
        return .vertical
    }
    return .unknown
}
