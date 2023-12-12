import UIKit

private class DataManager: BaseDataManager<DefaultTableViewItem> {
    init() {
        super.init(initialItems: [
            DefaultTableViewItem(title: "Animation", viewController: CSGeneralSubpage()),
            DefaultTableViewItem(title: "Button", viewController: CSGeneralSubpage()),
        ])
    }
}


class ViewController: UIViewController {
    
    private let tableData = DataManager()
    var sectionExpanded: [Bool] = [true, true, false]
    let headerHeight: CGFloat = 44
    
    let tableView = UITableView()
    
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        tableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: DefaultTableViewCell.identifier)
        tableView.set(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 0, right: 0, height: kWithoutNavBarHeight)
        
        tableData.onItemsUpdated = {  [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    
    // MARK: - @objc func
    
    
}


// MARK: - 代理方法：UITableViewDelegate
extension ViewController: UITableViewDelegate {
    // 行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellHeight
    }
    
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(toTarget: tableData[indexPath.row].viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - 代理方法：UITableViewDataSource
extension ViewController: UITableViewDataSource {
    // 组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionExpanded.count
    }
    
    // 行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionExpanded[section] ? tableData.count : 0
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.identifier, for: indexPath) as? DefaultTableViewCell else { return UITableViewCell() }
        cell.configure(title: tableData[indexPath.row].title)
        return cell
    }
    
    // 表头
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        titleLabel.text = "已完成"
        titleLabel.setStyle17pt222()
        titleLabel.setFrame(left: 0, top: 0, width: 100, height: 148)
        
        return titleLabel
    }
    
    // 表头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
}


// ❓对于有多个section的内容，应该怎么写数据结构
