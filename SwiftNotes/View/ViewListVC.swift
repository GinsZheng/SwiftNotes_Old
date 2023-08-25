//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list: [(String, UIViewController)] = [
        ("Animation", CSAnimationPage()),
        ("Button", CSButtonPage()),
        ("Camera and Photos", CSCameraAndPhotosPage()),
        ("Chart", CSChartListVC()),
        ("Collection View", CollectionViewPage()),
        ("Date Picker", CSDatePickerPage()),
        ("Image View", CSImageViewPage()),
        ("Label", CSLabelPage()),
        ("Layer", CSLayerView()),
        ("Nav Controller", CSNavControllerPage()),
        ("Page Control", CSPageControlPage()),
        ("Picker View", CSPickerViewPage()),
        ("Scroll View", CSScrollViewPage()),
        ("Scroll View Horizonal", CSScrollViewHorizonalPage()),
        ("Segment Control", CSSegmentControlPage()),
        ("Slider", CSSliderPage()),
        ("Stack View", CSStackViewPage()),
        ("Stepper", CSStepperPage()),
        ("Styles", CSStylesPage()),
        ("Switch", CSSwitchPage()),
        ("Table View", CSTableViewPage()),
        ("Text Field", CSTextFieldPage()),
        ("Text View", CSTextViewPage()),
        ("Transition", CSTransitionListPage()),
        ("UIList", CSUIListPage()),
        ("Video Player", CSVideoPlayerPage()),
        ("View", CSViewPage()),
        ("ViewController", CSViewControllerPage()),
        ("Web View", CSWebViewPage()),
        ("Window", CSWindowPage()),
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View" // 导航栏标题

        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: String(describing: DefaultTableViewCell.self))
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)

    }
    
    
    // MARK: - tableview 代理

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: list[indexPath.row].1)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
        cell.titleLabel.setText(text: list[indexPath.row].0)
        
        return cell
    }
    
    // MARK: - @objc
    
}



/*
 在VC下，可以给某按钮操作设置以下属性，实现tab切换
 self.tabBarController?.selectedIndex = 2
 
 要需要隐藏元素不占位时，y值最好用赋值的方式来处理，而不是 +=/-= 来处理，后者在扩展时容易出错
 
 */
