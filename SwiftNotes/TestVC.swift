import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AutoLayoutCollectionViewLayoutDelegate, AutoLayoutCollectionViewCellDelegate, HorizonalScrollingButtonsDelegate {

    
    var currentUIForm: UIForm = .form1
    
    // 输出参数
    let titleOffset: CGFloat = 24
    let itemInterval: CGFloat = 6
    let itemHeight: CGFloat = 40
    
    var collectionView: UICollectionView!
    let bgView = UIView()
    
    let dataSource = [
        ["title":"0 Swift","bgColor":cBlue_5393FF],
        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
        ["title":"3 PHP","bgColor":cRed_FF635A],
        ["title":"4 JIIIIII","bgColor":cOrange_F9AD18],
        ["title":"5 Reac","bgColor":cGreen_25BE3C],
        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"7 HTML","bgColor":cBlue_5393FF],
        ["title":"8 C# ","bgColor":cPurple_BF62F8],
        ["title":"9 C++","bgColor":cPurple_BF62F8],
        ["title":"0 Swift","bgColor":cBlue_5393FF],
        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
        ["title":"3 PHP","bgColor":cRed_FF635A],
        ["title":"4 JIIIIII","bgColor":cOrange_F9AD18],
        ["title":"5 Reac","bgColor":cGreen_25BE3C],
        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"7 HTML","bgColor":cBlue_5393FF],
        ["title":"8 C# ","bgColor":cPurple_BF62F8],
        ["title":"9 C++","bgColor":cPurple_BF62F8],
        ["title":"0 Swift","bgColor":cBlue_5393FF],
        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
        ["title":"3 PHP","bgColor":cRed_FF635A],
        ["title":"4 JIIIIII","bgColor":cOrange_F9AD18],
        ["title":"5 Reac","bgColor":cGreen_25BE3C],
        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"7 HTML","bgColor":cBlue_5393FF],
        ["title":"8 C# ","bgColor":cPurple_BF62F8],
        ["title":"9 C++","bgColor":cPurple_BF62F8],
        ["title":"0 Swift","bgColor":cBlue_5393FF],
        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
        ["title":"3 PHP","bgColor":cRed_FF635A],
        ["title":"4 JIIIIII","bgColor":cOrange_F9AD18],
        ["title":"5 Reac","bgColor":cGreen_25BE3C],
        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"7 HTML","bgColor":cBlue_5393FF],
        ["title":"8 C# ","bgColor":cPurple_BF62F8],
        ["title":"9 C++","bgColor":cPurple_BF62F8],
        
    ]
    
    lazy var titles: [String] = dataSource.compactMap { $0["title"] }
    
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
        
        let buttons = CSHorizonalScrollingButtons(titles: titles, delegate: self, target: self)
        buttons.set(superview: bgView)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupUI(showsHorizontalScrollIndicator: false)
        buttons.scrollView.contentSize.width += 48
        
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
        
        let frame = CGRect(x: 10, y: 0, width: kScreenWidth - 20, height: kWithoutNavBarHeight)
        let layout = AutoLayoutCollectionViewLayout(titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight)
        layout.delegate = self
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(AutoLayoutCollectionViewCell2.self, forCellWithReuseIdentifier: String(describing: AutoLayoutCollectionViewCell2.self))
        collectionView.set(superview: bgView, delegate: self, dataSource: self, viewController: self)
//        collectionView.setBackgroundColor(color: cRed_FF635A)
    }
    
    
    // MARK: - CSHorizonalScrollingButtons 代理方法
    
    func buttons(_ buttons: CSHorizonalScrollingButtons, didSelectButtonAtIndex index: Int) {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AutoLayoutCollectionViewCell2.self), for: indexPath) as! AutoLayoutCollectionViewCell2
        cell.delegate = self
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        cell.setData(title: titles[indexPath.row])
        
        // 设置CollectionView内容的高度
        if indexPath.row == dataSource.count - 1 {
            let collectionMaxHeight: CGFloat = 4 + 440 - 6 - 6 // 10.5行 (4:顶部多出4pt，440: 11行高度，6:按钮外边距，6:刻意隐藏)
            // CollectionView如果超过10.5行，高度就设为最大值，否则就设为实际行高
            print("kCollectionViewContentHeight", kCollectionViewContentHeight)
            let collectionViewHeight = kCollectionViewContentHeight > collectionMaxHeight ? collectionMaxHeight : kCollectionViewContentHeight
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
            
            let settingButton = UIButton(type: .custom)
            settingButton.set(superview: bottomLineBg, target: self, action: #selector(pushToTest))
            settingButton.setStyleIconButton(imageName: "home_settings")
            settingButton.setFrame(right: 57, bottom: 10, width: 28, height: 28)
            
        }
        
        return cell
    }
    
    
    // MARK: - AutoLayoutCollectionViewLayoutDelegate 代理方法
    
    func fetchTitleWidths() -> [CGFloat] {
        var titleWidths: [CGFloat] = []
        for i in 0..<dataSource.count {
            // ⚠️这里fontSize和weight要和下面的AutoLayoutCollectionViewCell2中的保持一致
            let width = getLabelWidth(text: dataSource[i]["title"] ?? "", fontSize: 14, weight: .medium)
            titleWidths.append(width)
        }
        
        return titleWidths
    }
    
    
    // MARK: - AutoLayoutCollectionViewCellDelegate 代理方法
    func fetchTitleOffset() -> CGFloat {
        return titleOffset
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


//class SwitchFormView: UIView {
//    
//    var currentUIForm: UIForm = .form0
//    
//}
