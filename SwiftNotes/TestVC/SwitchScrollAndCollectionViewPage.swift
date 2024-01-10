//
//  SwitchScrollAndCollectionView.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/12/12.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// collectionView数据的结构体
private struct Item {
    let title: String
    let bgColor: String
}

private class DataManager: BaseDataManager<Item> {
    init() {
        super.init(initialItems: [
            Item(title: "0 Swift", bgColor: cBlue_5393FF),
            Item(title: "1 Xcode", bgColor: cPurple_BF62F8),
            Item(title: "2 Java", bgColor: cMagenta_FC5AAE),
            Item(title: "3 PHP", bgColor: cRed_FF635A),
            Item(title: "4 JS", bgColor: cOrange_F9AD18),
            Item(title: "5 React", bgColor: cGreen_25BE3C),
            Item(title: "6 Ruby", bgColor: cBluishGreen_01C7BD),
            Item(title: "7 HTML", bgColor: cBlue_5393FF),
            Item(title: "8 C#", bgColor: cPurple_BF62F8),
            Item(title: "9 C++", bgColor: cPurple_BF62F8),
        ])
    }
}

// CollectionView的参数
struct GroupCollectionViewStyles {
    static let fontSize: CGFloat = 14
    static let weight: UIFont.Weight = .medium
    static let buttonPadding: CGFloat = 24
    static let itemInterval: CGFloat = 6
    static let itemHeight: CGFloat = 40
}

class SwitchScrollAndCollectionViewPage: UIViewController {
    
    typealias Styles = GroupCollectionViewStyles
    
    enum UIForm {
        case form0
        case form1
    }
    
    private let groupData = DataManager()
    lazy var titles: [String] = groupData.map { $0.title }
    
    var currentUIForm: UIForm = .form0
    var collectionViewContentHeight: CGFloat = 0 // 获取collectionView内容高度(用于布局)
    
    var collectionView: UICollectionView!
    let bgView = UIView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        /// 把setupUI放到viewWillAppear是因为：有SecenDelegate时(可能的原因)，CollectionView会改变self.view的高度,详见🐾1
    }
    
    
    // MARK: - func
    func setupUI() {
        setupCommonUI()
        setupFormViewUI()
        
        // 设置数据源更新时的操作
        groupData.onItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func setupCommonUI() {
        view.setBackgroundColor(color: cBgGray)
    }
    
    func setupFormViewUI() {
        switch currentUIForm {
        case .form0:
            setupOneLineUI()
        case .form1:
            setupMultiLineUI()
        }
    }
    
    // 单行视图
    func setupOneLineUI() {
        bgView.removeAllSubviews()
        bgView.setup(superview: view, backgroundColor: cFFF)
        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 48)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let buttons = HorizonalScrollingGroupButtonsView(titles: titles, target: self)
        buttons.setup(superview: bgView)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupUI(showsHorizontalScrollIndicator: false, showTrashButton: true)
        buttons.onButtonsTapped = { [weak self] _ in
            self?.push(toTarget: CSGeneralSubpage())
        }
        buttons.onSwitchButtonTapped = { [weak self] in
            self?.switchView()
        }
        buttons.onSettingsButtonTapped = { [weak self] in
            self?.push(toTarget: CSGeneralSubpage())
        }
        buttons.onTrashButtonTapped = { [weak self] in
            self?.push(toTarget: CSGeneralSubpage())
        }
    }
    
    // 多行视图
    func setupMultiLineUI() {
        bgView.removeAllSubviews()
        bgView.setup(superview: view, backgroundColor: cFFF)
        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 100)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        // 创建collectionView用到的Layout
        let layout = GroupCollectionViewLayout()
        // 设置闭包：更新collectionView内容高度
        layout.onHeightUpdate = { [weak self] newHeight in
            self?.collectionViewContentHeight = newHeight
        }
        // 设置闭包：计算标题宽度
        layout.fetchTitleWidths = { [weak self] in
            guard let self = self else { return [] }
            return groupData.map {
                getLabelWidth(withMaxWidth: 136, text: $0.title, fontSize: Styles.fontSize, weight: Styles.weight)
            }
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
        collectionView.setup(superview: bgView, delegate: self, dataSource: self, viewController: self)
        collectionView.setFrame(left: 10, top: 0, right: 10, height: kWithoutNavBarHeight)
    }
    
    
    // MARK: - @objc func
    @objc func switchView() {
        currentUIForm = currentUIForm == .form0 ? .form1 : .form0
        setupUI()
    }
    
}


