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

class CustomTaskListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
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
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setupUI() {
        setupCommonUI()
        setupFormViewUI()
        
        groupData.onItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupCommonUI() {
        self.setBackgroundColor(color: cBgGray) // 假设 cBgGray 已定义
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
        bgView.removeAllSubviews()
        bgView.setup(superview: self, backgroundColor: cFFF) // 假设 cFFF 已定义
        bgView.setFrame(left: 0, bottom: 0, right: 0, height: 48)
        bgView.setEachCornerRadiusWithMask(radius: 10, corners: [.topLeft, .topRight])

        let buttons = HorizonalScrollingGroupButtonsView(titles: titles, target: parentVC)
        buttons.setup(superview: bgView)
        buttons.setFrame(left: 0, top: 0, right: 0, height: 48)
        buttons.setupUI(showsHorizontalScrollIndicator: false, showTrashButton: true)
        buttons.onButtonsTapped = { [unowned self] _ in
            self.parentVC.push(toTarget: CSGeneralSubpage())
        }
//        buttons.onSwitchButtonTapped = { [unowned self] in
//            self.switchView()
//        }
//        buttons.onTrashButtonTapped = { [weak self] in
//            // 你的垃圾按钮点击逻辑
//        }
    }

    private func setupMultiLineUI() {
        // 实现多行视图布局
        // ...
    }

    // MARK: - UICollectionViewDelegate & DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupData.count
    }
    
    // 设置 cell 逻辑
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCollectionViewCell.identifier, for: indexPath) as? GroupCollectionViewCell else { return UICollectionViewCell() }
        // 把UI逻辑放在自定义的 CollectionViewCell，把数据放在此
        cell.configure(withTitle: titles[indexPath.row]) { [unowned self] in
            self.parentVC.push(toTarget: CSGeneralSubpage())
        }
        
        return cell
    }
    // ⚠️继续封装
    // 可能还需要其他代理方法的实现
    // ...
}
