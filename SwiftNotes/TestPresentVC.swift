//
//  TestPresentVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//
//  TestPresentVC

import UIKit
 
class TestPresentVC: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        label.set(superview: view, text: "TestPresent")
        label.setStyle24pt222Med()
        label.setFrame(left: 20, top: 20)
        
        let scrollView = UIScrollView()
        scrollView.set(superview: view)
        scrollView.setFrame(left: 0, top: 0, width: kScreenWidth, height: 400)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenWidth/375*812)
        scrollView.OptimizeEdgePanGesture(of: self)
        
        let image = UIImageView()
        image.set(superview: scrollView, imageName: "iPhoneX")
        image.setFrame(left: 0, top: 0, width: kScreenWidth, height: kScreenWidth/375*812)
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let point = t.location(in: self.view)
            print("移动中\(point)")
            
//            actionSheet(actionsTitle: ["放弃"], actionsStyle: [.destructive], actionsHandler: [{
//                (x) in
//                self.dismiss()
//                }])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //获取点击的坐标位置
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let point = t.location(in: self.view)
            print(point)
        }
        
    }
    
    
}

