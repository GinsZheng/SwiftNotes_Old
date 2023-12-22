//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewListVC: UIViewController {
    
    let tableData: [DefaultTableItem] = [
        DefaultTableItem(title: "Animation", viewController: AnimationPage()),
        DefaultTableItem(title: "Button", viewController: ButtonPage()),
        DefaultTableItem(title: "Camera and Photos", viewController: CameraAndPhotosPage()),
        DefaultTableItem(title: "Collection View", viewController: CollectionViewListPage()),
        DefaultTableItem(title: "Date Picker", viewController: DatePickerPage()),
        DefaultTableItem(title: "Image View", viewController: ImageViewPage()),
        DefaultTableItem(title: "Label", viewController: LabelPage()),
        DefaultTableItem(title: "Layer", viewController: LayerView()),
        DefaultTableItem(title: "Nav Controller", viewController: NavControllerPage()),
        DefaultTableItem(title: "Page Control", viewController: PageControlPage()),
        DefaultTableItem(title: "Picker View", viewController: PickerViewPage()),
        DefaultTableItem(title: "Scroll View", viewController: ScrollViewPage()),
        DefaultTableItem(title: "Scroll View Horizonal", viewController: ScrollViewHorizonalPage()),
        DefaultTableItem(title: "Segment Control", viewController: SegmentControlPage()),
        DefaultTableItem(title: "Slider", viewController: SliderPage()),
        DefaultTableItem(title: "Stack View", viewController: StackViewPage()),
        DefaultTableItem(title: "Stepper", viewController: StepperPage()),
        DefaultTableItem(title: "Styles", viewController: StylesPage()),
        DefaultTableItem(title: "Switch", viewController: SwitchPage()),
        DefaultTableItem(title: "Switch Scroll And Collection View", viewController: SwitchScrollAndCollectionViewPage()),
        DefaultTableItem(title: "Table View", viewController: TableViewPage()),
        DefaultTableItem(title: "Text Field", viewController: TextFieldPage()),
        DefaultTableItem(title: "Text View", viewController: TextViewPage()),
        DefaultTableItem(title: "Transition", viewController: TransitionListPage()),
        DefaultTableItem(title: "UIList", viewController: UIListPage()),
        DefaultTableItem(title: "Video Player", viewController: VideoPlayerPage()),
        DefaultTableItem(title: "View", viewController: ViewPage()),
        DefaultTableItem(title: "ViewController", viewController: ViewControllerPage()),
        DefaultTableItem(title: "Web View", viewController: WebViewPage()),
        DefaultTableItem(title: "Window", viewController: WindowPage()),
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
        cell.configure(cellType: .titleRightIcon,
                       indexPath: indexPath,
                       dataCount: tableData.count,
                       title: tableData[indexPath.row].title
        )
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
