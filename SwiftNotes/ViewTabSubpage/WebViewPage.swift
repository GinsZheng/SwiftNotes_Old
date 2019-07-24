//
//  WebViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/7/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import WebKit

class WebViewPage: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let url = URL(string: "https://www.apple.com/")
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
    
}

// 在Info.plist新建一行：App Transport Security Settings且添加子文件 Allow Arbitrary Loads,值改为YES。表示可自由加载