// MARK: - 代理方法：UICollectionView
extension SwitchScrollAndCollectionViewPage: UICollectionViewDelegate, UICollectionViewDataSource {

    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupData.count
    }
    
    // 设置单元格渲染完成后的逻辑
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == groupData.count - 1 else { return }
        // 设置CollectionView的高度(最大高度为10.5行)
        let collectionMaxHeight: CGFloat = 4 + 440 - 6 - 6 // 10.5行 (4:顶部多出4pt，440: 11行高度，6:按钮外边距，6:刻意隐藏)
        let collectionViewHeight = collectionViewContentHeight > collectionMaxHeight ? collectionMaxHeight : collectionViewContentHeight
        collectionView.setFrame(left: 10, top: 0, right: 10, height: collectionViewHeight)
        
        let bottomLineHeight: CGFloat = 48 // 底栏(含废纸蒌栏的)高度
        let bgViewHeight = collectionViewHeight + bottomLineHeight
        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: bgViewHeight)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let bottomView = GroupBottomButtonsView()
        bottomView.setup(superview: bgView, backgroundColor: cFFF)
        bottomView.setFrame(left: 0, bottom: 0, right: 0, height: bottomLineHeight)
        bottomView.setupView(showTrashButton: true)
        bottomView.onTrashButtonTapped = { [weak self] in
            self?.push(toTarget: CSGeneralSubpage())
        }
        bottomView.onSwitchButtonTapped = { [weak self] in
            self?.switchView()
        }
        bottomView.onSettingsButtonTapped = { [weak self] in
            self?.push(toTarget: CSGeneralSubpage())
        }
    }
    
    // 设置 cell 逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as? GroupCollectionViewCell else { return UICollectionViewCell() }
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        cell.configure(withTitle: titles[indexPath.row]) { [weak self] in
            self?.push(toTarget: CSGeneralSubpage())
        }
        return cell
    }
}


// MARK: - 横向滚动视图
class HorizonalScrollingGroupButtonsView: UIView {
    // 初始化参数
    var titles: [String]
    var target: UIViewController
    
    var buttonLeft: CGFloat = 10 // 用于记录下一个按钮的左边界位置
    let itemInterval: CGFloat = 6
    let tailPadding: CGFloat = 10
    let buttonHeight: CGFloat = 28
    let buttonPadding: CGFloat = 24
    
    let scrollView = UIScrollView()
    var buttons: [UIButton] = []
    
    // 定义闭包属性
    var onButtonsTapped: ((Int) -> Void)?
    var onSwitchButtonTapped: (() -> Void)?
    var onTrashButtonTapped: (() -> Void)?
    var onSettingsButtonTapped: (() -> Void)?
    
