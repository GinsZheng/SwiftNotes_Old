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

//        let imgView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 20))
//        self.view.addSubview(imgView)
        
        let tuples = [(1, 1), (2, 2), (3, 6), (4, 9)]
        for (x, y) in tuples {
            print(x, y)
        }
        
        
        label.setFrame(left: 20, top: 10)
        
        self.push(toTarget: CSLineChartPage())
    }
}
