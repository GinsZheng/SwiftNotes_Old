//
//  HideBackBtn.swift
//  SwiftNotes
//
//  Created by GinsMac on 2022/9/16.
//  Copyright © 2022 GinsMac. All rights reserved.
//

import UIKit

class CSHideBackBtnPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        // 隐藏返回按钮
        self.hideBackBtn()
    }
    
    // 屏蔽侧滑返回：1.在viewDidAppear屏蔽
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.popGestureClose()
    }
    
    // 屏蔽侧滑返回：2.在viewWillDisappear中恢复
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.popGestureOpen()
    }


    // MARK: - 备用方法
    // 查到的方法中写在 viewWillAppear 中，但目前看放 viewDidLoad 也没有问题
    //    override func viewWillAppear(_ animated: Bool) {
    //        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
    //        navigationItem.leftBarButtonItem = backButton
    //    }

}

