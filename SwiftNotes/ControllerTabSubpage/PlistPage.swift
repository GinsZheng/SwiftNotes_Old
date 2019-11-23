//
//  plistPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/7/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

class PlistPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let myPlist: String = Bundle.main.path(forResource: "Books", ofType: "plist")!
        let BooksList = NSArray(contentsOfFile: myPlist)!
        let Books2018 = BooksList[0] as! NSDictionary
        let firstBook = Books2018.object(forKey: "腾讯传") as! String
        
        // feedback
        let label = UILabel()
        label.set(superview: view, text: firstBook)
        label.makeConstraints(left: 20, top: 100)
    }
    
}
