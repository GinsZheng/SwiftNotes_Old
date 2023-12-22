//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewListVC: UIViewController {
    
    let tableData: [DefaultCellItem] = [
        DefaultCellItem(title: "Animation", viewController: AnimationPage()),
        DefaultCellItem(title: "Button", viewController: ButtonPage()),
        DefaultCellItem(title: "Camera and Photos", viewController: CameraAndPhotosPage()),
        DefaultCellItem(title: "Collection View", viewController: CollectionViewListPage()),
        DefaultCellItem(title: "Date Picker", viewController: DatePickerPage()),
        DefaultCellItem(title: "Image View", viewController: ImageViewPage()),
        DefaultCellItem(title: "Label", viewController: LabelPage()),
        DefaultCellItem(title: "Layer", viewController: LayerView()),
        DefaultCellItem(title: "Nav Controller", viewController: NavControllerPage()),
        DefaultCellItem(title: "Page Control", viewController: PageControlPage()),
        DefaultCellItem(title: "Picker View", viewController: PickerViewPage()),
        DefaultCellItem(title: "Scroll View", viewController: ScrollViewPage()),
        DefaultCellItem(title: "Scroll View Horizonal", viewController: ScrollViewHorizonalPage()),
        DefaultCellItem(title: "Segment Control", viewController: SegmentControlPage()),
        DefaultCellItem(title: "Slider", viewController: SliderPage()),
        DefaultCellItem(title: "Stack View", viewController: StackViewPage()),
        DefaultCellItem(title: "Stepper", viewController: StepperPage()),
        DefaultCellItem(title: "Styles", viewController: StylesPage()),
        DefaultCellItem(title: "Switch", viewController: SwitchPage()),
        DefaultCellItem(title: "Switch Scroll And Collection View", viewController: SwitchScrollAndCollectionViewPage()),
        DefaultCellItem(title: "Table View", viewController: TableViewPage()),
        DefaultCellItem(title: "Text Field", viewController: TextFieldPage()),
        DefaultCellItem(title: "Text View", viewController: TextViewPage()),
        DefaultCellItem(title: "Transition", viewController: TransitionListPage()),
        DefaultCellItem(title: "UIList", viewController: UIListPage()),
        DefaultCellItem(title: "Video Player", viewController: VideoPlayerPage()),
        DefaultCellItem(title: "View", viewController: ViewPage()),
        DefaultCellItem(title: "ViewController", viewController: ViewControllerPage()),
        DefaultCellItem(title: "Web View", viewController: WebViewPage()),
        DefaultCellItem(title: "Window", viewController: WindowPage()),
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
        tableView.register(DefaultCell.self, forCellReuseIdentifier: String(describing: DefaultCell.self))
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DefaultCell.self), for: indexPath) as! DefaultCell
        cell.prepare(cellType: .titleRightIcon, row: indexPath.row, dataCount: tableData.count)
        cell.configure(title: tableData[indexPath.row].title)
        return cell
    }
}


// MARK: - tableview 代理方法
extension ViewListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
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
