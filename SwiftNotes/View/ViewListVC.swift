//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewListVC: UIViewController {
    
    let tableData: [DefaultTableViewItem] = [
        DefaultTableViewItem(title: "Animation", viewController: AnimationPage()),
        DefaultTableViewItem(title: "Button", viewController: ButtonPage()),
        DefaultTableViewItem(title: "Camera and Photos", viewController: CameraAndPhotosPage()),
        DefaultTableViewItem(title: "Collection View", viewController: CollectionViewListPage()),
        DefaultTableViewItem(title: "Date Picker", viewController: DatePickerPage()),
        DefaultTableViewItem(title: "Image View", viewController: ImageViewPage()),
        DefaultTableViewItem(title: "Label", viewController: LabelPage()),
        DefaultTableViewItem(title: "Layer", viewController: LayerView()),
        DefaultTableViewItem(title: "Nav Controller", viewController: NavControllerPage()),
        DefaultTableViewItem(title: "Page Control", viewController: PageControlPage()),
        DefaultTableViewItem(title: "Picker View", viewController: PickerViewPage()),
        DefaultTableViewItem(title: "Scroll View", viewController: ScrollViewPage()),
        DefaultTableViewItem(title: "Scroll View Horizonal", viewController: ScrollViewHorizonalPage()),
        DefaultTableViewItem(title: "Segment Control", viewController: SegmentControlPage()),
        DefaultTableViewItem(title: "Slider", viewController: SliderPage()),
        DefaultTableViewItem(title: "Stack View", viewController: StackViewPage()),
        DefaultTableViewItem(title: "Stepper", viewController: StepperPage()),
        DefaultTableViewItem(title: "Styles", viewController: StylesPage()),
        DefaultTableViewItem(title: "Switch", viewController: SwitchPage()),
        DefaultTableViewItem(title: "Switch Scroll And Collection View Switch Scroll And Collection View", viewController: SwitchScrollAndCollectionViewPage()),
        DefaultTableViewItem(title: "Table View", viewController: TableViewPage()),
        DefaultTableViewItem(title: "Text Field", viewController: TextFieldPage()),
        DefaultTableViewItem(title: "Text View", viewController: TextViewPage()),
        DefaultTableViewItem(title: "Transition", viewController: TransitionListPage()),
        DefaultTableViewItem(title: "UIList", viewController: UIListPage()),
        DefaultTableViewItem(title: "Video Player", viewController: VideoPlayerPage()),
        DefaultTableViewItem(title: "View", viewController: ViewPage()),
        DefaultTableViewItem(title: "ViewController", viewController: ViewControllerPage()),
        DefaultTableViewItem(title: "Web View", viewController: WebViewPage()),
        DefaultTableViewItem(title: "Window", viewController: WindowPage()),
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
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kVertMargin, right: 0)
    }
    
    
    
    // MARK: - @objc func
    
}


// MARK: - tableview 代理方法
extension ViewListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultTableViewCell.self), for: indexPath) as! DefaultTableViewCell
//        cell.configure(cellType: .titleRightIcon,
//                       indexPath: indexPath,
//                       dataCount: tableData.count,
//                       title:  tableData[indexPath.row].title)
        cell.configure(cellType: .titleDesc,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: tableData[indexPath.row].title,
                       description: "描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述",
                       leftIconName: "mine_personalInfo_female_s",
                       rightIconName: "tickets_refund_procession_done",
                       isSwitchOn: false
        )
        return cell
    }
}


// MARK: - tableview 代理方法
extension ViewListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushFromRootPage(toTarget: tableData[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


/*
 在VC下，可以给某按钮操作设置以下属性，实现tab切换
 self.tabBarController?.selectedIndex = 2
 
 要需要隐藏元素不占位时，y值最好用赋值的方式来处理，而不是 +=/-= 来处理，后者在扩展时容易出错
 
 */
