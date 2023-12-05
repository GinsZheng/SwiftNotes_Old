
import UIKit

struct GroupCollectionViewStyles {
    static let fontSize: CGFloat = 14
    static let weight: UIFont.Weight = .medium
    static let titleOffset: CGFloat = 24
    static let itemInterval: CGFloat = 6
    static let itemHeight: CGFloat = 40
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let fontSize = GroupCollectionViewStyles.fontSize
    let weight = GroupCollectionViewStyles.weight
    let titleOffset = GroupCollectionViewStyles.titleOffset
    let itemInterval = GroupCollectionViewStyles.itemInterval
    let itemHeight = GroupCollectionViewStyles.itemHeight
    
    var currentUIForm: UIForm = .form0
    var collectionViewContentHeight: CGFloat = 0 // (可选项)获取collectionView内容高度(用于布局)
    let dataSource: [(title: String, bgColor: String)] = [
        (title: "0 Swift", bgColor: cBlue_5393FF),
        (title: "1 Xcode", bgColor: cPurple_BF62F8),
        (title: "2 Java", bgColor: cMagenta_FC5AAE),
        (title: "3 PHP", bgColor: cRed_FF635A),
        (title: "4 JS", bgColor: cOrange_F9AD18),
        (title: "5 React", bgColor: cGreen_25BE3C),
        (title: "6 Ruby", bgColor: cBluishGreen_01C7BD),
        (title: "7 HTML", bgColor: cBlue_5393FF),
        (title: "8 C#", bgColor: cPurple_BF62F8),
        (title: "9 C++", bgColor: cPurple_BF62F8),
    ]
    
    lazy var titles: [String] = dataSource.compactMap { $0.title }
    
    var collectionView: UICollectionView!
    let bgView = UIView()
    
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
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
    
    func setupForm0() { // 单行
        bgView.removeAllSubviews()
        bgView.set(superview: view, backgroundColor: cFFF)
        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 48)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let buttons = CSHorizonalScrollingGroupButtons(titles: titles, target: self) { [weak self] btn in
            self?.pushToTest()
        }
        buttons.set(superview: bgView)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupUI(showsHorizontalScrollIndicator: false)
        buttons.createTrashButton()
        buttons.createSettingsButton()
        buttons.scrollView.contentSize.width += 48 // 因为右侧的箭头按钮背景占了48
        
        let switchButtonBg = UIImageView()
        switchButtonBg.set(superview: bgView, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: bgView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
        switchButton.setFrame(right: 12, centerY: bgView.height / 2, width: 28, height: 28)
        
    }
    
    func setupForm1() { // 折行
        bgView.removeAllSubviews()
        bgView.set(superview: view, backgroundColor: cFFF)
        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 100)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let layout = GroupCollectionViewLayout()
        // 设置闭包：更新collectionView内容高度
        layout.onHeightUpdate = { [weak self] newHeight in
            self?.collectionViewContentHeight = newHeight
        }
        // 设置闭包：计算标题宽度
        layout.fetchTitleWidthsClosure = { [weak self] in
            guard let self = self else { return [] }
            var titleWidths: [CGFloat] = []
            for i in 0..<self.dataSource.count {
                let width = getLabelWidth(text: self.dataSource[i].title , fontSize: fontSize, weight: weight)
                titleWidths.append(width)
            }
            return titleWidths
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: GroupCollectionViewCell.self))
        collectionView.set(superview: bgView, delegate: self, dataSource: self, viewController: self)
        collectionView.setFrame(left: 10, top: 0, right: 10, height: kWithoutNavBarHeight)
    }
    
    
    // MARK: - CSHorizonalScrollingGroupButtons 代理方法
    
    func buttons(_ buttons: CSHorizonalScrollingGroupButtons, didSelectButtonAtIndex index: Int) {
        self.push(toTarget: CSGeneralSubpage())
    }
    
    
    // MARK: - CollectionView 代理方法
    
    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // 设置点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(toTarget: CSGeneralSubpage())
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // 设置 cell 逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GroupCollectionViewCell.self), for: indexPath) as! GroupCollectionViewCell
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        cell.setData(title: titles[indexPath.row])
        
        // 设置CollectionView内容的高度、添加底部的一排按钮
        if indexPath.row == dataSource.count - 1 {
            let collectionMaxHeight: CGFloat = 4 + 440 - 6 - 6 // 10.5行 (4:顶部多出4pt，440: 11行高度，6:按钮外边距，6:刻意隐藏)
            // CollectionView如果超过10.5行，高度就设为最大值，否则就设为实际行高
            let collectionViewHeight = collectionViewContentHeight > collectionMaxHeight ? collectionMaxHeight : collectionViewContentHeight
            let bgViewHeight = collectionViewHeight + 48

            collectionView.setFrame(left: 10, top: 0, right: 10, height: collectionViewHeight)
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
        
        return cell
    }
    
    
    // MARK: - @objc func
    
    @objc func switchView() {
        currentUIForm = currentUIForm == .form0 ? .form1 : .form0
        setupUI()
    }
    
    // MARK: - @objc func
    @objc func pushToTest() {
        self.push(toTarget: CSGeneralSubpage())
    }
    
}


