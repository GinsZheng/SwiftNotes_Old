//
//  TaskListVC.swift
//  TimingTask
//
//  Created by GinsMac on 2023/7/15.
//

import UIKit

//class TaskListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, AutoLayoutCollectionViewLayoutDelegate {
//
//    let titleArray: [String] = ["标题标题标题标题标题标题标题标题标题", "标题标题", "标题", "标题", "标题", "标题", "标题", "标题", "标题标题标题标题标题标题标题标题标题"]
//    let taskTypeArray: [Int] = Array(repeating: 0, count: 100)
//    let descriptionArray = Array(repeating: "描述", count: 100)
//    let isDoneArray: [Int] = Array(repeating: 0, count: 100)
//    let hasRemindArray: [Int] = [1,1,1,1,0,0,0,0,0]
//    let remindDateArray: [Int] = [1596124800, 1596124800, 1596124800,1596124800,0,0,0,0,0]
//    let remindTimeArray: [Int] = [1596124800, 1596124800, 0,0,0,0,0,0,0]
//    let isRepeatingArray: [Int] = [1,0,1,0,1,1,1,1,0]
//    let hasProgressArray: [Int] = [1,0,1,0,1,0,1,1,0]
//    let progressTypeArray: [Int] = Array(repeating: 0, count: 100)
//    let colorArray: [Int] = Array(repeating: 0, count: 100)
//    let priorityArray: [Int] = Array(0..<100).map { $0 % 4 }
//    let createTimeArray: [Int] = Array(repeating: 1596124800, count: 100)
//    let updateTimeArray: [Int] = Array(repeating: 1596124800, count: 100)
//    let groupId: [Int] = Array(1...100)
//    let manualSort: [Int] = Array(1...100)
//
//    let tableView = UITableView()
//    let addingTaskButton = UIButton()
//    let groupBgShadow = UIView()
//    let groupBg = UIView()
//
//    // 单行滚动
//    let listView = UIView()
//    let scrollView = UIScrollView()
//
//    var buttons: [UIButton] = []
//
//
//    var collectionView: UICollectionView! // ❓C
//    let dateSource = [  // ❓C
//        ["title":"默认","bgColor":cBlue_5393FF],
//        ["title":"全部","bgColor":cPurple_BF62F8],
//        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
//        ["title":"3 PHP","bgColor":cRed_FF635A],
//        ["title":"4 JS","bgColor":cOrange_F9AD18],
//        ["title":"5 Reac","bgColor":cGreen_25BE3C],
//        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
//        ["title":"7 HTML","bgColor":cBlue_5393FF],
//        ["title":"8 C# ","bgColor":cPurple_BF62F8],
//        ["title":"9 C++","bgColor":cPurple_BF62F8],
//    ]
//
//
//    let buttonTitles = ["默认", "今天", "Button 3", "Button 4", "Button 5",
//                        "Button 6", "Button 7", "Button 8", "Button 9", "Button 10",
//                        "Button 11", "Button 12", "Button 13", "Button 14", "Button 15"]
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setNavTitle20pt(text: "默认")
//        setupMoreButton()
//
//        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
//        tableView.setBackgroundColor(color: cF2F3F6)
//        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavAndTabBarHeight)
//
//        addingTaskButton.setup(superview: view, target: self, action: #selector(pushToTest))
//        addingTaskButton.setStyleIconSuspensionButton(imageName: "task_addingTask")
//        addingTaskButton.setFrame(right: 20, bottom: 182 + 16 + 48, width: 60, height: 60)
//
//        // 下一步，写分组
//        groupBgShadow.setup(superview: view, backgroundColor: cFFF)
//        //        groupBgShadow.setFrame(left: 0, bottom: 181, width: kScreenWidth, height: 100)
//        groupBgShadow.setFrame(left: 0, bottom: 181, width: kScreenWidth, height: 48)
//        groupBgShadow.setShadow(y: 2, radius: 12)
//        groupBgShadow.setCornerRadius(radius: 10)
//
//        groupBg.setup(superview: groupBgShadow, backgroundColor: cFFF)
//        //        groupBg.setFrame(left: 0, bottom: 181, width: kScreenWidth, height: 48)
//        groupBg.setFrame(allEdges: 0)
//        groupBg.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
//
//        //        let buttonList = GroupListView(target: self, frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 48))
//        //        buttonList.setup(superview: groupBg)
//
//        setupGroupListView()
//        setupScrollView()
//        setScrollButtons()
//        setExpandButton()
//
//        //        let frame = CGRect(x: 10, y: 4, width: kScreenWidth - 20, height: 100)
//        //        let layout = AutoLayoutCollectionViewLayout(titleOffset: 24, itemInterval: 6, itemHeight: 40)
//        //        layout.delegate = self
//        //
//        //        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
//        //        collectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: GroupCollectionViewCell.self))
//        //        collectionView.setup(superview: groupBg, delegate: self, dataSource: self, viewController: self)
//
//
//    }
//
//
//
//    // MARK: - 单行滚动
//    func setupGroupListView() {
//        listView.setup(superview: groupBg)
//        listView.setFrame(left: 0, bottom: 0, width: kScreenWidth, height: 48)
//    }
//
//
//    func setupScrollView() {
//        scrollView.setup(superview: listView)
//        scrollView.setFrame(left: 0, top: 0, right: 48, height: 48)
//        scrollView.OptimizeEdgePanGesture(of: self)
//        scrollView.showsHorizontalScrollIndicator = false
//    }
//
//    func setScrollButtons() {
//
//        var frameRight: CGFloat = 0
//
//        for (i, title) in buttonTitles.enumerated() {
//            let button = UIButton(type: .custom)
//            button.setup(superview: scrollView, target: self, action: #selector(pushToTest))
//            button.setStyleSolid14ptGrayGrayButton(title: title)
//            button.extendTouchArea()
//
//            let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
//            if i == 0 {
//                button.setFrame(left: 10, centerY: scrollView.centerY, width: labelWidth + 24, height: 28)
//            } else {
//                button.setFrame(left: frameRight, centerY: scrollView.centerY, width: labelWidth + 24, height: 28)
//            }
//
//            frameRight = button.right + 6
//
//            buttons.append(button)
//        }
//
//        scrollView.contentSize = CGSize(width: frameRight + 4, height: 48)
//
//    }
//
//    func setExpandButton() {
//        let expandButtonBg = UIImageView()
//        expandButtonBg.setup(superview: listView, imageName: "groupBar_gradientMask")
//        expandButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
//
//        let button = UIButton()
//        button.setup(superview: listView, target: self, action: #selector(pushToTest))
//        button.setStyleIconButton(imageName: "groupBar_unfold")
//        button.setFrame(right: 10, top: 10, width: 28, height: 28)
//        button.extendTouchArea(size: 48)
//
//    }
//
//
//
//
//
//
//    // MARK: - tableview 代理
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return titleArray.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 48
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.push(toTarget: DetailsVC())
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var rightMargin: CGFloat = 0
//
//        let cell = UITableViewCell()
//        cell.setBackgroundColor(color: cF2F3F6)
//        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: 48)
//
//        let cellBg = UIView()
//        cellBg.setup(superview: cell, backgroundColor: cFFF)
//        cellBg.setFrame(left: 10, top: 0, right: 10, height: 48)
//        cellBg.setCellCornerRadius(radius: 10, index: indexPath.row, maxIndex: titleArray.count - 1)
//        cellBg.setSeparator(left: 42, right: 12)
//
//        let ovalButton = UIButton()
//        ovalButton.setup(superview: cellBg, target: self, action: #selector(check))
//        ovalButton.setStyleIconButton(imageName: "oval")
//        ovalButton.setFrame(left: 12, centerY: cellBg.centerY, width: 20, height: 20)
//
//        let priorityIcon = UIImageView()
//        switch priorityArray[indexPath.row] {
//        case 3:
//            priorityIcon.setup(superview: cellBg, imageName: "priority3")
//            priorityIcon.setFrame(left: 42, centerY: cellBg.centerY, width: 16, height: 24)
//        case 2:
//            priorityIcon.setup(superview: cellBg, imageName: "priority2")
//            priorityIcon.setFrame(left: 42, centerY: cellBg.centerY, width: 11, height: 24)
//        case 1:
//            priorityIcon.setup(superview: cellBg, imageName: "priority1")
//            priorityIcon.setFrame(left: 42, centerY: cellBg.centerY, width: 6, height: 24)
//        default: // case 0
//            priorityIcon.setup(superview: cellBg)
//            priorityIcon.setFrame(left: 42, centerY: cellBg.centerY, width: 0, height: 24)
//        }
//
//        let timerButton = UIButton()
//        timerButton.setup(superview: cellBg, target: self, action: #selector(check))
//        timerButton.setStyleIconButton(imageName: "task_timer")
//        timerButton.setFrame(right: 12, centerY: cellBg.centerY, width: 20, height: 26)
//
//        let dateAndTimeButton = UIButton(type: .custom)
//        dateAndTimeButton.setup(superview: cellBg)
//
//        if hasRemindArray[indexPath.row] == 1 { // 有提醒(至少有日期)
//            if remindTimeArray[indexPath.row] != 0  {
//                // 有时间 & 无重复
//                dateAndTimeButton.setStyleWordButton(title: "11:00\n12月30日", titleSize: 12, titleColor: c888)
//                dateAndTimeButton.titleLabel?.numberOfLines = 2
//                dateAndTimeButton.titleLabel?.setLineHeight(multiple: 15/12)
//                dateAndTimeButton.setFrame(right: 44, centerY: cellBg.centerY, width: dateAndTimeButton.titleLabel?.getLabelWidth() ?? 100, height: 48)
//
//
//                if isRepeatingArray[indexPath.row] == 1 {
//                    // 有时间 & 有重复
//                    let repeatIcon = UIImageView()
//                    repeatIcon.setup(superview: dateAndTimeButton, imageName: "task_repeat_future")
//                    repeatIcon.setFrame(right: 2, top: 11.5, width: 10, height: 10)
//                }
//            }
//            else if remindTimeArray[indexPath.row] == 0 && isRepeatingArray[indexPath.row] == 1 {
//                // 无时间 & 有重复
//                dateAndTimeButton.setStyleWordIconButton(title: "12月30日", titleSize: 12, titleColor: c888, imageName: "task_repeat_future", imageLocation: .right, interval: 1)
//                let labelWidth = dateAndTimeButton.titleLabel?.getLabelWidth() ?? 0
//                dateAndTimeButton.setFrame(right: 44, centerY: cellBg.centerY, width: labelWidth + 12, height: 48)
//            }
//            else if remindTimeArray[indexPath.row] == 0 && isRepeatingArray[indexPath.row] == 0 {
//                // 无时间 & 无重复
//                dateAndTimeButton.setStyleWordButton(title: "12月30日", titleSize: 12, titleColor: c888)
//                dateAndTimeButton.setFrame(right: 44, centerY: cellBg.centerY, width: dateAndTimeButton.titleLabel?.getLabelWidth() ?? 100, height: 48)
//            }
//            rightMargin = CGFloat(dateAndTimeButton.width) + 44 + 8
//
//        } else { // hasRemindArray == 0, 即无提醒
//            rightMargin = 44
//        }
//
//
//        if hasProgressArray[indexPath.row] == 1 {
//            let ovalBg = UIImageView()
//            ovalBg.setup(superview: cellBg, imageName: "progressBg")
//            ovalBg.setFrame(right: rightMargin, centerY: cellBg.centerY, width: 24, height: 24)
//            rightMargin = rightMargin + 24 + 4
//
//            let ovalLabel = UILabel()
//            ovalLabel.setup(superview: ovalBg, text: "0")
//            ovalLabel.setStyle12pt999MedCent()
//            ovalLabel.setFrame(center: ovalBg)
//        }
//
//
//        let cellTitle = UILabel()
//        cellTitle.setup(superview: cellBg, text: titleArray[indexPath.row])
//        cellTitle.setFrame(left: priorityIcon.right, centerY: cell.centerY, right: rightMargin)
//        // kScreenWidth - 20 得到cell全长。 (ovalBg.left - 4)为标题的right坐标。前后相减，得到标题右边距
//        cellTitle.setStyle17pt222Med()
//
//        return cell
//
//    }
//
//
//    // MARK: - CollectionView 代理
//
//    // 设置数量
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dateSource.count
//    }
//
//    // 设置点击事件
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.push(toTarget: CSGeneralSubpage())
//        collectionView.deselectItem(at: indexPath, animated: true)
//    }
//
//    // 设置 cell 逻辑
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GroupCollectionViewCell.self), for: indexPath) as! GroupCollectionViewCell
//        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
//        let data = dateSource[indexPath.row]
//        cell.setData(title: data["title"] ?? "")
//
//        return cell
//    }
//
//
//
//    // MARK: - AutoLayoutCollectionViewLayoutDelegate 的代理
//
//    func fetchTitleWidths() -> [CGFloat] {
//        var titleWidths: [CGFloat] = []
//        for i in 0..<dateSource.count {
//            let width = getLabelWidth(text: dateSource[i]["title"] ?? "", fontSize: 14, weight: .medium)
//            titleWidths.append(width)
//        }
//
//        return titleWidths
//    }
//
//
//
//    // MARK: - func
//
//    func setupMoreButton() {
//        // 创建一个自定义按钮
//        let moreButton = UIButton()
//        moreButton.setStyleIconButton(imageName: "task_more")
//        moreButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//        moreButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -11)
//        moreButton.sizeToFit()
//        moreButton.setup(superview: view, target: self, action: #selector(pushToTest))
//
//        // 添加一个不可见的 UIView 作为按钮右边的点击区域
//        let rightSpacerView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
//        rightSpacerView.isUserInteractionEnabled = false // 确保点击事件不会被右边的区域拦截
//        let rightBarButton = UIBarButtonItem(customView: rightSpacerView)
//
//        // 创建 UIBarButtonItem，并将自定义按钮设置为其自定义视图
//        let customBarButtonItem = UIBarButtonItem(customView: moreButton)
//        // 设置自定义按钮为导航栏右侧按钮
//        navigationItem.rightBarButtonItems = [customBarButtonItem, rightBarButton]
//    }
//
//
//
//    // MARK: - @objc
//
//    @objc func check() {
//        print("check")
//    }
//
//    @objc func pushToTest() {
//        self.push(toTarget: CSGeneralSubpage())
//    }
//
//    @objc func pushToDetailsVC() {
//        self.push(toTarget: DetailsVC())
//    }
//
//}
//
//
//
//
//
//// MARK: - 自定义 Cell
//
//class GroupCollectionViewCell: UICollectionViewCell {
//
//    // 输入参数
//    let titleOffset: CGFloat = 24  // ⚠️这里的值要与布局中的titleOffset一致
//
//
//    let titleLabel = UILabel()
//    let imageView = UIImageView()
//
//    let bg = UIView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    // MARK: - func
//
//    func setData(title: String) {
//        setupBg()
//
//        setImageView()
//        setTitle(text: title)
//        resetImageWidth()
//    }
//
//    func setupBg() {
//        bg.setup(superview: contentView)
//        bg.setFrame(allEdges: 0)
//    }
//
//    func setImageView() {
//        imageView.setup(superview: bg, image: getImageWithColor(color: cF0F1F3), cornerRadius: 14)
//        imageView.setFrame(left: 0, top: 6, width: 0, height: 28)
//    }
//
//    func setTitle(text: String) {
//        titleLabel.setup(superview: imageView, text: text)
//        titleLabel.setStyle14pt666MedCenter()
//        titleLabel.setFrame(left: 12, top: 4, width: titleLabel.getLabelWidth(), height: 20)
//    }
//
//    func resetImageWidth() {
//        imageView.width = titleLabel.getLabelWidth() + titleOffset
//    }
//
//    // MARK: - @objc
//    @objc func pushToTest() {
//        print("hehe")
//    }
//
//
//}
//
//
//
//// MARK: - 自定义Layout
//
//class AutoLayoutCollectionViewLayout: UICollectionViewLayout {
//
//    weak var delegate: AutoLayoutCollectionViewLayoutDelegate?
//
//    // 初始化参数
//    var titleOffset: CGFloat = 0
//    var itemInterval: CGFloat = 0
//    var itemHeight: CGFloat = 0
//
//    var contentHeight: CGFloat = 0
//    var itemCount = 0
//    var titleWidths: [CGFloat] {
//        return delegate?.fetchTitleWidths() ?? []
//    }
//
//    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
//
//    init(titleOffset: CGFloat, itemInterval: CGFloat, itemHeight: CGFloat) {
//        super.init()
//
//        self.titleOffset = titleOffset
//        self.itemInterval = itemInterval
//        self.itemHeight = itemHeight
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // 初始化一些参数与布局
//    override func prepare() {
//        super.prepare()
//
//        guard let collectionView = collectionView else { return }
//        itemCount = collectionView.numberOfItems(inSection: 0)
//
//        // 设置所有单元格的位置属性
//        layoutAttributes.removeAll()
//        for i in 0..<itemCount {
//            let indexPath = IndexPath(item: i, section: 0)
//            if let attributes = layoutAttributesForItem(at: indexPath) {
//                layoutAttributes.append(attributes)
//            }
//        }
//    }
//
//    // 设置内容区域总大小，是不可见区域
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight)
//    }
//
//    // 设为只有在可见区域内的单元格的布局属性会被返回，以减少不必要的计算和绘制，提高性能
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        return layoutAttributes.filter { $0.frame.intersects(rect) }
//    }
//
//    // 设置单个单元格的位置属性
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        contentHeight = getAutoLayoutContentHeight(indexPath: indexPath, titleWidths: titleWidths, titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
//
//        let attributes = createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
//        return attributes
//    }
//
//}
//
//
//



//
//
//// MARK: - 自定义的 tableViewCell
//class TaskTableViewCell: UITableViewCell {
//    
//    let cellBg = UIView()
//    
//    
//    static let identifier = String(describing: TaskTableViewCell.self)
//    
//    private let titleLabel = UILabel()
//    private let nextIcon = UIImageView()
//    private let separator = UIView()
//    
//    
//    // MARK: - 初始化
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    // MARK: - func
//    // 设置控件非布局内容 (严谨说是一次性设置的内容，这通常都是非布局内容)
//    private func setupUI() {
//        
//        titleLabel.setup(superview: contentView)
//        titleLabel.setStyle17pt222()
//        
//        nextIcon.setup(superview: contentView, imageName: "next")
//        
//        separator.setup(superview: contentView, backgroundColor: cSeparator)
//        
//    }
//    
//    // 设置控件布局 (严谨说是布局刷新时需要刷新的内容，这通常都是布局内容)
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        titleLabel.setFrame(left: 16, centerY: contentView.centerY)
//        
//    }
//    
//    // 配置数据
//    func configure(title: String, index: Int, dataCount: Int) {
//        titleLabel.text = title
//        cellBg.setCellCornerRadius(radius: kRadius, index: index, dataCount: dataCount)
//    }
//    
//}
