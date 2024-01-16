import UIKit

class ViewController: UIViewController {
    private let tableData = DataManager()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - 私有方法
extension ViewController {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        
        let bgView = UIView()
        bgView.setup(superview: view, backgroundColor: cFgWhite)
        bgView.setFrame(left: 30, top: 200, right: 30, height: 200)

        let button = UIButton(type: .custom)
        button.setup(superview: bgView)
        button.setStyleSolid17ptFgWhiteThemeButton(title: "点击出现小选项表")
        button.setFrame(left: 10, top: 30, right: 10, height: kButtonHeight)
        button.setEvent {
            let smallActionSheet = SmallActionSheet(tableData: self.tableData, viewFrameInWindow: button.getFrameInWindow())
            smallActionSheet.didSelectItem = { [weak self] indexPath in
                guard let self = self else { return }
                let item = self.tableData.cellData(for: indexPath)
                item.pushViewControllerOnTap(from: self)
            }
            self.present(smallActionSheet, animated: true, completion: nil)
        }
        
    }
    
}


private class DataManager: DefaultSectionAndCellDataManager {
    init() {
        super.init(initialItems: [
            DefaultSection(
                cells: [
                    .titleNextVC(title: "标题1", viewController: ButtonPage()),
                    .titleNextVC(title: "标题2", viewController: AnimationPage()),
                ]
            ),
            DefaultSection(
                cells: [
                    .titleNextVC(title: "标题3", viewController: CSGeneralSubpage()),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
                    .titleDesc(title: "标题4", description: "hey"),
//                    .titleDesc(title: "标题4", description: "hey"),
//                    .titleDesc(title: "标题4", description: "hey"),
//                    .titleDesc(title: "标题4", description: "hey"),
//                    .titleDesc(title: "标题4", description: "hey"),
                    
                ]
            ),
        ])
    }
}


// MARK: - 视图控制器
class SmallActionSheet: UIViewController {
    var didSelectItem: ((IndexPath) -> Void)?     // 回调闭包，当选项被选中时，传递 IndexPath
    
    private let tableData: DefaultSectionAndCellDataManager
    private var viewFrameInWindow: CGRect
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - 初始化与生命周期方法
    init(tableData: DefaultSectionAndCellDataManager, viewFrameInWindow: CGRect) {
        self.tableData = tableData
        self.viewFrameInWindow = viewFrameInWindow
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 将tableView的高度设为视图内容的高度
//        tableView.height = tableView.getContentHeight(maxHeight: 472) // 472高度为10.5行

        setTableViewFrame()
    }
    
}


// MARK: - 代理方法：tableView
extension SmallActionSheet: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem?(indexPath)
        self.dismiss(animated: false)
    }
    
    // 表头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerItem = tableData.sectionData(for: section).header ?? .noheader
        return headerItem.setHeaderHeight()
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellItem = tableData.cellData(for: indexPath)
        return cellItem.getCellHeight(oneLineCellHeight: kSmallOptionCellHeight)
    }
    
    // 表尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == tableData.sectionCount() - 1 ? 0 : kVertMargin
    }
    
    // 组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.sectionCount()
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.cellCount(in: section)
    }
    
    // 表头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DefaultHeader()
        let headerItem = tableData.sectionData(for: section).header ?? .noheader
        headerItem.configureHeader(header)
        return header
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallOptionCell.identifier, for: indexPath) as? SmallOptionCell else { return UITableViewCell() }
        let cellCountInSection = tableData.cellCount(in: indexPath.section) // 获取当前 section 的 cell 数量
        cell.prepare(row: indexPath.row, cellCountInSection: cellCountInSection, isWhiteHeader: true, isWhiteFooter: true) // 配置基本参数
        // 注：这里isWhiteHeader/Footer都设为true是因为：设为true时会让每个section第一个和最后一个cell的不设圆角，而这正是在小选项表中所需要的
        let cellItem = tableData.cellData(for: indexPath)  // 获取cell数据
        cellItem.configureCell(cell) // 配置Cell数据与UI
        return cell
    }
    
    // 表尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}


