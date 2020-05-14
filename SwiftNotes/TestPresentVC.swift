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

//        self.isModalInPresentation = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(activeActionSheet))
        view.addGestureRecognizer(pan)
        
    }

    @objc func activeActionSheet() {
        
        self.view.y = 100
    }
}

