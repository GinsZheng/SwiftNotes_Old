import UIKit

private class DataManager: BaseDataManager<DefaultTableViewItem> {
    init() {
        super.init(initialItems: [
            DefaultTableViewItem(title: "Animation", viewController: CSGeneralSubpage()),
            DefaultTableViewItem(title: "Button", viewController: CSGeneralSubpage()),
        ])
    }
}


class Test1VC: UIViewController {
    
    private let tableData = DataManager()
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        tableView.register(DefaultTableViewCell22.self, forCellReuseIdentifier: DefaultTableViewCell22.identifier)
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        // 数据更新时刷新列表
        tableData.onItemsUpdated = {  [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - @objc func
    
}


// MARK: - 代理方法：UITableViewDelegate, UITableViewDataSource
extension Test1VC: UITableViewDelegate, UITableViewDataSource {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: tableData[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell22.identifier, for: indexPath) as? DefaultTableViewCell22 else { return UITableViewCell() }
        cell.configure(title: tableData[indexPath.row].title)
        return cell
    }
}


// MARK: - 自定义的 tableViewCell
class DefaultTableViewCell22: UITableViewCell {
    
    static let identifier = String(describing: DefaultTableViewCell22.self)
    
    private let titleLabel = UILabel()
    private let nextIcon = UIImageView()
    private let separator = UIView()
    
    
    // MARK: - 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - func
    // 设置控件非布局内容 (严谨说是一次性设置的内容，这通常都是非布局内容)
    private func setupUI() {
        titleLabel.setup(superview: contentView)
        titleLabel.setStyle17pt222()
        
        nextIcon.setup(superview: contentView, imageName: "next")
        
        separator.setup(superview: contentView, backgroundColor: cSeparator)
        
    }
    
    // 设置控件布局 (严谨说是布局刷新时需要刷新的内容，这通常都是布局内容)
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.setFrame(left: 16, centerY: contentView.centerY)
        nextIcon.setFrame(right: 16, centerY: contentView.centerY, width: 18, height: 18)
        separator.setSeparatorFrame(left: 16, right: 16)
    }
    
    // 配置数据
    func configure(title: String) {
        titleLabel.text = title
    }
    
}

