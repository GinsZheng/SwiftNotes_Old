//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

//import UIKit
//
//class TestVC: UIViewController {
//
//    let label = UILabel()
//
//    let imgView = UIImageView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        label.set(superview: view, text: "Test")
//        label.setStyle24pt222Med()
//        label.setFrame(left: 20, top: 0)
//
//        imgView.set(superview: view, imageName: "iPhoneX")
//        imgView.setFrame(left: 0, top: 40, width: 200, height: 300)
//
//
//    }
//
//}
//


import UIKit
 
class TestVC: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        label.set(superview: view, text: "TestPresent")
        label.setStyle24pt222Med()
        label.setFrame(left: 20, top: 20)

        self.isModalInPresentation = true
        
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(activeActionSheet))
//        view.addGestureRecognizer(pan)
        
        let scrollView = UIScrollView()
        scrollView.set(superview: view)
        scrollView.setFrame(left: 0, top: 0, width: kScreenWidth, height: 400)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenWidth/375*812)
        scrollView.OptimizeEdgePanGesture(of: self)
        
        let image = UIImageView()
        image.set(superview: scrollView, imageName: "iPhoneX")
        image.setFrame(left: 0, top: 0, width: kScreenWidth, height: kScreenWidth/375*812)
        
        self.push(toTarget: CSLineChartPage())
    }

//    @objc func activeActionSheet() {
//
////        self.view.y = 100
//    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let point = t.location(in: self.view)
            print(point)
        }
    }
    

}

