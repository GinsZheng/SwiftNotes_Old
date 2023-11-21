import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AutoLayoutCollectionViewLayoutDelegate, AutoLayoutCollectionViewCellDelegate, HorizonalScrollingButtonsDelegate {

    
    var currentUIForm: UIForm = .form1
    
    // 输出参数
    let titleOffset: CGFloat = 24
    let itemInterval: CGFloat = 6
    let itemHeight: CGFloat = 40
    
    var collectionView: UICollectionView!
    
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
        view.removeAllSubviews()
        
        let contentView = UIView()
        contentView.set(superview: view)
        contentView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 48)

        let bgView = UIView()
        bgView.set(superview: contentView, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let buttons = CSHorizonalScrollingButtons(titles: titles, delegate: self, target: self)
        buttons.set(superview: bgView)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupUI(showsHorizontalScrollIndicator: false)
        buttons.scrollView.contentSize.width += 48
        
        let switchButtonBg = UIImageView()
        switchButtonBg.set(superview: contentView, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: contentView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
        switchButton.setFrame(right: 12, centerY: contentView.height / 2, width: 28, height: 28)
        
    }
    
    func setupForm1() { // 折行
        view.removeAllSubviews()
        
//        let height =
        
        let contentView = UIView()
        contentView.set(superview: view)
        contentView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 100)
        
        let bgView = UIView()
        bgView.set(superview: contentView, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let frame = CGRect(x: 10, y: 0, width: kScreenWidth - 20, height: kWithoutNavBarHeight)
        let layout = AutoLayoutCollectionViewLayout(titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight)
        layout.delegate = self
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(AutoLayoutCollectionViewCell2.self, forCellWithReuseIdentifier: String(describing: AutoLayoutCollectionViewCell2.self))
        collectionView.set(superview: bgView, delegate: self, dataSource: self, viewController: self)
        
        let switchButtonBg = UIImageView()
        switchButtonBg.set(superview: contentView, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, bottom: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: contentView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: 12, bottom: 10, width: 28, height: 28)
        
//        contentView.height = autolayoutcoview
        // ⚠️下一步：写一个函数来获取CollectionView的高度 (同时超过10行时写一个上限值)
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
