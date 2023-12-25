//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewListVC: UIViewController {
    
    let tableData: [TempDefaultCellItem] = [
        TempDefaultCellItem(title: "Animation", viewController: AnimationPage()),
        TempDefaultCellItem(title: "Button", viewController: ButtonPage()),
        TempDefaultCellItem(title: "Camera and Photos", viewController: CameraAndPhotosPage()),
        TempDefaultCellItem(title: "Collection View", viewController: CollectionViewListPage()),
        TempDefaultCellItem(title: "Date Picker", viewController: DatePickerPage()),
        TempDefaultCellItem(title: "Image View", viewController: ImageViewPage()),
        TempDefaultCellItem(title: "Label", viewController: LabelPage()),
        TempDefaultCellItem(title: "Layer", viewController: LayerView()),
        TempDefaultCellItem(title: "Nav Controller", viewController: NavControllerPage()),
        TempDefaultCellItem(title: "Page Control", viewController: PageControlPage()),
        TempDefaultCellItem(title: "Picker View", viewController: PickerViewPage()),
        TempDefaultCellItem(title: "Scroll View", viewController: ScrollViewPage()),
        TempDefaultCellItem(title: "Scroll View Horizonal", viewController: ScrollViewHorizonalPage()),
        TempDefaultCellItem(title: "Segment Control", viewController: SegmentControlPage()),
        TempDefaultCellItem(title: "Slider", viewController: SliderPage()),
        TempDefaultCellItem(title: "Stack View", viewController: StackViewPage()),
        TempDefaultCellItem(title: "Stepper", viewController: StepperPage()),
        TempDefaultCellItem(title: "Styles", viewController: StylesPage()),
        TempDefaultCellItem(title: "Switch", viewController: SwitchPage()),
        TempDefaultCellItem(title: "Switch Scroll And Collection View", viewController: SwitchScrollAndCollectionViewPage()),
        TempDefaultCellItem(title: "Table View", viewController: TableViewPage()),
        TempDefaultCellItem(title: "Text Field", viewController: TextFieldPage()),
        TempDefaultCellItem(title: "Text View", viewController: TextViewPage()),
        TempDefaultCellItem(title: "Transition", viewController: TransitionListPage()),
        TempDefaultCellItem(title: "UIList", viewController: UIListPage()),
        TempDefaultCellItem(title: "Video Player", viewController: VideoPlayerPage()),
        TempDefaultCellItem(title: "View", viewController: ViewPage()),
        TempDefaultCellItem(title: "ViewController", viewController: ViewControllerPage()),
        TempDefaultCellItem(title: "Web View", viewController: WebViewPage()),
        TempDefaultCellItem(title: "Window", viewController: WindowPage()),
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
        cell.prepare(row: indexPath.row, dataCount: tableData.count)
        cell.configure(cellType: .titleRightIcon, title: tableData[indexPath.row].title)
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
