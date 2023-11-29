//
//  CSDelegate2Page.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/2/12.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit

protocol CSRefreshDataDelegate: NSObjectProtocol {
    func refreshData()
}


// 委托
class CSDelegator: UIViewController {
    
    let button = UIButton()
    
    weak var delegate: CSRefreshDataDelegate?
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        button.set(superview: view, target: self, action: #selector(backToSuperpage))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "返回上页并隐藏按钮")
        button.setFrame(left: 20, top: 20, right: 20, height: 44)
    }
    
    
    // MARK: - @objc func

    @objc func backToSuperpage() {
        if delegate != nil {
            delegate!.refreshData()
        }
        self.pop()
    }
    
    
}


// 受托
class CSDelegate2Page: UIViewController, CSRefreshDataDelegate {
    
    let button = UIButton()
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        button.set(superview: view, target: self, action: #selector(pushToSubpage))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "下一页")
        button.setFrame(left: 20, top: 20, right: 20, height: 44)
    }
    
    
    // MARK: - 代理方法
    func refreshData() {
        button.isHidden = true
    }
    
    
    // MARK: - @objc func
    
    @objc func pushToSubpage() {
        let delegator = CSDelegator()
        delegator.delegate = self
        self.push(toTarget: delegator)
    }
    
    
}

