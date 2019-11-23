//
//  SegmentControlPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/16.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class SegmentControlPage: UIViewController {
    
    @objc func showSelectedSegment(_ segmentControl:UISegmentedControl) {
        print(segmentControl.selectedSegmentIndex)
        print(segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let segmentControl = UISegmentedControl(items: ["FirstSegment", "SecondSegment"])
        view.addSubview(segmentControl)
        segmentControl.makeConstraints(left: 20, top: 100, right: 20, height: 36)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(showSelectedSegment(_:)), for: .valueChanged) // 按钮传参的情况，传的是控件本身
        
        
    }
    
    
}
