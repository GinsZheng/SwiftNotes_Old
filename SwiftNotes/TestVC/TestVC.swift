import UIKit

private class OptionDataManager: DefaultSectionAndCellDataManager {
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
    private let optionData = OptionDataManager()
    
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
        bgView.setFrame(left: 30, top: 300, right: 30, height: 200)

        button.setup(superview: bgView)
        button.setStyleSolid17ptFgWhiteThemeButton(title: "点击出现小选项表")
        button.setFrame(left: 10, top: 30, right: 10, height: kButtonHeight)
        button.setEvent {
            let optionSheet = OptionSheet(optionData: self.optionData, senderFrameInWindow: self.button.getFrameInWindow())
            optionSheet.onTap = { [weak self] indexPath in
                guard let self = self else { return }
                let item = self.optionData.cellData(for: indexPath)
                item.pushViewControllerOnTap(from: self)
            }
            self.present(targetVC: optionSheet)
        }
        
    }
    
}


// MARK: - 视图控制器
class OptionSheet: UIViewController {
    var onTap: ((IndexPath) -> Void)?     // 回调闭包，当选项被选中时，传递 IndexPath
    
    private let optionData: DefaultSectionAndCellDataManager
    private var senderFrameInWindow: CGRect
    
    private let maskView = UIView()
    private let bgView = UIView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - 初始化与生命周期方法
    init(optionData: DefaultSectionAndCellDataManager, senderFrameInWindow: CGRect) {
        self.optionData = optionData
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
        // 完成tableView内容加载后，重设tableView和及其bgView的布局(因为tableView的高度与位置依据内容高度而定)
        setTableViewFrame()
    }
    
}


// MARK: - 代理方法：tableView
extension OptionSheet: UITableViewDelegate, UITableViewDataSource {
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTap?(indexPath) // 点击事件放在父VC中定义
        self.dismiss(animated: false)
    }
    
    // 表头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerItem = optionData.sectionData(for: section).header ?? .noheader
        return headerItem.setHeaderHeight()
    }
    
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellItem = optionData.cellData(for: indexPath)
        return cellItem.getCellHeight(oneLineCellHeight: kOptionSheetCellHeight)
    }
    
    // 表尾高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == optionData.sectionCount() - 1 ? 0 : kVertMargin // 最后一个section不设footer高度
    }
    
    // 组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return optionData.sectionCount()
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionData.cellCount(in: section)
    }
    
    // 表头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = DefaultHeader()
        let headerItem = optionData.sectionData(for: section).header ?? .noheader
        headerItem.configureHeader(header)
        return header
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionSheetCell.identifier, for: indexPath) as? OptionSheetCell else { return UITableViewCell() }
        // 第一个和最后一个设为圆角 (设为true时会让每个section第一个和最后一个cell的不设圆角)
        let isWhiteHeader = indexPath.section == 0 && indexPath.row == 0 ? false : true
        let isWhiteFooter = indexPath.section == optionData.sectionCount() - 1 && indexPath.row == optionData.cellCount(in: optionData.sectionCount() - 1) - 1 ? false : true
        let cellCountInSection = optionData.cellCount(in: indexPath.section) // 获取当前 section 的 cell 数量
        cell.prepare(row: indexPath.row, cellCountInSection: cellCountInSection, isWhiteHeader: isWhiteHeader, isWhiteFooter: isWhiteFooter) // 配置基本参数
        let cellItem = optionData.cellData(for: indexPath) // 获取cell数据
        cellItem.configureCell(cell) // 配置Cell数据与UI
        return cell
    }
    
    // 表尾视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}


// MARK: - 代理方法：透明遮罩点击手势
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
        bgView.setCornerRadius(radius: kRadius)
        bgView.setShadow(y: 2, radius: 32)
        
        tableView.register(OptionSheetCell.self, forCellReuseIdentifier: OptionSheetCell.identifier)
        tableView.setup(superview: bgView, delegate: self, dataSource: self, viewController: self)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0) // 消除多余的底部空间
        // 数据更新时刷新列表
        optionData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    // 根据控件位置设置tableView的位置
    private func setTableViewFrame() {
        let tableMaxHeight: CGFloat = 472 // 最大高度472为10.5行
        let contentHeight = tableView.getContentHeight(maxHeight: tableMaxHeight)
        
        let senderCenterX = senderFrameInWindow.midX
        let senderCenterY = senderFrameInWindow.midY
        let senderTop = senderFrameInWindow.origin.y
        let senderBottom = senderFrameInWindow.maxY
        
        // 确定 x 位置
        var x: CGFloat = 0
        if abs(senderCenterX - kScreenWidth/2) <= 3 { // 在中间 (中线左右3pt范围内都算中间)
            x = (kScreenWidth - kOptionSheetCellWidth) / 2
        } else if senderCenterX <= kScreenWidth / 2 { // 在左边
            x = kEdgeMargin
        } else { // 在右边
            x = kScreenWidth - kEdgeMargin - kOptionSheetCellWidth
        }
        
        // 确定 y 位置
        var y: CGFloat = 0
        let isBelowSheet = senderCenterY <= kStatusBarHeight + kWithoutStatusAndBottomBarHeight/2 // 指触发控件在上半部分，选项表在下
        if isBelowSheet { // 下
            let sheetBottom: CGFloat = senderBottom + kVertMargin + contentHeight  // 列表底部坐标
            if sheetBottom + kVertMargin <= kHomeBarTop { // 选项列表未超出安全区域：下邻
                // 下邻
                y = senderBottom + kVertMargin
            } else {
                // 下边
                y = kScreenHeight - kHomeBarHeight - kVertMargin - contentHeight
            }
        } else { // 上
            let sheetTop: CGFloat = senderTop - kVertMargin - contentHeight // 列表顶部坐标
            if sheetTop - kVertMargin >= kStatusBarHeight { // 选项列表未超出安全区域：上邻
                // 上邻
                y = sheetTop
            } else {
                // 上边
                y = kStatusBarHeight + kVertMargin
            }
        }
        
        bgView.setFrame(left: x, top: y, width: kOptionSheetCellWidth, height: contentHeight)
        tableView.setFrame(allEdges: 0)
        tableView.setCornerRadiusWithMask(radius: kRadius)
        if contentHeight < tableMaxHeight { tableView.isScrollEnabled = false }
    }
    
}


// MARK: - 选项列表cell (是在默认cell的基础上，做了少量布局的调整，因此数据配置上完全一致)
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

