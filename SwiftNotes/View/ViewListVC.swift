//
//  ViewController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

private class DataManager: DefaultCellDataManager {
    init() {
        super.init(initialItems: [
            .titleNextVC(title: "Animation", viewController: AnimationPage()),
            .titleNextVC(title: "Button", viewController: ButtonPage()),
            .titleNextVC(title: "Camera and Photos", viewController: CameraAndPhotosPage()),
            .titleNextVC(title: "Collection View", viewController: CollectionViewListPage()),
            .titleNextVC(title: "Date Picker", viewController: DatePickerPage()),
            .titleNextVC(title: "Image View", viewController: ImageViewPage()),
            .titleNextVC(title: "Label", viewController: LabelPage()),
            .titleNextVC(title: "Layer", viewController: LayerView()),
            .titleNextVC(title: "Nav Controller", viewController: NavControllerPage()),
            .titleNextVC(title: "Option Sheet", viewController: OptionSheetPage()),
            .titleNextVC(title: "Page Control", viewController: PageControlPage()),
            .titleNextVC(title: "Picker View", viewController: PickerViewPage()),
            .titleNextVC(title: "Scroll View", viewController: ScrollViewPage()),
            .titleNextVC(title: "Scroll View Horizonal", viewController: ScrollViewHorizonalPage()),
            .titleNextVC(title: "Segment Control", viewController: SegmentControlPage()),
            .titleNextVC(title: "Slider", viewController: SliderPage()),
            .titleNextVC(title: "Stack View", viewController: StackViewPage()),
            .titleNextVC(title: "Stepper", viewController: StepperPage()),
            .titleNextVC(title: "Styles", viewController: StylesPage()),
            .titleNextVC(title: "Switch", viewController: SwitchPage()),
            .titleNextVC(title: "Switch Scroll And Collection View", viewController: SwitchScrollAndCollectionViewPage()),
            .titleNextVC(title: "Table View", viewController: TableViewPage()),
            .titleNextVC(title: "More Table View", viewController: MoreTableViewListPage()),
            .titleNextVC(title: "Text Field", viewController: TextFieldPage()),
            .titleNextVC(title: "Text View", viewController: TextViewPage()),
            .titleNextVC(title: "Transition", viewController: TransitionListPage()),
            .titleNextVC(title: "UIList", viewController: UIListPage()),
            .titleNextVC(title: "Video Player", viewController: VideoPlayerPage()),
            .titleNextVC(title: "View", viewController: ViewPage()),
            .titleNextVC(title: "ViewController", viewController: ViewControllerPage()),
            .titleNextVC(title: "Web View", viewController: WebViewPage()),
            .titleNextVC(title: "Window", viewController: WindowPage()),
        ])
    }
}


// MARK: - 视图控制器
class ViewListVC: UIViewController {
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - tableView 代理方法
extension ViewListVC: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableData[indexPath.row].pushViewControllerOnTap(from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableData[indexPath.row].getCellHeight()
    }

    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultCell.identifier, for: indexPath) as? DefaultCell else { return UITableViewCell() }
        cell.prepare(row: indexPath.row, cellCountInSection: tableData.count)
        tableData[indexPath.row].configureCell(cell)
        return cell
    }
    
}


// MARK: - 私有方法
extension ViewListVC {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        setupDefaultTableView(tableView)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}



/*
 在VC下，可以给某按钮操作设置以下属性，实现tab切换
 self.tabBarController?.selectedIndex = 2
 
 要需要隐藏元素不占位时，y值最好用赋值的方式来处理，而不是 +=/-= 来处理，后者在扩展时容易出错
 
 */