class CSHorizonalScrollingGroupButtons: UIView {
    // 初始化参数
    var titles: [String]
    var target: UIViewController
    var forEvent: UIControl.Event
    
    let scrollView = UIScrollView()
    var buttons: [UIButton] = []
    
    var buttonLeft: CGFloat = 10 // 用于记录下一个按钮的左边界位置
    
    var buttonAction: ((Int) -> Void)?
    
    /// - 参数:
    ///   - titles: 每个按钮的标题
    ///   - target: 填self。用于处理scrollView侧滑冲突
    ///   - buttonAction: 闭包，填点击button时的操作逻辑
    ///   - forEvent: 触发事件，默认为 touchUpInside
    init(titles: [String], target: UIViewController, buttonAction: @escaping (Int) -> Void, forEvent: UIControl.Event = .touchUpInside) {
        self.titles = titles
        self.target = target
        self.forEvent = forEvent
        self.buttonAction = buttonAction
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
        for (i, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.tag = i // 用于标识是哪个button，以便在代理中赋值给didSelectButtonAtIndex，实现按不同按钮响应不同操作
            button.set(superview: scrollView, target: self, action: #selector(buttonTapped), forEvent: forEvent)
            button.setStyleSolidButton(title: title, titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
            
            // 计算按钮frame的参数
            let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
            let buttonWidth = labelWidth + 24
            let buttonHeight: CGFloat = 28
            let buttonCenterY = scrollView.centerY
            // 设置按钮的frame
            button.setFrame(left: buttonLeft, centerY: buttonCenterY, width: buttonWidth, height: buttonHeight)
            button.extendTouchArea()
            
            // 更新buttonLeft以便下一个按钮使用
            buttonLeft = button.right + 6
            
            buttons.append(button)
        }
        
        scrollView.contentSize = CGSize(width: buttonLeft + 10, height: 48)
    }
    
    func createTrashButton() {
        let trashButton = UIButton(type: .custom)
        trashButton.set(superview: scrollView, target: self, action: #selector(trashButtonTapped))
        trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
        trashButton.setFrame(left: buttonLeft, bottom: 10, width: getLabelWidth(text: "废纸蒌", fontSize: 14, weight: .medium) + 24, height: 28)
        trashButton.extendTouchArea()
        buttonLeft = trashButton.right + 6
        
        scrollView.contentSize = CGSize(width: buttonLeft + 10, height: 48)
    }
    
    func createSettingsButton() {
        let settingsButton = UIButton(type: .custom)
        settingsButton.set(superview: scrollView, target: self, action: #selector(settingsButtonTapped))
        settingsButton.setStyleIconButton(imageName: "home_settings")
        settingsButton.setFrame(left: buttonLeft, bottom: 10, width: 28, height: 28)
        settingsButton.extendTouchArea()
        buttonLeft = settingsButton.right + 6
        
        scrollView.contentSize = CGSize(width: buttonLeft + 10, height: 48)
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
    
    let fontSize = GroupCollectionViewStyles.fontSize
    let weight = GroupCollectionViewStyles.weight
    let titleOffset = GroupCollectionViewStyles.titleOffset
    
    let scrollView = UIScrollView()
    let button = UIButton(type: .custom)
    
    // MARK: - func
    
    func setData(title: String) {
        setButton(title: title)
        resetWidth()
    }
    
    func setButton(title: String) {
        button.set(superview: contentView, target: target, action: #selector(pushToTest))
        button.setStyleSolid14pt666LightGrayRoundedButton(title: title)
        button.setFrame(left: 0, top: 10, width: 0, height: 28)
    }
    
    func resetWidth() {
        button.width = (button.titleLabel?.getLabelWidth() ?? 10) + titleOffset
    }
    
    
    // MARK: - @objc func
    @objc func pushToTest() {
        print("done")
    }
    
}



// MARK: - 自定义Layout

class GroupCollectionViewLayout: UICollectionViewLayout {
    
    let titleOffset = GroupCollectionViewStyles.titleOffset
    let itemInterval: CGFloat = GroupCollectionViewStyles.itemInterval
    let itemHeight: CGFloat = GroupCollectionViewStyles.itemHeight
    
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
        layoutAttributes.removeAll()
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            if let attributes = layoutAttributesForItem(at: indexPath) {
                layoutAttributes.append(attributes)
            }
        }

    }
    
    // 设置内容区域总大小，是不可见区域
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight)
    }
    
    // 设为只有在可见区域内的单元格的布局属性会被返回，以减少不必要的计算和绘制，提高性能
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }
    
    // 设置单个单元格的位置属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        contentHeight = getAutoLayoutContentHeight(indexPath: indexPath, titleWidths: titleWidths, titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        
        if indexPath.row == itemCount - 1 { // 对于最后一个元素
            onHeightUpdate?(contentHeight) // 调用闭包：设置高度
        }
        
        let attributes = createAutoLayoutAttributes(indexPath: indexPath, titleWidths: titleWidths, titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight, collectionViewWidth: collectionView?.bounds.width ?? 0)
        return attributes
    }
    
}


