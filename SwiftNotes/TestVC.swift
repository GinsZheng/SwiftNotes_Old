import UIKit

class ViewController: UIViewController {
    
    
    
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        
    }
    
    
    // MARK: - 代理方法
    
    
    
    
    // MARK: - @objc func
    
    
    
    
}




//import UIKit
//
//class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AutoLayoutCollectionViewLayoutDelegate, AutoLayoutCollectionViewCellDelegate, HorizonalScrollingGroupButtonsDelegate {
//
//    var currentUIForm: UIForm = .form0
//    
//    // 输出参数
//    let titleOffset: CGFloat = 24
//    let itemInterval: CGFloat = 6
//    let itemHeight: CGFloat = 40
//    
//    var collectionView: UICollectionView!
//    let bgView = UIView()
//    
//    let dataSource = [
//        ["title":"0 Swift","bgColor":cBlue_5393FF],
//        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
//        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
//        ["title":"3 PHP","bgColor":cRed_FF635A],
//        ["title":"4 JIIIIII","bgColor":cOrange_F9AD18],
//        ["title":"5 Reac","bgColor":cGreen_25BE3C],
//        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
//        ["title":"7 HTML","bgColor":cBlue_5393FF],
//        ["title":"8 C# ","bgColor":cPurple_BF62F8],
//        ["title":"9 C++","bgColor":cPurple_BF62F8],
//        ["title":"0 Swift","bgColor":cBlue_5393FF],
//        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
//        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
//        ["title":"3 PHP","bgColor":cRed_FF635A],
//        ["title":"4 JIIIIII","bgColor":cOrange_F9AD18],
//        ["title":"5 Reac","bgColor":cGreen_25BE3C],
//        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
//        ["title":"7 HTML","bgColor":cBlue_5393FF],
//        ["title":"8 C# ","bgColor":cPurple_BF62F8],
//        ["title":"9 C++","bgColor":cPurple_BF62F8],
//        ["title":"0 Swift","bgColor":cBlue_5393FF],
//        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
//        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
//        ["title":"3 PHP","bgColor":cRed_FF635A],
//        ["title":"4 JIIIIII","bgColor":cOrange_F9AD18],
//        ["title":"5 Reac","bgColor":cGreen_25BE3C],
//        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
//        ["title":"7 HTML","bgColor":cBlue_5393FF],
//        ["title":"8 C# ","bgColor":cPurple_BF62F8],
//        ["title":"9 C++","bgColor":cPurple_BF62F8],
//        ["title":"0 Swift","bgColor":cBlue_5393FF],
//        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
//        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
//        ["title":"3 PHP","bgColor":cRed_FF635A],
//        ["title":"4 JIIIIII","bgColor":cOrange_F9AD18],
//        ["title":"5 Reac","bgColor":cGreen_25BE3C],
//        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
//        ["title":"7 HTML","bgColor":cBlue_5393FF],
//        ["title":"8 C# ","bgColor":cPurple_BF62F8],
//        ["title":"9 C++","bgColor":cPurple_BF62F8],
//        
//    ]
//    
//    lazy var titles: [String] = dataSource.compactMap { $0["title"] }
//    
//    // MARK: - 生命周期方法
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupUI()
//    }
//    
//    // MARK: - func
//    
//    func setupUI() {
//        view.setBackgroundColor(color: cF2F3F6)
//        
//        setupCommonUI()
//        setupFormViewUI()
//    }
//    
//    
//    func setupCommonUI() {
//        view.setBackgroundColor(color: cF2F3F6)
//    }
//    
//    func setupFormViewUI() {
//        switch currentUIForm {
//        case .form0:
//            setupForm0()
//        case .form1:
//            setupForm1()
//        }
//    }
//    
//    func setupForm0() { // 单行
//        bgView.removeAllSubviews()
//        bgView.set(superview: view, backgroundColor: cFFF)
//        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 48)
//        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
//        
//        let buttons = CSHorizonalScrollingGroupButtons(titles: titles, delegate: self, target: self)
//        buttons.set(superview: bgView)
//        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
//        buttons.setupUI(showsHorizontalScrollIndicator: false)
//        buttons.createTrashButton()
//        buttons.createSettingsButton()
//        buttons.scrollView.contentSize.width += 48 // 因为右侧的箭头按钮背景占了48
//        
//        let switchButtonBg = UIImageView()
//        switchButtonBg.set(superview: bgView, imageName: "groupBar_gradientMask")
//        switchButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
//        
//        let switchButton = UIButton(type: .custom)
//        switchButton.set(superview: bgView, target: self, action: #selector(switchView))
//        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
//        switchButton.setFrame(right: 12, centerY: bgView.height / 2, width: 28, height: 28)
//        
//    }
//    
//    func setupForm1() { // 折行
//        bgView.removeAllSubviews()
//        bgView.set(superview: view, backgroundColor: cFFF)
//        bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 100)
//        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
//        
//        let frame = CGRect(x: 10, y: 0, width: kScreenWidth - 20, height: kWithoutNavBarHeight)
//        let layout = AutoLayoutCollectionViewLayout(titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight)
//        layout.delegate = self
//        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
//        collectionView.register(AutoLayoutCollectionViewCell2.self, forCellWithReuseIdentifier: String(describing: AutoLayoutCollectionViewCell2.self))
//        collectionView.set(superview: bgView, delegate: self, dataSource: self, viewController: self)
//    }
//    
//    
//    // MARK: - CSHorizonalScrollingGroupButtons 代理方法
//    
//    func buttons(_ buttons: CSHorizonalScrollingGroupButtons, didSelectButtonAtIndex index: Int) {
//        self.push(toTarget: CSGeneralSubpage())
//    }
//    
//    
//    // MARK: - CollectionView 代理方法
//    
//    // 设置数量
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataSource.count
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
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AutoLayoutCollectionViewCell2.self), for: indexPath) as! AutoLayoutCollectionViewCell2
//        cell.delegate = self
//        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
//        cell.setData(title: titles[indexPath.row])
//        
//        // 设置CollectionView内容的高度
//        if indexPath.row == dataSource.count - 1 {
//            let collectionMaxHeight: CGFloat = 4 + 440 - 6 - 6 // 10.5行 (4:顶部多出4pt，440: 11行高度，6:按钮外边距，6:刻意隐藏)
//            // CollectionView如果超过10.5行，高度就设为最大值，否则就设为实际行高
//            print("kCollectionViewContentHeight", kCollectionViewContentHeight)
//            let collectionViewHeight = kCollectionViewContentHeight > collectionMaxHeight ? collectionMaxHeight : kCollectionViewContentHeight
//            let bgViewHeight = collectionViewHeight + 48
//
//            collectionView.setFrame(left: 10, top: 0, right: 10, height: collectionViewHeight)
//            bgView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: bgViewHeight)
//            bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
//            
//            let bottomLineBg = UIView()
//            bottomLineBg.set(superview: bgView, backgroundColor: cFFF)
//            bottomLineBg.setFrame(left: 0, bottom: 0, right: 0, height: 48)
//            
//            let trashButton = UIButton(type: .custom)
//            trashButton.set(superview: bottomLineBg, target: self, action: #selector(pushToTest))
//            trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
//            trashButton.setFrame(left: 10, bottom: 10, width: getLabelWidth(text: "废纸蒌", fontSize: 14, weight: .medium) + 24, height: 28)
//            
//            let switchButtonBg = UIImageView()
//            switchButtonBg.set(superview: bottomLineBg, imageName: "groupBar_gradientMask")
//            switchButtonBg.setFrame(right: 0, bottom: 0, width: 72, height: 48)
//            
//            let switchButton = UIButton(type: .custom)
//            switchButton.set(superview: bottomLineBg, target: self, action: #selector(switchView))
//            switchButton.setStyleIconButton(imageName: "groupBar_fold")
//            switchButton.setFrame(right: 12, bottom: 10, width: 28, height: 28)
//            
//            let settingsButton = UIButton(type: .custom)
//            settingsButton.set(superview: bottomLineBg, target: self, action: #selector(pushToTest))
//            settingsButton.setStyleIconButton(imageName: "home_settings")
//            settingsButton.setFrame(right: 57, bottom: 10, width: 28, height: 28)
//            
//        }
//        
//        return cell
//    }
//    
//    
//    // MARK: - AutoLayoutCollectionViewLayoutDelegate 代理方法
//    
//    func fetchTitleWidths() -> [CGFloat] {
//        var titleWidths: [CGFloat] = []
//        for i in 0..<dataSource.count {
//            // ⚠️这里fontSize和weight要和下面的AutoLayoutCollectionViewCell2中的保持一致
//            let width = getLabelWidth(text: dataSource[i]["title"] ?? "", fontSize: 14, weight: .medium)
//            titleWidths.append(width)
//        }
//        
//        return titleWidths
//    }
//    
//    
//    // MARK: - AutoLayoutCollectionViewCellDelegate 代理方法
//    func fetchTitleOffset() -> CGFloat {
//        return titleOffset
//    }
//    
//    
//    // MARK: - @objc func
//    
//    @objc func switchView() {
//        currentUIForm = currentUIForm == .form0 ? .form1 : .form0
//        setupUI()
//    }
//    
//    // MARK: - @objc func
//    @objc func pushToTest() {
//        self.push(toTarget: CSGeneralSubpage())
//    }
//    
//}
//
//
//// MARK: - 用于代理横向滑动的按钮列表的点击事件
//protocol HorizonalScrollingGroupButtonsDelegate: AnyObject {
//    func buttons(_ buttons: CSHorizonalScrollingGroupButtons, didSelectButtonAtIndex index: Int)
//}
//
//class CSHorizonalScrollingGroupButtons: UIView {
//    // 初始化参数
//    var titles: [String]
//    var target: UIViewController
//    var forEvent: UIControl.Event
//    
//    let scrollView = UIScrollView()
//    var buttons: [UIButton] = []
//    
//    var buttonLeft: CGFloat = 10 // 用于记录下一个按钮的左边界位置
//    
//    weak var delegate: HorizonalScrollingGroupButtonsDelegate?
//    
//    /// - 参数:
//    ///   - titles: 每个按钮的标题
//    ///   - target: 填self。用于处理scrollView侧滑冲突
//    ///   - forEvent: 触发事件，默认为 touchUpInside
//    ///   - delegate: 填self。为指定 HorizonalScrollingGroupButtonsDelegate 的代理
//    init(titles: [String], delegate: HorizonalScrollingGroupButtonsDelegate, target: UIViewController, forEvent: UIControl.Event = .touchUpInside) {
//        self.titles = titles
//        self.target = target
//        self.forEvent = forEvent
//        self.delegate = delegate
//        super.init(frame: .zero)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - func
//    
//    func setupUI(showsHorizontalScrollIndicator: Bool) {
//        setupScrollView(showsHorizontalScrollIndicator: showsHorizontalScrollIndicator)
//        createButtons()
//    }
//    
//    func setupScrollView(showsHorizontalScrollIndicator: Bool) {
//        scrollView.set(superview: self)
//        scrollView.setFrame(allEdges: 0)
//        scrollView.OptimizeEdgePanGesture(of: target)
//        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
//    }
//    
//    func createButtons() {
//        
//        for (i, title) in titles.enumerated() {
//            let button = UIButton(type: .custom)
//            button.tag = i // 用于标识是哪个button，以便在代理中赋值给didSelectButtonAtIndex，实现按不同按钮响应不同操作
//            button.set(superview: scrollView, target: self, action: #selector(buttonTapped), forEvent: forEvent)
//            button.setStyleSolidButton(title: title, titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
//            
//            // 计算按钮frame的参数
//            let labelWidth = button.titleLabel?.getLabelWidth() ?? 0
//            let buttonWidth = labelWidth + 24
//            let buttonHeight: CGFloat = 28
//            let buttonCenterY = scrollView.centerY
//            // 设置按钮的frame
//            button.setFrame(left: buttonLeft, centerY: buttonCenterY, width: buttonWidth, height: buttonHeight)
//            button.extendTouchArea()
//            
//            // 更新buttonLeft以便下一个按钮使用
//            buttonLeft = button.right + 6
//            
//            buttons.append(button)
//        }
//        
//        scrollView.contentSize = CGSize(width: buttonLeft + 10, height: 48)
//    }
//    
//    func createTrashButton() {
//        let trashButton = UIButton(type: .custom)
//        trashButton.set(superview: scrollView, target: self, action: #selector(trashButtonTapped))
//        trashButton.setStyleSolidButton(title: "废纸蒌", titleSize: 14, titleColor: c666, bgImage: getImageWithColor(color: cF0F1F3), radius: 14)
//        trashButton.setFrame(left: buttonLeft, bottom: 10, width: getLabelWidth(text: "废纸蒌", fontSize: 14, weight: .medium) + 24, height: 28)
//        trashButton.extendTouchArea()
//        buttonLeft = trashButton.right + 6
//        
//        scrollView.contentSize = CGSize(width: buttonLeft + 10, height: 48)
//    }
//    
//    func createSettingsButton() {
//        let settingsButton = UIButton(type: .custom)
//        settingsButton.set(superview: scrollView, target: self, action: #selector(settingsButtonTapped))
//        settingsButton.setStyleIconButton(imageName: "home_settings")
//        settingsButton.setFrame(left: buttonLeft, bottom: 10, width: 28, height: 28)
//        settingsButton.extendTouchArea()
//        buttonLeft = settingsButton.right + 6
//        
//        scrollView.contentSize = CGSize(width: buttonLeft + 10, height: 48)
//    }
//    
//    
//    // MARK: - 代理方法
//    @objc private func buttonTapped(_ button: UIButton) {
//        delegate?.buttons(self, didSelectButtonAtIndex: button.tag)
//    }
//    
//    @objc func trashButtonTapped() {
//        target.push(toTarget: CSGeneralSubpage())
//    }
//    
//    @objc func settingsButtonTapped() {
//        target.push(toTarget: CSGeneralSubpage())
//    }
//
//}
//
//
////struct AssociatedKeys {
////  static var heroID    = "heroID"
////  static var heroModifiers = "heroModifers"
////  static var heroStoredAlpha = "heroStoredAlpha"
////  static var heroEnabled = "heroEnabled"
////  static var heroEnabledForSubviews = "heroEnabledForSubviews"
////}
