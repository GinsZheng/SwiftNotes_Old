//
//  plistPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/7/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

class CSPlistPage: UIViewController {
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)

        let myPlist: String = Bundle.main.path(forResource: "Books", ofType: "plist")!
        let BooksList = NSArray(contentsOfFile: myPlist)!
        let Books2018 = BooksList[0] as! NSDictionary
        let firstBook = Books2018.object(forKey: "腾讯传") as! String
        print("firstBook", firstBook)
        
        // feedback
        let label = UILabel()
        label.setup(superview: view, text: firstBook)
        label.setFrame(left: 20, top: 20)
        
    }
    
    
    
    
}
