//
//  Delegate2Page.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/2/12.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit

protocol RefreshDataDelegate: NSObjectProtocol {
    func refreshData()
}

class Delegate2Page: UIViewController, RefreshDataDelegate {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        button.set(superview: view, target: self, action: #selector(pushToSubpage))
        button.setStyleSolidBtn(title: "下一页")
        button.setFrame(left: 20, top: 20, right: 20, height: 44)
        
    }
    
    @objc func pushToSubpage() {
        let delegator = Delegator()
        delegator.delegate = self
        self.push(toTarget: delegator)
    }
    
    func refreshData() {
        button.isHidden = true
    }
    
    
}

class Delegator: UIViewController {
    
    weak var delegate: RefreshDataDelegate?
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        button.set(superview: view, target: self, action: #selector(backToSuperpage))
        button.setStyleSolidBtn(title: "返回上页并隐藏按钮")
        button.setFrame(left: 20, top: 20, right: 20, height: 44)
    }
    
    @objc func backToSuperpage() {
        if delegate != nil {
            delegate!.refreshData()
        }
        self.pop()
    }
    
    // 内存管理
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 析构
    deinit {
        print("释放")
    }
}
