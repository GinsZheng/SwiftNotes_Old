import UIKit

// CollectionView的参数
struct GroupCollectionViewStyles {
    static let fontSize: CGFloat = 14
    static let weight: UIFont.Weight = .medium
    static let titleOffset: CGFloat = 24
    static let itemInterval: CGFloat = 6
    static let itemHeight: CGFloat = 40
}

class ViewController: UIViewController {
    
    typealias Styles = GroupCollectionViewStyles
    
    // collectionView数据的结构体
    struct Item {
        let title: String
        let bgColor: String
    }
    
    enum UIForm {
        case form0
        case form1
    }
    
    var dataSource: [Item] = [
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
    ] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var titles: [String] = dataSource.compactMap { $0.title }
    var currentUIForm: UIForm = .form0
    var collectionViewContentHeight: CGFloat = 0 // 获取collectionView内容高度(用于布局)
    
    var collectionView: UICollectionView!
    let bgView = UIView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        setupCommonUI()
        setupFormViewUI()
    }
    
    func setupCommonUI() {
        view.setBackgroundColor(color: cF2F3F6)
    }
    
    func setupFormViewUI() {
        switch currentUIForm {
        case .form0:
            setupForm0()
        case .form1:
            setupForm1()
        }
    }
    
    // 单行视图
    func setupForm0() {
        bgView.set(superview: view, backgroundColor: cFFF)
        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 48)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let buttons = CSHorizonalScrollingGroupButtons(titles: titles, target: self) { [weak self] _ in
            self?.push(toTarget: CSGeneralSubpage())
        }
        buttons.set(superview: bgView)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupUI(showsHorizontalScrollIndicator: false)
        buttons.createTrashButton()
        buttons.createSettingsButton()
        buttons.scrollView.contentSize.width += 48 // 因为右侧的箭头按钮背景占了48pt
        
        let switchButtonBg = UIImageView()
        switchButtonBg.set(superview: bgView, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: bgView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
        switchButton.setFrame(right: 12, centerY: bgView.height / 2, width: 28, height: 28)
    }
    
    // 多行视图
    func setupForm1() {
        bgView.set(superview: view, backgroundColor: cFFF)
        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 100)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        // 创建collectionView用到的Layout
        let layout = GroupCollectionViewLayout()
        // 设置闭包：更新collectionView内容高度
        layout.onHeightUpdate = { [weak self] newHeight in
            self?.collectionViewContentHeight = newHeight
        }
        // 设置闭包：计算标题宽度
        layout.fetchTitleWidthsClosure = { [weak self] in
            guard let self = self else { return [] }
            return dataSource.map {
                getLabelWidth(withMaxWidth: 136, text: $0.title, fontSize: Styles.fontSize, weight: Styles.weight)
            }
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
        collectionView.set(superview: bgView, delegate: self, dataSource: self, viewController: self)
        collectionView.setFrame(left: 10, top: 0, right: 10, height: kWithoutNavBarHeight)
    }
    
    
    // MARK: - @objc func
    @objc func switchView() {
        currentUIForm = currentUIForm == .form0 ? .form1 : .form0
        setupUI()
    }
    
    @objc func pushToTest() {
        self.push(toTarget: CSGeneralSubpage())
    }
    
}


// MARK: - 代理方法：UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    // 设置点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(toTarget: CSGeneralSubpage())
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // 设置单元格渲染完成后的逻辑
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1 {
            addBottomButtons(in: collectionView)
        }
    }
    
    private func addBottomButtons(in collectionView: UICollectionView) {
        // 设置CollectionView的高度(最大高度为10.5行)
        let collectionMaxHeight: CGFloat = 4 + 440 - 6 - 6 // 10.5行 (4:顶部多出4pt，440: 11行高度，6:按钮外边距，6:刻意隐藏)
        let collectionViewHeight = collectionViewContentHeight > collectionMaxHeight ? collectionMaxHeight : collectionViewContentHeight
        collectionView.setFrame(left: 10, top: 0, right: 10, height: collectionViewHeight)
        
        let bgViewHeight = collectionViewHeight + 48 // 48 为底栏(含废纸蒌栏的)高度
        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: bgViewHeight)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let bottomLineBg = UIView()
        bottomLineBg.set(superview: bgView, backgroundColor: cFFF)
        bottomLineBg.setFrame(left: 0, bottom: 0, right: 0, height: 48)
        
        let trashButton = UIButton(type: .custom)
        trashButton.set(superview: bottomLineBg, target: self, action: #selector(pushToTest))
        trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
        trashButton.setFrame(left: 10, bottom: 10, width: getLabelWidth(text: "废纸蒌", fontSize: 14, weight: .medium) + 24, height: 28)
        
        let switchButtonBg = UIImageView()
        switchButtonBg.set(superview: bottomLineBg, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, bottom: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: bottomLineBg, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: 12, bottom: 10, width: 28, height: 28)
        
        let settingsButton = UIButton(type: .custom)
        settingsButton.set(superview: bottomLineBg, target: self, action: #selector(pushToTest))
        settingsButton.setStyleIconButton(imageName: "home_settings")
        settingsButton.setFrame(right: 57, bottom: 10, width: 28, height: 28)
    }
}


// MARK: - 代理方法：UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
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
class CSHorizonalScrollingGroupButtons: UIView {
    // 初始化参数
    var titles: [String]
    var target: UIViewController
    var forEvent: UIControl.Event
    var buttonLeft: CGFloat = 10 // 用于记录下一个按钮的左边界位置
    
