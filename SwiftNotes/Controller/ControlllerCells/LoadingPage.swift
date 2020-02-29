//
//  LoadingPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/2/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit

class LoadingPage: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("Reload this Page")
    }
    
}


/*
 视图加载顺序
 1. alloc               创建对象，分配空间
 2. init                初始化对象，初始化数据
 3. loadView            载入中
 4. viewDidLoad         载入完成，可以进行自定义数据以及动态创建其他控件
 5. viewWillAppear      视图将出现在屏幕之前，马上这个视图就会被展现在屏幕上了
 6. viewDidAppear       视图已在屏幕上渲染完成
 
 视图销毁顺序
 1. viewWillDisappear            视图将被从屏幕上移除之前执行
 2. viewDidDisappear             视图已经被从屏幕上移除，用户看不到这个视图了
 3. dealloc          视图被销毁，此处需要对你在init和viewDidLoad中创建的对象进行释放
 */

/*
 viewDidLoad 只会加载一次
 viewWillAppear 每次回到页面就会重新加载(包括返回、标签切换)，但不包括 unpresent 方式返回页面
 viewDidAppear 同上
 */

/*
 与viewWillAppear平行：
 1. touchesBegan       点击即触发
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
 
 */
