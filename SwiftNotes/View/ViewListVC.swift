//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let titleList = ["Animation", "Button", "Chart", "Collection View","Date Picker", "Image View", "Label", "Layer", "Nav Controller", "Page Control",  "Picker View", "Scroll View", "Segment Control", "Slider", "Stack View", "Stepper", "Styles", "Switch", "Table View", "Text Field", "Text View", "Transition", "UIList", "View", "Web View", "Window"]
    let pageList = [CSAnimationPage(), CSButtonPage(), CSChartListVC(), CollectionViewPage(), CSDatePickerPage(), CSImageViewPage(), CSLabelPage(), CSLayerView(), CSNavControllerPage(), CSPageControlPage(), CSPickerViewPage(), CSScrollViewPage(), CSSegmentControlPage(), CSSliderPage(), CSStackViewPage(), CSStepperPage(), CSStylesPage(), CSSwitchPage(),CSTableViewPage(),  CSTextFieldPage(), CSTextViewPage(), CSTransitionListPage(), CSUIListPage(), CSViewPage(), CSWebViewPage(), CSWindowPage()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "View" // 导航栏标题
        
        let tableView = UITableView()
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
        
        
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cellID1")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: kCellHeight)
        cell.setSeparator(leftInset: 20, rightInset: 0)
        
        let cellTitle = UILabel()
        cellTitle.set(superview: cell, text: titleList[indexPath.row])
        cellTitle.setFrame(left: 20, centerY: cell.centerY)
        
        let next = UIImageView()
        next.set(superview: cell, imageName: "discovery_next")
        next.setFrame(right: 20, centerY: cell.centerY, width: 16, height: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: pageList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

/*
 在VC下，可以给某按钮操作设置以下属性，实现tab切换
 self.tabBarController?.selectedIndex = 2
 
 要需要隐藏元素不占位时，y值最好用赋值的方式来处理，而不是 +=/-= 来处理，后者在扩展时容易出错
 
 */
