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

class CustomTaskListView: UIView {
    // 模仿 TaskListVC 中的属性
    typealias Styles = GroupCollectionViewStyles
    
    enum UIForm {
        case form0
        case form1
    }
    
    private let groupData = DataManager()
    lazy var titles: [String] = groupData.map { $0.title }
    
    var currentUIForm: UIForm = .form0
    var collectionViewContentHeight: CGFloat = 0
    
    // 定义一个 UIViewController 类型的变量
    unowned var parentVC: UIViewController
    var collectionView: UICollectionView!
    let bgView = UIView()

    // 初始化方法
    init(frame: CGRect, viewController: UIViewController) {
        self.parentVC = viewController
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    func setupUI() {
        setupFormViewUI()
        groupData.onItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupFormViewUI() {
        switch currentUIForm {
        case .form0:
            setupOneLineUI()
        case .form1:
            setupMultiLineUI()
        }
    }

    private func setupOneLineUI() {
        self.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: 48)
        
        bgView.removeAllSubviews()
        bgView.setup(superview: self, backgroundColor: cFFF) // 假设 cFFF 已定义
        bgView.setFrame(allEdges: 0)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])

        let buttons = HorizonalScrollingGroupButtonsView(titles: titles, target: parentVC)
        buttons.setup(superview: bgView)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupUI(showsHorizontalScrollIndicator: false, showTrashButton: true)
        buttons.onButtonsTapped = { [unowned self] _ in
            self.parentVC.push(targetVC: CSGeneralSubpage())
        }
        buttons.onSwitchButtonTapped = { [weak self] in
            self?.switchView()
        }
        buttons.onTrashButtonTapped = { [unowned self] in
            self.parentVC.push(targetVC: CSGeneralSubpage())
        }
    }

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
                getLabelWidth(withMaxWidth: 136, text: $0.title, fontSize: Styles.fontSize, weight: Styles.weight)
            }
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: GroupCollectionViewCell.identifier)
        collectionView.setup(superview: bgView, delegate: self, dataSource: self, viewController: parentVC)
        collectionView.setFrame(left: 10, top: 0, right: 10, height: kWithoutNavBarHeight)
        collectionView.setBackgroundColor(color: cRed_FF635A) // ⚠️
    }
    
    
    // MARK: - @objc func
    @objc func switchView() {
        currentUIForm = currentUIForm == .form0 ? .form1 : .form0
        setupUI()
    }

}


// MARK: - UICollectionView 代理方法
extension CustomTaskListView: UICollectionViewDelegate, UICollectionViewDataSource {

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
        let bottomLineHeight: CGFloat = 48 // 底栏(含废纸蒌栏的)高度
        let selfHeight = collectionViewHeight + bottomLineHeight
        // 设置各个View的布局
        self.setFrame(left: 0, bottom: kTabBarHeight, right: 0, height: selfHeight)
        bgView.setFrame(allEdges: 0)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])
        collectionView.setFrame(left: 10, top: 0, right: 10, height: collectionViewHeight)
        
        let bottomView = GroupBottomButtonsView()
        bottomView.setup(superview: bgView, backgroundColor: cFFF)
        bottomView.setFrame(left: 0, bottom: 0, right: 0, height: bottomLineHeight)
        bottomView.setupView(showTrashButton: true)
        bottomView.onTrashButtonTapped = { [unowned self] in
            self.parentVC.push(targetVC: CSGeneralSubpage())
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
        cell.configure(withTitle: titles[indexPath.row]) { [unowned self] in
            self.parentVC.push(targetVC: CSGeneralSubpage())
        }
        return cell
    }
}
