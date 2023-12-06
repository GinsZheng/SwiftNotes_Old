//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewListVC: UIViewController {
    
    let list: [(String, UIViewController)] = [
        ("Animation", AnimationPage()),
        ("Button", ButtonPage()),
        ("Camera and Photos", CameraAndPhotosPage()),
        ("Collection View", CollectionViewListPage()),
        ("Date Picker", DatePickerPage()),
        ("Image View", ImageViewPage()),
        ("Label", LabelPage()),
        ("Layer", LayerView()),
        ("Nav Controller", NavControllerPage()),
        ("Page Control", PageControlPage()),
        ("Picker View", PickerViewPage()),
        ("Scroll View", ScrollViewPage()),
        ("Scroll View Horizonal", ScrollViewHorizonalPage()),
        ("Segment Control", SegmentControlPage()),
        ("Slider", SliderPage()),
        ("Stack View", StackViewPage()),
        ("Stepper", StepperPage()),
        ("Styles", StylesPage()),
        ("Switch", SwitchPage()),
        ("Table View", TableViewPage()),
        ("Text Field", TextFieldPage()),
        ("Text View", TextViewPage()),
        ("Transition", TransitionListPage()),
        ("UIList", UIListPage()),
        ("Video Player", VideoPlayerPage()),
        ("View", ViewPage()),
        ("ViewController", ViewControllerPage()),
        ("Web View", WebViewPage()),
        ("Window", WindowPage()),
    ]
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View" // 导航栏标题
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: String(describing: DefaultTableViewCell.self))
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
    }
    
    
    
    // MARK: - @objc func
    
    
}


// MARK: - tableview 代理方法
extension ViewListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
        cell.configure(title: list[indexPath.row].0)
        return cell
    }
}


// MARK: - tableview 代理方法
extension ViewListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: list[indexPath.row].1)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


/*
 在VC下，可以给某按钮操作设置以下属性，实现tab切换
 self.tabBarController?.selectedIndex = 2
 
 要需要隐藏元素不占位时，y值最好用赋值的方式来处理，而不是 +=/-= 来处理，后者在扩展时容易出错
 
 */
