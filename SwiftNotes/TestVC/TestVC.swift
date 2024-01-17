import UIKit

private class OptionsDataManager: DefaultSectionAndCellDataManager {
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
                ]
            ),
        ])
    }
}

class ViewController: UIViewController {
    private let tableData = OptionsDataManager()
    
    private let bgView = UIView()
    private let button = UIButton(type: .custom)
    
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

        bgView.setup(superview: view, backgroundColor: cFgWhite)
        bgView.setFrame(left: 30, top: 100, right: 30, height: 200)

        button.setup(superview: bgView)
        button.setStyleSolid17ptFgWhiteThemeButton(title: "点击出现小选项表")
        button.setFrame(left: 10, top: 30, right: 10, height: kButtonHeight)
        button.setEvent {
            let optionSheet = OptionSheet(tableData: self.tableData, senderFrameInWindow: self.button.getFrameInWindow())
            optionSheet.onTap = { [weak self] indexPath in
                guard let self = self else { return }
                let item = self.tableData.cellData(for: indexPath)
                item.pushViewControllerOnTap(from: self)
            }
            self.present(targetVC: optionSheet)
        }
        
    }
    
}




// MARK: - 视图控制器
class OptionSheet: UIViewController {
    var onTap: ((IndexPath) -> Void)?     // 回调闭包，当选项被选中时，传递 IndexPath
    
    private let tableData: DefaultSectionAndCellDataManager
    private var senderFrameInWindow: CGRect
    
    private let maskView = UIView()
    private let bgView = UIView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - 初始化与生命周期方法
    init(tableData: DefaultSectionAndCellDataManager, senderFrameInWindow: CGRect) {
        self.tableData = tableData
        self.senderFrameInWindow = senderFrameInWindow
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
extension OptionSheet: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTap?(indexPath)
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
        return cellItem.getCellHeight(oneLineCellHeight: kOptionSheetCellHeight)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionSheetCell.identifier, for: indexPath) as? OptionSheetCell else { return UITableViewCell() }
        // 第一个和最后一个设为圆角 (设为true时会让每个section第一个和最后一个cell的不设圆角)
        let isWhiteHeader = indexPath.section == 0 && indexPath.row == 0 ? false : true
        let isWhiteFooter = indexPath.section == tableData.sectionCount() - 1 && indexPath.row == tableData.cellCount(in: tableData.sectionCount() - 1) - 1 ? false : true
        let cellCountInSection = tableData.cellCount(in: indexPath.section) // 获取当前 section 的 cell 数量
        cell.prepare(row: indexPath.row, cellCountInSection: cellCountInSection, isWhiteHeader: isWhiteHeader, isWhiteFooter: isWhiteFooter) // 配置基本参数
        let cellItem = tableData.cellData(for: indexPath) // 获取cell数据
        cellItem.configureCell(cell) // 配置Cell数据与UI
        return cell
    }
    
    // 表尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}


// MARK: - 代理方法：透明遮罩手势
extension OptionSheet: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // 如果触摸的视图是 tableView，则不接收手势
        if let view = touch.view, view.isDescendant(of: tableView) {
            return false
        }
        return true
    }
}


// MARK: - 私有方法
extension OptionSheet {
    private func setupUI() {
        maskView.setup(superview: view, backgroundColor: cNoColor)
        maskView.setFrame(allEdges: 0)
        maskView.setTapAction(delegate: self) {
            self.dismiss()
        }
        
        // 设置tableView的背景(用于加投影，而tableView则加带遮罩圆角)
        bgView.setup(superview: maskView)
        bgView.setFrame(allEdges: 0)
        bgView.setCornerRadius(radius: kRadius)
        bgView.setShadow(y: 2, radius: 32)
        
        tableView.register(OptionSheetCell.self, forCellReuseIdentifier: OptionSheetCell.identifier)
        tableView.setup(superview: bgView, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(allEdges: 0)
        // 对于iOS 15.0.由于会有一个默认分组外边距，所以需要做调整，而15.0之前的默认无此外边距，无需处理
        tableView.hideSectionHeaderTopPadding()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    // 根据控件位置设置tableView的位置
    private func setTableViewFrame() {
        let tableMaxHeight: CGFloat = 472
        let contentHeight = tableView.getContentHeight(maxHeight: tableMaxHeight) // 472高度为10.5行
        
        let viewCenterX = senderFrameInWindow.midX
        let viewCenterY = senderFrameInWindow.midY
        let viewtop = senderFrameInWindow.origin.y
        let viewBottom = senderFrameInWindow.maxY
        
        // 确定 x 位置
        var x: CGFloat = 0
        if abs(viewCenterX - kScreenWidth/2) <= 3 { // 在中间
            x = (kScreenWidth - kOptionSheetCellWidth) / 2
        } else if viewCenterX <= kScreenWidth / 2 { // 在左边
            x = kEdgeMargin
        } else { // 在右边
            x = kScreenWidth - kEdgeMargin - kOptionSheetCellWidth
        }
        
        // 确定 y 位置
        var y: CGFloat = 0
        let isBelowView = viewCenterY <= kStatusBarHeight + kWithoutStatusAndBottomBarHeight/2 // 指触发控件在上半部分，选项表在下
        if isBelowView { // 下
            let tableBottom: CGFloat = viewBottom + kVertMargin + contentHeight + kVertMargin // 列表底部加间隔后的坐标
            if tableBottom <= kHomeBarTop { // 选项列表未超出安全区域：下邻
                // 下邻
                y = viewBottom + kVertMargin
            } else {
                // 下边
                y = kScreenHeight - kHomeBarHeight - kVertMargin - contentHeight
            }
        } else { // 上
            let tableTop: CGFloat = viewtop - kVertMargin - contentHeight - kVertMargin // 列表顶部加间隔后的坐标
            if tableTop >= kStatusBarHeight { // 选项列表未超出安全区域：上邻
                // 上邻
                y = tableTop + kVertMargin
            } else {
                // 上边
                y = kStatusBarHeight + kVertMargin
            }
        }
        
        bgView.setFrame(left: x, top: y, width: kOptionSheetCellWidth, height: contentHeight)
        tableView.setFrame(allEdges: 0)
        tableView.setCornerRadiusWithMask(radius: kRadius)
        if contentHeight < 472 { tableView.isScrollEnabled = false }
    }
    
}


class OptionSheetCell: DefaultCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellWidth = kOptionSheetCellWidth
        self.cellHeight = kOptionSheetCellHeight
        self.bgViewEdgeMargin = 0
        self.updateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

