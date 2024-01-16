import UIKit

import UIKit

private class DataManager: DefaultSectionAndCellDataManager {
    init() {
        super.init(initialItems: [
            DefaultSection(
                cells: [
                    .titleNextVC(title: "标题1", viewController: CSGeneralSubpage()),
                    .titleNextVC(title: "标题2", viewController: CSGeneralSubpage()),
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


class ViewController: UIViewController {
    
    
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
        
        let myView = UIView()
        myView.setup(superview: view, backgroundColor: cRed_FF635A)
        myView.setFrame(left: 30, top: 200, right: 30, bottom: 300)
        
        let titleVCView = DefaultViewOfCell(cornerType: .allCorners)
        titleVCView.setup(superview: myView)
        titleVCView.setFrame(left: 0, top: 100, right: 0, height: k2LineCellHeight)
        titleVCView.configure(cellType: .titleMiddleIconRightIcon, title: "提醒", description: "kwkw", middleIconName: "mine_aboutAs")
        titleVCView.onTap = {
            let smallActionSheet = SmallActionSheet(viewFrameInWindow: titleVCView.getFrameInWindow())
            self.present(smallActionSheet, animated: true, completion: nil)
        }
        
    }
    
}


// MARK: - 视图控制器
class SmallActionSheet: UIViewController {
    private let tableData = DataManager()
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    var viewFrameInWindow: CGRect
    
    // MARK: - 初始化与生命周期方法
    init(viewFrameInWindow: CGRect) {
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
        let item = tableData.cellData(for: indexPath)
        item.pushViewControllerOnTap(from: self)
        tableView.deselectRow(at: indexPath, animated: true)
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
        let sectionItem = tableData.sectionData(for: indexPath.section) // 获取section数据
        let cellCountInSection = tableData.cellCount(in: indexPath.section) // 获取当前 section 的 cell 数量
        cell.prepare(row: indexPath.row, cellCountInSection: cellCountInSection, isWhiteHeader: sectionItem.isWhiteHeader(), isWhiteFooter: sectionItem.isWhiteFooter()) // 配置基本参数
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
        tableView.register(SmallOptionCell.self, forCellReuseIdentifier: SmallOptionCell.identifier)
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, width: 250, height: 300)
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

