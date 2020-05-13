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
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        

        scrollView.set(superview: view)
        scrollView.setFrame(left: 0, top: 0, width: kScreenWidth, height: 400)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenWidth/375*812)
        
        let image = UIImageView()
        image.set(superview: scrollView, imageName: "iPhoneX")
        image.setFrame(left: 0, top: 0, width: kScreenWidth, height: kScreenWidth/375*812)
        
        scrollView.OptimizeEdgePanGesture(of: self)
//        let gestureArray: [AnyObject] = self.navigationController!.view.gestureRecognizers!
//
//        for gesture in gestureArray {
//            if gesture.isKind(of: UIScreenEdgePanGestureRecognizer.self) {
//                self.scrollView.panGestureRecognizer.require(toFail: gesture as! UIGestureRecognizer)
//            }
//        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取点击的坐标位置
        for touch:AnyObject in touches {
            let t:UITouch = touch as! UITouch
            print(t.location(in: self.view))
        }
    }
    


}





