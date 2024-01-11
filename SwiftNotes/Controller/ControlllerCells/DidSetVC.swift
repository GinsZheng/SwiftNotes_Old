//
//  DidSetVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/30.
//  Copyright © 2023 GinsMac. All rights reserved.
//

/// 使用属性观察器willSet和didSet来监控属性值的变化。当属性值改变时，属性观察器会自动被触发。您可以在这些观察器中更新UI或执行其他必要的操作。

import UIKit

class DidSetVC: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let DidSetCutomView = DidSetCutomView(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        view.addSubview(DidSetCutomView)
        
        DidSetCutomView.fetchDataClosure = {
            return "Hello from ViewController"
        }
        
    }
    
}


// MARK: - 自定义视图
class DidSetCutomView: UIView {
    var fetchDataClosure: (() -> String)? {
        didSet { // 实现了：当一个值改变时，自动触发一些动作(比如说更新某些内容)
            updateData()
        }
    }
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dataLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dataLabel.frame = bounds
    }
    
    func updateData() {
        let data = fetchDataClosure?() ?? "No data"
        dataLabel.text = data // 可以理解为：UILabel的text这个属性自带DidSet，所以text值更新时就会自动刷新UI
    }
}
