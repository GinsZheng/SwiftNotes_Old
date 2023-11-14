import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AutoLayoutCollectionViewLayoutDelegate, AutoLayoutCollectionViewCellDelegate {

    var currentUIForm: UIForm = .form0
    
    // 输出参数
    let titleOffset: CGFloat = 24
    let itemInterval: CGFloat = 6
    let itemHeight: CGFloat = 40
    
    var collectionView: UICollectionView!
    
    let dateSource = [
        ["title":"0 Swift","bgColor":cBlue_5393FF],
        ["title":"1 Xcode","bgColor":cPurple_BF62F8],
        ["title":"2 Java","bgColor":cMagenta_FC5AAE],
        ["title":"3 PHP","bgColor":cRed_FF635A],
        ["title":"4 JS","bgColor":cOrange_F9AD18],
        ["title":"5 Reac","bgColor":cGreen_25BE3C],
        ["title":"6 Ruby","bgColor":cBluishGreen_01C7BD],
        ["title":"7 HTML","bgColor":cBlue_5393FF],
        ["title":"8 C# ","bgColor":cPurple_BF62F8],
        ["title":"9 C++","bgColor":cPurple_BF62F8],
    ]
    
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
    
    func setupForm0() {
        view.removeAllSubviews()
        
        let contentView = UIView()
        contentView.set(superview: view)
        contentView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 48)

        let bgView = UIView()
        bgView.set(superview: contentView, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        
        let buttonList = CSHorizonalScrollingButtonList(target: self, action: #selector(pushToTest), frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 48))
        buttonList.set(superview: bgView)
        buttonList.scrollView.showsHorizontalScrollIndicator = false
        buttonList.scrollView.contentSize.width += 48
        
        let switchButtonBg = UIImageView()
        switchButtonBg.set(superview: contentView, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: contentView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
        switchButton.setFrame(right: 12, centerY: contentView.height / 2, width: 28, height: 28)

        
    }
    
    func setupForm1() {
        view.removeAllSubviews()
        
        let contentView = UIView()
        contentView.set(superview: view)
        contentView.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 200)
        
        let bgView = UIView()
        bgView.set(superview: contentView, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setCornerRadiusWithMask(radius: 10)
        
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth - 40, height: kWithoutNavBarHeight)
        let layout = AutoLayoutCollectionViewLayout(titleOffset: titleOffset, itemInterval: itemInterval, itemHeight: itemHeight)
        layout.delegate = self
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(AutoLayoutCollectionViewCell2.self, forCellWithReuseIdentifier: String(describing: AutoLayoutCollectionViewCell2.self))
        collectionView.set(superview: bgView, delegate: self, dataSource: self, viewController: self)
        
        let switchButtonBg = UIImageView()
        switchButtonBg.set(superview: contentView, imageName: "groupBar_gradientMask")
        switchButtonBg.setFrame(right: 0, top: 0, width: 72, height: 48)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: contentView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: 12, top: 10, width: 28, height: 28)
    }
    
    
    // MARK: - 代理方法
    // MARK: - CollectionView 代理方法
    
    // 设置数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSource.count
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
        let data = dateSource[indexPath.row]
        cell.setData(title: data["title"] ?? "")
        
        return cell
    }
    
    
    // MARK: - AutoLayoutCollectionViewLayoutDelegate 代理方法
    
    func fetchTitleWidths() -> [CGFloat] {
        var titleWidths: [CGFloat] = []
        for i in 0..<dateSource.count {
            // ⚠️这里fontSize和weight要和下面的AutoLayoutCollectionViewCell2中的保持一致
            let width = getLabelWidth(text: dateSource[i]["title"] ?? "", fontSize: 14, weight: .medium)
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
