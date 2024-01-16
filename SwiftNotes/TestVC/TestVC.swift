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
        bgView.setFrame(left: 30, top: 100, right: 30, height: 200)

        let button = UIButton(type: .custom)
        button.setup(superview: bgView)
        button.setStyleSolid17ptFgWhiteThemeButton(title: "点击出现小选项表")
        button.setFrame(left: 10, top: 30, right: 10, height: kButtonHeight)
        button.setEvent {
            let smallActionSheet = SmallActionSheet(tableData: self.tableData, viewFrameInWindow: button.getFrameInWindow())
            smallActionSheet.didSelectItem = { [weak self] indexPath in
//                self?.push(targetVC: CSGeneralSubpage())
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
                    .titleDesc2Line(title: "标题4", description: "hey"),
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
    
}


// MARK: - 代理方法
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
        let footerItem = tableData.sectionData(for: section).footer ?? .nofooter
        return footerItem.setFooterHeight()
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
        let footer = DefaultFooter()
        let footerItem = tableData.sectionData(for: section).footer ?? .nofooter
        footerItem.configureFooter(footer)
        return footer
    }
    
}


// MARK: - 私有方法
extension SmallActionSheet {
    private func setupUI() {
        let bgView = UIView()
        bgView.setup(superview: view, backgroundColor: cNoColor)
        bgView.setFrame(allEdges: 0)
        bgView.setTapAction {
            self.dismiss()
        }
        
        tableView.register(SmallOptionCell.self, forCellReuseIdentifier: SmallOptionCell.identifier)
        tableView.setup(superview: bgView, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 120, width: kSmallOptionCellWidth, height: 300)
        // 对于iOS 15.0.由于会有一个默认分组外边距，所以需要做调整，而15.0之前的默认无此外边距，无需处理
        tableView.hideSectionHeaderTopPadding()
        // 数据更新时刷新列表
        tableData.onItemsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}


class SmallOptionCell: DefaultCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellWidth = kSmallOptionCellWidth
        self.cellHeight = kSmallOptionCellHeight
        self.updateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