    let scrollView = UIScrollView()
    var buttons: [UIButton] = []
    
    // 定义闭包属性
    var buttonAction: ((Int) -> Void)?
    
    /// - 参数:
    ///   - titles: 每个按钮的标题
    ///   - target: 填self。用于处理scrollView侧滑冲突
    ///   - buttonAction: 闭包，填点击button时的操作逻辑
    ///   - forEvent: 触发事件，默认为 touchUpInside
    init(titles: [String], target: UIViewController, buttonAction: @escaping (Int) -> Void, forEvent: UIControl.Event = .touchUpInside) {
        self.titles = titles
        self.target = target
        self.buttonAction = buttonAction
        self.forEvent = forEvent
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - func
    func setupUI(showsHorizontalScrollIndicator: Bool) {
        setupScrollView(showsHorizontalScrollIndicator: showsHorizontalScrollIndicator)
        createButtons()
    }
    
    func setupScrollView(showsHorizontalScrollIndicator: Bool) {
        scrollView.set(superview: self)
        scrollView.setFrame(allEdges: 0)
        scrollView.OptimizeEdgePanGesture(of: target)
        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    }
    
    func createButtons() {
        
        let buttonHeight: CGFloat = 28
        let buttonCenterY = scrollView.centerY
        let titleOffset: CGFloat = 24
        let itemInterval: CGFloat = 6
        let scrollViewTailOffset: CGFloat = 4
        
        for (i, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = i // 用于标识是哪个button，以便在代理中赋值给didSelectButtonAtIndex，实现按不同按钮响应不同操作
            button.set(superview: scrollView, target: self, action: #selector(buttonTapped), forEvent: forEvent)
            button.setStyleSolid14pt666LightGrayRoundedButton(title: title)
            
            // 计算按钮frame的参数
            let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
            let buttonWidth = labelWidth + titleOffset
            // 设置按钮的frame
            button.setFrame(left: buttonLeft, centerY: buttonCenterY, width: buttonWidth, height: buttonHeight)
            
            // 更新buttonLeft以便下一个按钮使用
            buttonLeft = button.right + itemInterval
            
            buttons.append(button)
        }
        
        scrollView.contentSize = CGSize(width: buttonLeft + scrollViewTailOffset, height: 48)
    }
    
    func createTrashButton() {
        let trashButton = UIButton(type: .custom)
        trashButton.set(superview: scrollView, target: self, action: #selector(trashButtonTapped))
        trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
        trashButton.setFrame(left: buttonLeft, bottom: 10, width: getLabelWidth(text: "废纸蒌", fontSize: 14, weight: .medium) + 24, height: 28)
        trashButton.extendTouchArea()
        
        buttonLeft = trashButton.right + 6
        scrollView.contentSize.width = buttonLeft + 10
    }
    
    func createSettingsButton() {
        let settingsButton = UIButton(type: .custom)
        settingsButton.set(superview: scrollView, target: self, action: #selector(settingsButtonTapped))
        settingsButton.setStyleIconButton(imageName: "home_settings")
        settingsButton.setFrame(left: buttonLeft, bottom: 10, width: 28, height: 28)
        settingsButton.extendTouchArea()
        
        buttonLeft = settingsButton.right + 6
        scrollView.contentSize.width = buttonLeft + 10
    }
    
    
    // MARK: - @objc func
    @objc private func buttonTapped(_ button: UIButton) {
        buttonAction?(button.tag)
    }
    
    @objc func trashButtonTapped() {
        target.push(toTarget: CSGeneralSubpage())
    }
    
    @objc func settingsButtonTapped() {
        target.push(toTarget: CSGeneralSubpage())
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
        button.set(superview: contentView)
        button.setStyleSolidButton(title: "", titleSize: Styles.fontSize, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
    }
    
    func configure(withTitle title: String, action: (() -> Void)?, forEvent: UIControl.Event = UIControl.Event.touchUpInside) {
        button.setTitle(title, for: .normal)
        let bottomWidth = (button.titleLabel?.getLabelWidth() ?? 0) + Styles.titleOffset
        button.setFrame(left: 0, top: 10, width: bottomWidth, height: 28)
        
        // 存储闭包
        buttonAction = action
        button.addTarget(self, action: #selector(handleButtonAction), for: forEvent)

    }
    
    
    // MARK: - @objc func
    @objc func handleButtonAction() {
        buttonAction?()
    }
    
}



// MARK: - 自定义Layout
class GroupCollectionViewLayout: UICollectionViewLayout {
    
    typealias Styles = GroupCollectionViewStyles
    
    var onHeightUpdate: ((CGFloat) -> Void)?     // 获取高度的闭包
    var fetchTitleWidthsClosure: (() -> [CGFloat])? // 获取标题宽度的闭包
    var titleWidths: [CGFloat] {
        return fetchTitleWidthsClosure?() ?? []
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
            return createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, titleOffset: Styles.titleOffset, itemInterval: Styles.itemInterval, itemHeight: Styles.itemHeight, collectionViewWidth: collectionView.width)
        })
        
        // 更新内容高度
        if let lastIndexPath = layoutAttributes.last?.indexPath {
            contentHeight = getAutoLayoutContentHeight(indexPath: lastIndexPath, titleWidths: titleWidths, titleOffset: Styles.titleOffset, itemInterval: Styles.itemInterval, itemHeight: Styles.itemHeight, collectionViewWidth: collectionView.width)
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



