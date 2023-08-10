//
//  ScrollViewHorizonalPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/9.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class CSScrollViewHorizonalPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)

        let buttonList = CSHorizonalScrollingButtonList(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 80))
        buttonList.set(superview: view)
        buttonList.scrollView.OptimizeEdgePanGesture(of: self)
    }
    
    
}


class CSHorizonalScrollingButtonList: UIView {

    let scrollView = UIScrollView()
    var buttons: [UIButton] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScrollView()
        createButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupScrollView()
        createButtons()
    }
    
    func setupScrollView() {
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: 3000, height: 200)
        addSubview(scrollView)
    }

    func createButtons() {
        let buttonTitles = ["Button 1", "Button 2", "Button 3", "Button 4", "Button 5",
                            "Button 6", "Button 7", "Button 8", "Button 9", "Button 10",
                            "Button 11", "Button 12", "Button 13", "Button 14", "Button 15"]
        
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: CGFloat(index) * frame.height, y: 0, width: frame.height, height: frame.height)
            button.setTitle(title, for: .normal)
            button.backgroundColor = UIColor.blue // Set your desired background color here
            button.layer.cornerRadius = frame.height / 2 // To create a rounded appearance
            button.clipsToBounds = true // To ensure the corner radius is applied
            
            scrollView.addSubview(button)
            buttons.append(button)
        }
    }
}
