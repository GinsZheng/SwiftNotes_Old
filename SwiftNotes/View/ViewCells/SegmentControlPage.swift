//
//  CSSegmentControlPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/16.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSSegmentControlPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let segmentControl = UISegmentedControl(items: ["FirstSegment", "SecondSegment"])
        segmentControl.set(superview: view, target: self, action: #selector(showSelectedSegment(_:)), for: .valueChanged)
        segmentControl.setFrame(left: 20, top: 20, right: 20, height: 36)
        
    }
    
    
    @objc func showSelectedSegment(_ segmentControl:UISegmentedControl) {
        print(segmentControl.selectedSegmentIndex)
        print(segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)!)
    }
    
}
