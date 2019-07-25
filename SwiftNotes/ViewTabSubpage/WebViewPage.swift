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
    
    var webView = WKWebView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setBackgroundColor(color: colorFFF)
        
        self.progressView.makeConstraints(left: 0, top: kNavBarHeight, width: kScreenWidth, height: 2)
        self.progressView.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.progressView.progress = 0.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.makeConstraints(left: 0, top: kNavBarHeight, width: kScreenWidth, height: kHeightWithoutNavBar)
        webView.navigationDelegate = self
        
        let url = "https://www.apple.com"
        let mapwayURL = URL(string: url)!
        let mapwayRequest = URLRequest(url: mapwayURL)
        webView.load(mapwayRequest)
        
        view.addSubview(self.progressView)
    }
    
    // 进度条
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = UIColor.hex(color2C9EFF)
        progress.trackTintColor = .clear
        return progress
    }()
    
}

extension WebViewPage: WKNavigationDelegate{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        self.navigationItem.title = "加载中..."
        /// 获取网页的progress
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = Float(self.webView.estimatedProgress)
        }
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        /// 获取网页title
        self.title = self.webView.title
        
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 1.0
            self.progressView.isHidden = true
        }
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
        /// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
            _=self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
        
    }
    
}
