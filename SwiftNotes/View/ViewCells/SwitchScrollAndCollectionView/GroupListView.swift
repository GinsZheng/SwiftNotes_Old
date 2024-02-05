import UIKit

private class DataManager: BaseDataManager<Models.TaskGroup> {
    let taskGroupTable = TaskGroupTable()
    
    init() {
        super.init(initialItems: taskGroupTable.fetchAllData())
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


// MARK: - 分组控件(含单行/多行形态)
class GroupListView: UIView {
    typealias Styles = GroupCollectionViewStyles
    
    var onGroupSelected: (() -> Void)? // 用于处理按钮点击事件
    
    enum UIForm {
        case form0
        case form1
    }
    
    private let groupData = DataManager()
    lazy var titles: [String] = groupData.map { $0.groupName }
    
    var currentUIForm: UIForm = .form0
    var collectionViewContentHeight: CGFloat = 0
    
    // 定义一个 UIViewController 类型的变量
    unowned var parentVC: UIViewController
    let showTrashButton: Bool
    var collectionView: UICollectionView!
    let bgView = UIView()
    let bottomView = GroupBottomButtonsView()
    
    // MARK: - 初始化与生命周期方法
    init(frame: CGRect, viewController: UIViewController, showTrashButton: Bool) {
        self.parentVC = viewController
        self.showTrashButton = showTrashButton
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 公共方法
    func setupView() {
        setupFormViewUI()
        groupData.onItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    // 分组按钮按下
    func handleButtonsTap(buttonIndex: Int) {
        Preferences.setGroupSelection(isTrashSelected: false, groupId: groupData[buttonIndex].id, groupIndex: buttonIndex)
        onGroupSelected?()
    }
    
    // 废纸蒌按钮按下
    func handleTrashButtonTap() {
        Preferences.isTrashSelected = true
        onGroupSelected?()
    }
    

}


// MARK: - 私有方法
extension GroupListView {
    private func setupFormViewUI() {
        switch currentUIForm {
        case .form0:
            setupOneLineUI()
        case .form1:
            setupMultiLineUI()
        }
    }
    
    // 单行视图(折叠)
    private func setupOneLineUI() {
        self.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 48)
        
        bgView.removeAllSubviews()
        bgView.setup(superview: self, backgroundColor: cFFF) // 假设 cFFF 已定义
        bgView.setFrame(allEdges: 0)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let buttons = HorizonalScrollingGroupButtonsView(titles: titles, target: parentVC)
        buttons.setup(superview: bgView)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupView(showsHorizontalScrollIndicator: false, showTrashButton: true)
        buttons.onButtonsTapped = { [unowned self] tag in
            self.handleButtonsTap(buttonIndex: tag)
        }
        buttons.onSwitchButtonTapped = { [weak self] in
            self?.switchView()
        }
        buttons.onTrashButtonTapped = { [unowned self] in
            self.handleTrashButtonTap()
        }
    }
    
    // 多行视图(展开)
    private func setupMultiLineUI() {
        self.setFrame(left: 0, bottom: 0, right: 0, height: 100)
        
        bgView.removeAllSubviews()
        bgView.setup(superview: self, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
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
                getLabelWidth(withMaxWidth: 136, text: $0.groupName, fontSize: Styles.fontSize, weight: Styles.weight)
            }
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
        collectionView.setup(superview: bgView, delegate: self, dataSource: self, viewController: parentVC)
        collectionView.setFrame(left: 10, top: 0, right: 10, height: kWithoutNavBarHeight)
    }
    
    // MARK: - @objc func
    @objc private func switchView() {
        currentUIForm = currentUIForm == .form0 ? .form1 : .form0
        setupView()
    }
}


// MARK: - UICollectionView 代理方法
extension GroupListView: UICollectionViewDelegate, UICollectionViewDataSource {
    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupData.count
    }
    
    // 设置单元格渲染完成后的逻辑 (设置废纸蒌一栏)
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == groupData.count - 1 else { return } // 判断为最后一行时才添加废纸蒌栏
        
        // 设置CollectionView的高度(最大高度为10.5行)
        let collectionMaxHeight: CGFloat = 4 + 440 - 6 - 6 // 10.5行 (4:顶部多出4pt，440: 11行高度，6:按钮外边距，6:刻意隐藏)
        let collectionViewHeight = collectionViewContentHeight > collectionMaxHeight ? collectionMaxHeight : collectionViewContentHeight
        let bottomLineHeight: CGFloat = 48 // 底栏(含废纸蒌栏的)高度
        let selfHeight = collectionViewHeight + bottomLineHeight
        // 设置各个View的布局
        self.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: selfHeight)
        bgView.setFrame(allEdges: 0)
        bgView.setEachCornerRadiusWithMask(radius: kRadius, corners: [.topLeft, .topRight])
        collectionView.setFrame(left: kEdgeMargin, top: 0, right: kEdgeMargin, height: collectionViewHeight)
        
        bottomView.setup(superview: bgView)
        bottomView.setFrame(left: 0, bottom: 0, right: 0, height: bottomLineHeight)
        bottomView.setupView(showTrashButton: showTrashButton)
        updateButtonStatus() // 初始化废纸蒌状态
        bottomView.onTrashButtonTapped = { [unowned self] in
            handleTrashButtonTap()
            updateButtonStatus()
            self.collectionView.reloadData()
        }
        bottomView.onSwitchButtonTapped = { [weak self] in
            self?.switchView()
        }
        bottomView.onSettingsButtonTapped = { [unowned self] in
            self.parentVC.push(targetVC: CSGeneralSubpage())
        }
    }
    