// MARK: - 代理方法：透明遮罩手势
extension SmallActionSheet: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // 如果触摸的视图是 tableView，则不接收手势
        if let view = touch.view, view.isDescendant(of: tableView) {
            return false
        }
        return true
    }
}


// MARK: - 私有方法
extension SmallActionSheet {
    private func setupUI() {
        let bgView = UIView()
        bgView.setup(superview: view, backgroundColor: cNoColor)
        bgView.setFrame(allEdges: 0)
        bgView.setTapAction(delegate: self) {
            self.dismiss()
        }
        
        tableView.register(SmallOptionCell.self, forCellReuseIdentifier: SmallOptionCell.identifier)
        tableView.setup(superview: bgView, delegate: self, dataSource: self, viewController: self)
        tableView.width = kSmallOptionCellWidth
        setTableViewFrame()
        // 对于iOS 15.0.由于会有一个默认分组外边距，所以需要做调整，而15.0之前的默认无此外边距，无需处理
        tableView.hideSectionHeaderTopPadding()
        tableView.setCornerRadiusWithMask(radius: kRadius)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    // 根据控件位置设置tableView的位置
    private func setTableViewFrame() {
        let tableMaxHeight: CGFloat = 472
        let contentHeight = tableView.getContentHeight(maxHeight: tableMaxHeight) // 472高度为10.5行
//        let contentHeight = tableView.getContentHeight(maxHeight: 472) // 472高度为10.5行
//        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets.zero
        
        let viewCenterX = viewFrameInWindow.midX
        let viewCenterY = viewFrameInWindow.midY
        let viewtop = viewFrameInWindow.origin.y
        let viewBottom = viewFrameInWindow.maxY
        
        // 确定 x 位置
        var x: CGFloat = 0
        if abs(viewCenterX - kScreenWidth/2) <= 3 { // 在中间
            x = (kScreenWidth - kSmallOptionCellWidth) / 2
        } else if viewCenterX <= kScreenWidth / 2 { // 在左边
            x = kEdgeMargin
        } else { // 在右边
            x = kScreenWidth - kEdgeMargin - kSmallOptionCellWidth
        }
        
        // 确定 y 位置
        var y: CGFloat = 0
        let isBelowView = viewCenterY <= kStatusBarHeight + kWithoutStatusAndBottomBarHeight/2 // 指触发控件在上半部分，选项表在下
        if isBelowView { 
            // 下
            var tableBottom: CGFloat = viewBottom + contentHeight + kVertMargin // 列表底部坐标
            if tableBottom < kHomeBarTop { // 选项列表未超出安全区域：下邻
                // 下邻 (选项列表未超出安全区域)
                y = viewBottom + kVertMargin
            } else {
                // 下边
                print("hey, done")
                y = kScreenHeight - kHomeBarTop - kVertMargin - tableMaxHeight
            }
            
//            if tableView.frame.height > maxTableViewHeight {
//                // 边
//                y = kScreenHeight - safeAreaInsets.bottom - tableView.frame.height
//            }
        } else {
            // 上
//            tableBottom = viewBottom + contentHeight + kVertMargin // 列表底部坐标
            y = viewFrameInWindow.minY - tableView.frame.height - kVertMargin
//            if tableView.frame.height > maxTableViewHeight {
//                // 边
//                y= safeAreaInsets.top
//            }
        }
        
        

        tableView.setFrame(left: x, top: y, width: kSmallOptionCellWidth, height: contentHeight)
        
        
    }
    
}


class SmallOptionCell: DefaultCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellWidth = kSmallOptionCellWidth
        self.cellHeight = kSmallOptionCellHeight
        self.bgViewEdgeMargin = 0
        self.updateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