    /// - 参数:
    ///   - titles: 每个按钮的标题
    ///   - target: 填self。用于处理scrollView侧滑冲突
    init(titles: [String], target: UIViewController) {
        self.titles = titles
        self.target = target
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    func setupUI(showsHorizontalScrollIndicator: Bool, showTrashButton: Bool) {
        setupScrollView(showsHorizontalScrollIndicator: showsHorizontalScrollIndicator)
        createButtons()
        addSwitchButton()
        if showTrashButton {
            addTrashButton()
        }
        addSettingsButton()
    }
    
    private func setupScrollView(showsHorizontalScrollIndicator: Bool) {
        scrollView.setup(superview: self)
        scrollView.setFrame(left: 0, top: 0, width: kScreenWidth - 48, height: self.height) // 因为右侧的箭头按钮背景占了48pt
        scrollView.OptimizeEdgePanGesture(of: target)
        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    }
    
    private func createButtons() {
        for (i, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = i // 用于标识是哪个button，以便在代理中赋值给didSelectButtonAtIndex，实现按不同按钮响应不同操作
            button.setup(superview: scrollView, target: self, action: #selector(buttonsTapped), forEvent: .touchUpInside)
            button.height = buttonHeight
            button.setStyleSolid14pt666GrayRoundedButton(title: title)
            
            // 计算按钮frame的参数
            let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
            let buttonWidth = labelWidth + buttonPadding
            // 设置按钮的frame
            button.setFrame(left: buttonLeft, centerY: scrollView.centerY, width: buttonWidth, height: buttonHeight)
            button.extendTouchArea()
            
            // 更新buttonLeft以便下一个按钮使用
            buttonLeft = button.right + itemInterval
            buttons.append(button)
        }
        
        scrollView.contentSize.width = buttonLeft + tailPadding
    }
    
    private func addSwitchButton() {
        let switchButtonBg = UIImageView()
        switchButtonBg.setup(superview: self, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.setup(superview: self, target: self, action: #selector(switchButtonTapped))
        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
        switchButton.setFrame(right: 12, centerY: self.height / 2, width: 28, height: 28)
        switchButton.extendTouchArea()
    }
    
    private func addTrashButton() {
        let trashButton = UIButton(type: .custom)
        trashButton.setup(superview: scrollView, target: self, action: #selector(trashButtonTapped))
        trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
        trashButton.setFrame(left: buttonLeft, bottom: 10, width: getLabelWidth(text: "废纸蒌", fontSize: 14, weight: .medium) + 24, height: 28)
        trashButton.extendTouchArea()
        
        buttonLeft = trashButton.right + itemInterval
        scrollView.contentSize.width = buttonLeft + tailPadding
    }
    
    private func addSettingsButton() {
        let settingsButton = UIButton(type: .custom)
        settingsButton.setup(superview: scrollView, target: self, action: #selector(settingsButtonTapped))
        settingsButton.setStyleIconButton(imageName: "home_settings")
        settingsButton.setFrame(left: buttonLeft, bottom: 10, width: 28, height: 28)
        settingsButton.extendTouchArea()
        
        buttonLeft = settingsButton.right + itemInterval
        scrollView.contentSize.width = buttonLeft + tailPadding
    }
    
    
    // MARK: - @objc func
    @objc private func buttonsTapped(_ button: UIButton) {
        onButtonsTapped?(button.tag)
    }
    
    @objc private func switchButtonTapped() {
        onSwitchButtonTapped?()
    }
    
    @objc private func trashButtonTapped() {
        onTrashButtonTapped?()
    }
    
    @objc private func settingsButtonTapped() {
        onSettingsButtonTapped?()
    }
    
}


// MARK: - 自定义 Cell
class GroupCollectionViewCell: UICollectionViewCell {
    
    typealias Styles = GroupCollectionViewStyles
    
    static let identifier = String(describing: GroupCollectionViewCell.self)
    
    var buttonAction: (() -> Void)?
    
    private let button = UIButton(type: .custom)
    
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    private func setupViews() {
        button.setup(superview: contentView)
        button.setStyleSolidButton(title: "", titleSize: Styles.fontSize, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
    }
    
    func configure(withTitle title: String, action: (() -> Void)?, forEvent: UIControl.Event = UIControl.Event.touchUpInside) {
        button.setTitle(title, for: .normal)
        let bottomWidth = (button.titleLabel?.getLabelWidth() ?? 0) + Styles.buttonPadding
        button.setFrame(left: 0, top: 10, width: bottomWidth, height: 28)
        buttonAction = action // 存储闭包
        button.addTarget(self, action: #selector(buttonsTapped), for: forEvent)
        button.extendTouchArea()
    }
    
    
    // MARK: - @objc func
    @objc func buttonsTapped() {
        buttonAction?()
    }
    
}


// MARK: - 自定义Layout
class GroupCollectionViewLayout: UICollectionViewLayout {
    
    typealias Styles = GroupCollectionViewStyles
    
    var onHeightUpdate: ((CGFloat) -> Void)?     // 获取高度的闭包
    var fetchTitleWidths: (() -> [CGFloat])? // 获取标题宽度的闭包
    var titleWidths: [CGFloat] {
        return fetchTitleWidths?() ?? []
    }
    var contentHeight: CGFloat = 0 // 视图高度
    var itemCount = 0
    
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // 初始化一些参数与布局
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        itemCount = collectionView.numberOfItems(inSection: 0)
        
        // 设置所有单元格的位置属性
        layoutAttributes = (0..<itemCount).map({ index in
            let indexPath = IndexPath(item: index, section: 0)
            return createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, buttonPadding: Styles.buttonPadding, itemInterval: Styles.itemInterval, itemHeight: Styles.itemHeight, collectionViewWidth: collectionView.width)
        })
        
        // 更新内容高度
        if let lastIndexPath = layoutAttributes.last?.indexPath {
            contentHeight = getAutoLayoutContentHeight(indexPath: lastIndexPath, titleWidths: titleWidths, buttonPadding: Styles.buttonPadding, itemInterval: Styles.itemInterval, itemHeight: Styles.itemHeight, collectionViewWidth: collectionView.width)
            onHeightUpdate?(contentHeight)
        }
        
    }
    
    // (维持不变)设置内容区域总大小，是不可见区域
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.width ?? 0, height: contentHeight)
    }
    
    // (维持不变)设为只有在可见区域内的单元格的布局属性会被返回，以减少不必要的计算和绘制，提高性能
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }
    
    // (维持不变)设置单个单元格的位置属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return indexPath.item < layoutAttributes.count ? layoutAttributes[indexPath.item] : nil
    }
    
}


// MARK: - 分组底栏(含废纸蒌一栏)视图
class GroupBottomButtonsView: UIView {
    
    var onTrashButtonTapped: (() -> Void)?
    var onSwitchButtonTapped: (() -> Void)?
    var onSettingsButtonTapped: (() -> Void)?

    let trashButton = UIButton(type: .custom)
    let switchButtonBg = UIImageView()
    let switchButton = UIButton(type: .custom)
    let settingsButton = UIButton(type: .custom)
    
    
    // MARK: - func
    func setupView(showTrashButton: Bool) {
        switchButtonBg.setup(superview: self, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, bottom: 0, width: 72, height: 48)
        
        switchButton.setup(superview: self, target: self, action: #selector(switchButtonTapped))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: 12, bottom: 10, width: 28, height: 28)
        switchButton.extendTouchArea()

        settingsButton.setup(superview: self, target: self, action: #selector(settingsButtonTapped))
        settingsButton.setStyleIconButton(imageName: "home_settings")
        settingsButton.setFrame(right: 57, bottom: 10, width: 28, height: 28)
        settingsButton.extendTouchArea()
        
        if showTrashButton {
            addTrashButton()
        }
    }
    
     private func addTrashButton() {
        trashButton.setup(superview: self, target: self, action: #selector(trashButtonTapped))
        trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
        trashButton.setFrame(left: 10, bottom: 10, width: getLabelWidth(text: "废纸蒌", fontSize: 14, weight: .medium) + 24, height: 28)
         trashButton.extendTouchArea()
    }
    
    
    // MARK: - @objc func
    @objc private func trashButtonTapped() {
        onTrashButtonTapped?()
    }
    
    @objc private func switchButtonTapped() {
        onSwitchButtonTapped?()
    }
    
    @objc private func settingsButtonTapped() {
        onSettingsButtonTapped?()
    }
}


/*
 🐾1：将setup()代码从viewDidLoad移动到viewWillAppear或viewDidLayoutSubviews中解决了问题的原因：
 这可能是因为视图控制器的布局生命周期和视图布局过程的特点。具体来说：
 1. 视图控制器的生命周期：
 viewDidLoad仅在视图控制器的视图第一次加载时调用。在这个阶段，视图的大小和布局尚未最终确定，特别是在自动布局环境中。
 viewWillAppear在视图即将显示在屏幕上时被调用，此时视图的大小可能已经调整，但布局尚未完成。
 布局过程：
 2. viewDidLayoutSubviews在视图控制器的视图布局子视图后调用。在这个阶段，所有的视图和子视图的大小和位置已经确定。
 将代码放在viewDidLayoutSubviews中意味着您是在视图的大小和布局已经确定后才进行布局的调整或添加新视图，这有助于确保新加入的视图能正确地适应已有的布局。
 3. 自动布局（Auto Layout）：
 在viewDidLoad时，自动布局尚未完全应用，因此视图的尺寸和位置可能还不是最终状态。
 在viewWillAppear和viewDidLayoutSubviews中，自动布局约束已被处理，因此您的布局调整更有可能反映在最终界面上。
 动态内容适应：
 如果您的视图依赖于动态内容（如从网络加载的数据），在viewDidLayoutSubviews中调整布局可以确保内容加载后视图能够正确地适应新尺寸。
 总结来说，将代码移动到viewWillAppear或viewDidLayoutSubviews中意味着您在视图布局已经较为稳定时进行修改，这有助于避免布局冲突和不一致，确保布局的正确性和稳定性。
 */