    // 设置 cell 逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as? GroupCollectionViewCell else { return UICollectionViewCell() }
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        let isSelected = Preferences.isTrashSelected ? false : indexPath.row == Preferences.selectedGroupIndex
        cell.configure(withTitle: titles[indexPath.row], isSelected: isSelected) {
            // 定义cell点击事件
            self.handleButtonsTap(buttonIndex: indexPath.row)
            self.updateButtonStatus() 
            collectionView.reloadData()
        }
        return cell
    }
    
    private func updateButtonStatus() {
        bottomView.trashButton.isSelected = Preferences.isTrashSelected
        // 在这里不能放 collectionView.reloadData() ，不然在willDisplay代理函数中会引发无限循环。(因为willDisplay方法会内部调用reloadData)
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
    let trashButton = UIButton(type: .custom)
    
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
    
    // MARK: - 公共方法
    func setupView(showsHorizontalScrollIndicator: Bool, showTrashButton: Bool) {
        setupScrollView(showsHorizontalScrollIndicator: showsHorizontalScrollIndicator)
        createButtons()
        addSwitchButton()
        if showTrashButton {
            addTrashButton()
        }
        addSettingsButton()
    }
    
    // 更新按钮选中状态UI
    private func updateButtonStatus() {
        // 先清除所有选中状态
        buttons.forEach { $0.isSelected = false }
        trashButton.isSelected = false
        
        if Preferences.isTrashSelected {
            trashButton.isSelected = true
        } else {
            buttons[Preferences.selectedGroupIndex].isSelected = true
        }
        
    }
    
}

// 以上类的私有方法
extension HorizonalScrollingGroupButtonsView {
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
            button.setTitleColor(.hex(cBlue_5393FF), for: .selected)
            
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
        updateButtonStatus()
        scrollView.contentSize.width = buttonLeft + tailPadding
    }
    
    private func addSwitchButton() {
        let switchButtonBg = UIImageView()
        switchButtonBg.setup(superview: self, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.setup(superview: self, target: self, action: #selector(switchButtonTapped))
        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
        switchButton.setFrame(right: kCellPadding, centerY: self.height / 2, width: 28, height: 28)
        switchButton.extendTouchArea()
    }
    
    private func addTrashButton() {
        trashButton.setup(superview: scrollView, target: self, action: #selector(trashButtonTapped))
        trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
        trashButton.setTitleColor(.hex(cBlue_5393FF), for: .selected)
        trashButton.setFrame(left: buttonLeft, bottom: 10, width: (trashButton.titleLabel?.getLabelWidth() ?? 0) + 24, height: 28)
        trashButton.extendTouchArea()
        updateButtonStatus()
        
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
        updateButtonStatus() // 要放onButtonsTapped后，因为onButtonsTapped会更新Preferences
    }
    
    @objc private func switchButtonTapped() {
        onSwitchButtonTapped?()
    }
    
    @objc private func trashButtonTapped() {
        onTrashButtonTapped?()
        updateButtonStatus()
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
        button.setTitleColor(.hex(cBlue_5393FF), for: .selected)
    }
    
    func configure(withTitle title: String, isSelected: Bool, action: (() -> Void)?, forEvent: UIControl.Event = UIControl.Event.touchUpInside) {
        button.setTitle(title, for: .normal)
        button.isSelected = isSelected
        let buttonWidth = (button.titleLabel?.getLabelWidth() ?? 0) + Styles.buttonPadding
        button.setFrame(left: 0, top: 10, width: buttonWidth, height: 28)
        buttonAction = action // 存储参数中的闭包，然后在buttonsTapped中执行
        button.addTarget(self, action: #selector(buttonsTapped(_:)), for: forEvent)
        button.extendTouchArea()
    }
    
    // MARK: - @objc func
    @objc func buttonsTapped(_ sender: UIButton) {
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
    open func setupView(showTrashButton: Bool) {
        switchButtonBg.setup(superview: self, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, bottom: 0, width: 72, height: 48)
        
        switchButton.setup(superview: self, target: self, action: #selector(switchButtonTapped))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: kCellPadding, bottom: 10, width: 28, height: 28)
        switchButton.extendTouchArea()
        
        settingsButton.setup(superview: self, target: self, action: #selector(settingsButtonTapped))
        settingsButton.setStyleIconButton(imageName: "home_settings")
        settingsButton.setFrame(right: 57, bottom: 10, width: 28, height: 28)
        settingsButton.extendTouchArea()
        
        if showTrashButton {
            addTrashButton()
        }
    }
}


// 上方类的私有方法
extension GroupBottomButtonsView {
    private func addTrashButton() {
        trashButton.setup(superview: self, target: self, action: #selector(trashButtonTapped))
        trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
        trashButton.setTitleColor(.hex(cBlue_5393FF), for: .selected)
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
