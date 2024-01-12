//
//  SegmentControlPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/16.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class SegmentControlPage: UIViewController {
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let segmentControl = UISegmentedControl(items: ["FirstSegment", "SecondSegment"])
        segmentControl.setup(superview: view, target: self, action: #selector(showSelectedSegment(_:)), for: .valueChanged)
        segmentControl.setFrame(left: 20, top: 20, right: 20, height: 36)
    }
    
    // MARK: - @objc func
    @objc func showSelectedSegment(_ segmentControl:UISegmentedControl) {
        print(segmentControl.selectedSegmentIndex)
        print(segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)!)
    }
    
}
